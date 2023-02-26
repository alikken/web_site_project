from django.db import models
from django.contrib.auth.models import User




class CustomUser(User):
    phone_number = models.CharField(("Номер телефона"), max_length=50)

    class Meta:
        verbose_name = "Пользователь"
        verbose_name_plural = 'Пользователи'


class CityLocation(models.Model):

    name = models.CharField(("Город"), max_length=128, unique=True)

    class Meta:
        verbose_name = "Город"
        verbose_name_plural = 'Города'

    def __str__(self) -> str:
        return self.name
    
class Cinema(models.Model):

    """Добавить описание кинотеатра и еще немного характеристик"""
    cinema = models.CharField(max_length=128)
    address = models.TextField()
    city = models.ForeignKey(to=CityLocation, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='media')

    class Meta:
        verbose_name = "Кинотеатр"
        verbose_name_plural = "Кинотеатры"

    def __str__(self) -> str:
        return self.cinema

class Films(models.Model):
    film = models.CharField(max_length=128)
    descript = models.TextField()
    image = models.ImageField()






