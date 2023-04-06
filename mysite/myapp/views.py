from django.shortcuts import render
from .models import Cinema, CityLocation
from django.views.generic import View
from django.http.request import HttpRequest
from .serializers import CinemaSerializer
from rest_framework import generics



class HomePage(View):

    def get(self, request):
        cities = CityLocation.objects.all()
        cinema_list = Cinema.objects.all()
        context_dict = {"city_list": cities, "cinema_list": cinema_list,}

        return render(request, 'cinema_city/index.html', context_dict)

class CinemaDetailView(View):
    def get(self, request, slug):
        cinema = Cinema.objects.get(url=slug)

        return render(request, 'cinema_city/cinema_detail.html', {"cinema": cinema})

class CinemasListView(generics.ListAPIView):
    serializer_class = CinemaSerializer
    
    def get_queryset(self):
        queryset = Cinema.objects.filter(city=CityLocation.objects.get(pk=self.request.GET.get('city_id'))).all()
        print(list(queryset))
        
        return queryset
    



