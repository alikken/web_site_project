
from datetime import datetime
from django.http import HttpResponseForbidden, JsonResponse
from django.shortcuts import get_object_or_404, render, redirect
from .models import Cinema, CityLocation, Hall, Movie, Rating, Seat, ShowMovie, Ticket

from django.views.generic import View, ListView, DetailView
from django.http.request import HttpRequest
from .serializers import CinemaSerializer, HallSerializer
from rest_framework import generics
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core import serializers
import json

from django.db.models import Avg


class HomePage(View):
    def get(self, request):
        cities = CityLocation.objects.all()
        cinema_list = Cinema.objects.all()
        print(cinema_list)
        movies = Movie.objects.all()
        movie_top = movies.annotate(avg_rating=Avg("rating__rating")).order_by("-avg_rating")
        
        context_dict = {"city_list": cities, "cinema_list": cinema_list, "movie_title": movies, 'movie_top': movie_top}
        return render(request, 'cinema_city/homepage.html', context_dict)

class CinemaDetailView(View):
    def get(self, request, slug):
        cinema = Cinema.objects.get(url=slug)
        halls = Hall.objects.filter(cinema=cinema)

        # show_movies = []

        # for hall in halls:
        #     show_movies.extend(hall.show_movie.all())
            
        return render(request, 'cinema_city/cinema_detail.html', {"cinema": cinema, "halls": halls})

class CinemasListView(generics.ListAPIView):
    serializer_class = CinemaSerializer
    def get_queryset(self):
        queryset = Cinema.objects.filter(city=CityLocation.objects.get(pk=self.request.GET.get('city_id'))).all()
        print(queryset)
        return queryset
    

class MoviePage(View):
    def get(self, request, slug):
        movie = Movie.objects.get(url=slug)

        halls = Hall.objects.filter(show_movie__movie=movie)
        
        if request.user.is_authenticated:
            rating = Rating.objects.filter(movie=movie, user=request.user.customuser).first()
            movie.user_rating = rating.rating if rating else 0
        
        
        else:
             movie.user_rating = 0
       
        
        return render(request, 'cinema_city/moviePage.html', {'moviepage': movie, 'halls': halls})
    

# @login_required
def rate(request, movie_id: int, rating: int):
    
    movie = Movie.objects.get(url=movie_id)
    Rating.objects.filter(movie=movie, user=request.user.customuser).delete()
    movie.rating_set.create(user=request.user.customuser, rating=rating)
    movie_page = MoviePage()
    return movie_page.get(request=request, slug=movie.url)
    

class BookTickets(View):
    template_name = "cinema_city/seats_hall.html"
    
    def get(self, request, hall_id, *args, **kwargs):
        hall = Hall.objects.get(id=hall_id)
        seats_busy = Seat.objects.filter(hall=hall)
        seats = []

        for i in range(1, hall.row_count+1):
            row = []
            for j in range(1, hall.col_count+1):
                is_busy = False
                for seat in seats_busy:
                    if seat.row == i and seat.col == j:
                        is_busy = True
                        break
                row.append((i, j, is_busy))
            seats.append(row)
        print("FFFFFFFFFFFF", seats)

        context = {
            'hall': hall,
            'seats': seats,
        }
        return render(request, "cinema_city/seats_hall.html", context)
    
    def post(self, request, hall_id, *args, **kwargs):
        if request.method == 'POST':
            seat_ids = request.POST.getlist('seat_id')
            user = request.user

            if not user.is_authenticated:
                return HttpResponseForbidden()
            
            hall = Hall.objects.get(id=hall_id)
            tickets = []

            for seat_id in seat_ids:
                row, col = seat_id.split()
                seat = Seat.objects.create(hall=hall, row=int(row), col=int(col))

                ticket = Ticket.objects.create(
                    user=user.customuser,
                    price=1500,  
                    seat_number=seat,
                    date=datetime.now(),
                )
                tickets.append(ticket)
       
        return redirect('home')



def get_seats_by_hall(request, hall_id):
    hall = serializers.serialize("json", Hall.objects.filter(id=hall_id))
    
    hall = Hall.objects.get(id=hall_id)
    seats_busy = Seat.objects.filter(hall=hall)
    seats = []

    for i in range(1, hall.row_count+1):
        row = []
        for j in range(1, hall.col_count+1):
            is_busy = False
            for seat in seats_busy:
                if seat.row == i and seat.col == j:
                    is_busy = True
                    break
            row.append((i, j, is_busy))
        seats.append(row)
    print("FFFFFFFFFFFF", seats)
    return JsonResponse(seats, safe=False)




class TicketList(ListView):
    model = Ticket
    template_name = 'cinema_city/ticket.html' 
    context_object_name = 'tickets' 

    def get_queryset(self):
        queryset = super().get_queryset()

        return queryset.filter(user=self.request.user.customuser )
    
class TicketCheck(DetailView):
    model = Ticket
    template_name = 'cinema_city/ticketChek.html'
    context_object_name = 'ticket'
     