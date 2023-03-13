from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.contrib.auth.views import LoginView, LogoutView
from .forms import UserRegistrationForm
from .models import Cinema, CityLocation, CustomUser
from django.shortcuts import resolve_url
from django.views.generic import View

from django.http.request import HttpRequest
from django.http import JsonResponse
from rest_framework.decorators import api_view
from django.core import serializers
from .serializers import CinemaSerializer
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from django.http import HttpRequest 
from rest_framework.response import Response


def index(request: HttpRequest) -> HttpRequest:
    """index view."""
    return render(request, template_name='myapp/index.html')



class CityView(View):
    def get(self, request):
        citys = CityLocation.objects.all()
        
        return render(request, 'myapp/city.html', {"city_list": citys})

class CityDetailView(View):
    def get(self, request, pk):
        city = CityLocation.objects.get(id=pk)
        cinemas = city.cinema_set.all()
        

        return render(request, 'myapp/city_detail.html', {"city": city, 'cinema_list':cinemas})

    # def get_context_data(self, **kwargs):
    #     context = super(CityDetailView, self).get_context_data(**kwargs)
    #     context['city_list'] = CityLocation.objects.all()
    #     return context


class CinemaDetailView(View):
    def get(self, request, slug):
        cinema = Cinema.objects.get(url=slug)
        return render(request, 'myapp/cinema_detail.html', {"cinema": cinema})


def register(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            password = form.cleaned_data.get('password1')
            user.set_password(password)
            user.save()

            user = authenticate(username = user.username, password = password)
        
            messages.success(request, 'Вы успешно зарегистрировались!')
            return redirect('index')
    else:
        form = UserRegistrationForm()

    context = {'form': form}
    return render(
        request, 
        'myapp/registration.html', 
        context=context
        )

class CustomLogin(LoginView):
    template_name = 'myapp/login.html'
    def get_success_url(self):
        return resolve_url('index')

class CustomLogout(LogoutView):
    template_name = 'myapp/logged_out.html'
    def get_success_url(self):
        return resolve_url('logout')



# @api_view(['GET',])
# def get_theatre_by_city_id(request):
#     cinemas_list = Cinema.objects.filter(city=CityLocation.objects.get(pk=request.GET.get('city_id'))).all()

#     for cinema in cinemas_list:
#         print(cinema.city.name)

#     return JsonResponse({"cinemas": serializers.serialize('json', cinemas_list)}, safe=False)


class CinemasListView(generics.ListAPIView):
    serializer_class = CinemaSerializer
    
    def get_queryset(self):
        
        queryset = Cinema.objects.filter(city=CityLocation.objects.get(pk=self.request.GET.get('city_id'))).all()
        print(list(queryset))
        
        return queryset
    

