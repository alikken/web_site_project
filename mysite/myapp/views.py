from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.contrib.auth.views import LoginView, LogoutView
from .forms import UserRegistrationForm
from django.shortcuts import resolve_url
# Create your views here.


def index(request):
    return render(request, 'myapp/index.html')


def register(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            form.save()

            messages.success(request, f'Вы создали аккаунт')
            return redirect('login')
    else:
        form = UserRegistrationForm()

    context = {'form': form}
    return render(request, 'myapp/registration.html', context)


class CustomLogin(LoginView):
    template_name = 'myapp/login.html'

    def ger_success_url(self):
        return resolve_url('index')

class CustomLogout(LogoutView):
    template_name = 'myapp/logout.html'

    def ger_success_url(self):
        return resolve_url('login')
