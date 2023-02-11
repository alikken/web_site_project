# from django.db import models
from django.db import models
from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.base_user import BaseUserManager


# Create your models here.
class CustomUserManager(BaseUserManager):
    """
    Custom user model manager where email is the unique identifiers
    for authentication instead of usernames.
    """
    def create_user(self, username, password, email, **extra_fields):
        """
        Create and save a user with the given email and password.
        """
        if not email:
            raise ValueError(_("The Email must be set"))
        email = self.normalize_email(email)
        user = self.model(username=username, email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user




class City(models.Model):

    name = models.CharField(("Выберете город"), max_length=50)

    class Meta:
        verbose_name = "Город"
        verbose_name_plural = 'Города'


class CustomUser(User):

    phone_number = models.CharField(("Номер телефона"), max_length=50)


    objects = CustomUserManager()

    class Meta:
        verbose_name = "Пользователь"
        verbose_name_plural = 'Пользователи'

