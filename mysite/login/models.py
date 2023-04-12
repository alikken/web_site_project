from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.base_user import BaseUserManager



class CustomUserManager(BaseUserManager):

    def create_user(self, username, password, email, **extra_fields):
        email = self.normalize_email(email)
        user = self.model(username=username, email=email, **extra_fields)
        user.set_password(password)
        user.save()

        

        return user
    
    def create_superuser(self, username, password, email, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_active", True)
        extra_fields.setdefault("allows", '3')

        if extra_fields.get("is_staff") is not True:
            raise ValueError(("Superuser must have is_staff=True."))
        if extra_fields.get("is_superuser") is not True:
            raise ValueError(("Superuser must have is_superuser=True."))
        
        return self.create_user(username, password, email, **extra_fields)

class CustomUser(User):
    

    objects = CustomUserManager()

    class Meta:
        verbose_name = "Пользователь"
        verbose_name_plural = 'Пользователи'