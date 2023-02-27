from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.contrib.auth.views import LoginView, LogoutView
from .forms import UserRegistrationForm
from .models import Cinema, CityLocation
from django.shortcuts import resolve_url
from django.views.generic import View
# Create your views here.
from django.http.request import HttpRequest
from django.urls import reverse_lazy


def index(request: HttpRequest) -> HttpRequest:
    """index view."""

    context  = {
            'title': 'Заголовок - сайт',
            'cinemas': Cinema.objects.all(),
            'citys': CityLocation.objects.all(),
    }
    return render(
        request,
        template_name='myapp/index.html',
        context=context
    )

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



