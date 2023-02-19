
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




class CitysLocation(models.Model):

    name = models.CharField(("Город"), max_length=50, unique=True)

    class Meta:
        verbose_name = "Город"
        verbose_name_plural = 'Города'

    def __str__(self) -> str:
        return self.name
    
class Cinemas(models.Model):

    """Добавить описание кинотеатра и еще немного характеристик"""
    cinema = models.CharField(max_length=128)
    address = models.TextField()
    city = models.ForeignKey(to=CitysLocation, on_delete=models.CASCADE)

    class Meta:
        verbose_name = "Кинотеатр"
        verbose_name_plural = "Кинотеатры"

    def __str__(self) -> str:
        return self.cinema


class CustomUser(User):

    phone_number = models.CharField(("Номер телефона"), max_length=50)
    objects = CustomUserManager()

    class Meta:
        verbose_name = "Пользователь"
        verbose_name_plural = 'Пользователи'




# class ProductCategory(models.Model):
#     name = models.CharField(max_length=128)
#     description = models.TextField(null=True, blank=True)

#     def __str__(self) -> str:
#         return self.name

# class Product(models.Model):
#     name = models.CharField(max_length=256)
#     description = models.TextField()
#     price = models.DecimalField(max_digits=6, decimal_places=2)
#     quantity = models.PositiveIntegerField(default=0)
#     category = models.ForeignKey(to=ProductCategory, on_delete=models.CASCADE)
