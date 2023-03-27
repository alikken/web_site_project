from django.shortcuts import render, resolve_url, redirect
from django.contrib.auth.views import LoginView, LogoutView
from django.contrib.auth import authenticate
from .forms import UserRegistrationForm
from django.contrib import messages
from django.contrib.auth.models import User


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
    template_name = 'myapp/index.html'
    def get_success_url(self):
        return resolve_url('index')
    

