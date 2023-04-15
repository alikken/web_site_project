
from datetime import datetime
from django.http import HttpResponseForbidden, JsonResponse
from django.shortcuts import get_object_or_404, render, redirect
from .models import Cinema, CityLocation, Hall, Movie, Seat, Ticket

from django.views.generic import View, ListView
from django.http.request import HttpRequest
from .serializers import CinemaSerializer
from rest_framework import generics
from django.contrib import messages


class HomePage(View):
    def get(self, request):
        cities = CityLocation.objects.all()
        cinema_list = Cinema.objects.all()
        movie = Movie.objects.all()
        context_dict = {"city_list": cities, "cinema_list": cinema_list, "movie_title": movie}
        return render(request, 'cinema_city/homepage.html', context_dict)

class CinemaDetailView(View):
    def get(self, request, slug):
        cinema = Cinema.objects.get(url=slug)
        halls = Hall.objects.filter(cinema=cinema)

        print('SFSEFSEFSEF', halls)
        return render(request, 'cinema_city/cinema_detail.html', {"cinema": cinema, "halls": halls})

class CinemasListView(generics.ListAPIView):
    serializer_class = CinemaSerializer

    def get_queryset(self):
        queryset = Cinema.objects.filter(city=CityLocation.objects.get(pk=self.request.GET.get('city_id'))).all()
        print(f'fsdfsdfsdf {queryset}')
        print(CityLocation.objects.get(pk=self.request.GET.get('city_id')))
        print(self.request.GET.get('city_id'))
        
        return queryset
    

class MoviePage(View):
    def get(self, request, slug):
        movie = Movie.objects.get(url=slug)
        return render(request, 'cinema_city/moviePage.html', {'moviepage': movie})
    

class BookTickets(View):
    
    template_name = "cinema_city/seats_hall.html"


    def get(self, request, hall_id, *args, **kwargs):
        print('dsfsdfsdfsdfsdfsdfsdfsdf')
        
        hall = Hall.objects.get(id = hall_id)
        cinema = Hall.cinema
        print(cinema)
        seats = []

        for i in range(1, hall.row_count):
            row = []
            
            for j in range(1, hall.col_count):
                row.append((i, j))
            seats.append(row)
        # print(seats)

        context = {
            'hall': hall,
            'seats': seats,
        }

        return render(request, "cinema_city/seats_hall.html", context)
    

    def post(self, request, hall_id, *args, **kwargs):
        print('SFSEFSEFSEFSEFSEFSEFSEFSEFSEFS')
        if request.method == 'POST':
            seat_ids = request.POST.getlist('seat_id')
            print(seat_ids)
            user = request.user
            print(user)

            if not user.is_authenticated:
                return HttpResponseForbidden()
            
            hall = Hall.objects.get(id=hall_id)
            tickets = []
            for seat_id in seat_ids:
                l = row, col = seat_id.split()
                print('fdsfsdfsdfsdfsdfsdfd', int(l[0]))
                seat = Seat.objects.create(hall = hall,  row = int(l[0]), col = int(l[1]))
                # seat = Seat.objects.get(id=seat_id)

                ticket = Ticket.objects.create(
                    user=user.customuser,
                    price=1500,  
                    seat_number=seat,
                    date=datetime.now(),
                )
                tickets.append(ticket)
        # return redirect('home', ticket_id=ticket.id)
        return redirect('home')
    


class TicketList(ListView):
    model = Ticket
    template_name = 'cinema_city/ticket.html' 
    context_object_name = 'tickets' 

    def get_queryset(self):
        queryset = super().get_queryset()
        print('sdfsefesfsefsfsef', queryset)
        print(queryset.filter(user=self.request.user.customuser))
        return queryset.filter(user=self.request.user.customuser )
    

class TicketCheck(View):
    pass 