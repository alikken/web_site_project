# from django.db import models
from django.db import models
# Create your models here.


class User(models.Model):
    login = models.CharField("Логин пользователя", max_length=255)
 
    password = models.CharField("Пароль пользователя", max_length=255)
    
    email = models.EmailField("Почта", max_length=255)

    phonenumber = models.CharField("Телефон", max_length=255)
    