from django.shortcuts import get_object_or_404, render
from .models import Cinema, CityLocation, Movie

from django.views.generic import View
from django.http.request import HttpRequest
from .serializers import CinemaSerializer
from rest_framework import generics



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
        # cinema = get_object_or_404(Cinema, url=slug)
        # print('FSDFSDFSD'+ cinema)
        return render(request, 'cinema_city/cinema_detail.html', {"cinema": cinema})

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