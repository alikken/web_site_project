from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.contrib.auth.views import LoginView, LogoutView
from .forms import UserRegistrationForm
from .models import Cinema, CityLocation
from django.shortcuts import resolve_url
from django.views.generic import View
from django.http.request import HttpRequest



def index(request: HttpRequest) -> HttpRequest:
    """index view."""
    return render(request, template_name='myapp/index.html')



# class CityList(View):
#     def get(self, request):
#         """Список Городов"""

#         context = {
#             'citis': CityLocation.objects.all(),
#         }
#         return render(
#             request,
#             template_name='myapp/cinema.html',
#             context=context
#         )

# class CinemaView(View):
#     def get(self, request):

#         context = {
#             'cinemas': Cinema.objects.all(),
#             'citis': CityLocation.objects.all(),
#         }
#         return render(request, 'myapp/cinema.html', context=context)
    
# class CinemaDetailView(View):
#     def get(self, request, pk):
#         cinema = CityLocation.objects.get(id=pk)
#         return render(request, 'myapp/cinema.html', {"citis":cinema})


class CityView(View):
    def get(self, request):
        citys = CityLocation.objects.all()
        
        return render(request, 'myapp/city.html', {"city_list": citys})

class CityDetailView(View):
    def get(self, request, pk):
        city = CityLocation.objects.get(id=pk)
        cinemas = city.cinema_set.all()
        

        return render(request, 'myapp/city_detail.html', {"city": city, 'cinema_list':cinemas})


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



