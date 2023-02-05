from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.contrib import messages


from .forms import UserRegistrationForm
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

