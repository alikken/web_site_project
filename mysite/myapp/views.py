from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.contrib.auth.views import LoginView, LogoutView
from .forms import UserRegistrationForm
from .models import Cinemas, CitysLocation
from django.shortcuts import resolve_url
from django.views.generic import View
# Create your views here.
from django.http.request import HttpRequest

# def index(request):
#     return render(request, 'myapp/index.html')

def index(request: HttpRequest) -> HttpRequest:
    """index view."""

    # numbers: list[int] = []
    # i: int
    # for i in range(1, 11):
    #     numbers.append(i)

    ctx_data  = {
            'title': 'Заголовок - сайт',
            'cinemas': Cinemas.objects.all(),
            'citys': CitysLocation.objects.all(),
    }
    return render(
        request,
        template_name='myapp/index.html',
        context=ctx_data
    )




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


# class CityCinemas(View):
#     def get(request):
#         context = {
#             'title': 'Заголовок - сайт',
#             'cinemas': Cinemas.objects.all(),
#             'citys': CitysLocation.objects.name(),
#         }
#         print(Cinemas.objects.all())
#         return render(request, 'myapp/index.html', context=context)