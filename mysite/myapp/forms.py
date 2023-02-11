from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import CustomUser

class UserRegistrationForm(UserCreationForm):
    first_name = forms.CharField(max_length=255)
    last_name = forms.CharField(max_length=255)



    class Meta:
        model = CustomUser
        fields = ['username', 'first_name', 'last_name', 'email', 'city', 'phone_number', 'password1', 'password2']


