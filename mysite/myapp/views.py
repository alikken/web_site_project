from django.shortcuts import render
from . import models
# Create your views here.
def index(request):
    
    return render(request, 'myapp/index.html')

def register(request):

    if request.method == "POST":

        login = request.POST.get("login")
        
        password = request.POST.get("password")
        
        email = request.POST.get("email")
        
        phonenumber = request.POST.get("phonenumber")

        user = models.User(
            login = login,
            password = password,
            email = email,
            phonenumber = phonenumber
        )
        
        user.save()

    return render(request, 'myapp/registration.html')
