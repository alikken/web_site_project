from django.shortcuts import render
from .models import Cinema, CityLocation
from django.views.generic import View
from django.http.request import HttpRequest
from django.http import JsonResponse
from .serializers import CinemaSerializer
from rest_framework import generics


def index(request: HttpRequest) -> HttpRequest:
    """index view."""
    return render(request, template_name='cinemas_city/index.html')

class CityView(View):
    def get(self, request):
        citys = CityLocation.objects.all()
        
        return render(request, 'cinemas_city/city.html', {"city_list": citys})

class CityDetailView(View):
    def get(self, request, pk):
        city = CityLocation.objects.get(id=pk)
        cinemas = city.cinema_set.all()
        print(type(cinemas))

        return render(request, 'cinemas_city/city_detail.html', {"city": city, 'cinema_list':cinemas})


class CinemaDetailView(View):
    def get(self, request, slug):
        cinema = Cinema.objects.get(url=slug)

        return render(request, 'cinemas_city/cinema_detail.html', {"cinema": cinema})


class CinemasListView(generics.ListAPIView):
    serializer_class = CinemaSerializer
    
    def get_queryset(self):
        queryset = Cinema.objects.filter(city=CityLocation.objects.get(pk=self.request.GET.get('city_id'))).all()
        print(list(queryset))
        
        return queryset
    

