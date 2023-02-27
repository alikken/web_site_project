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



class Category(models.Model):
    """Категории"""
    name =  models.CharField("Категория", max_length=150)
    description = models.TextField("Описание")
    url = models.SlugField(max_length=160)

    def __str__(self) -> str:
        return self.name
    
    class Meta:
        verbose_name = "Категория"
        verbose_name_plural = 'Категории'

class Actor(models.Model):
    """Актеры и режисеры"""
    name = models.CharField('Имя', max_length=150)
    age = models.PositiveSmallIntegerField('Возраст', default=0)
    description = models.TextField('Описание')
    image = models.ImageField("Изображение", upload_to='actor/')

    def __str__(self) -> str:
        return self.name
    
    class Meta:
        verbose_name = "Актеры и Режисеры"
        verbose_name_plural = "Актеры и Режисеры"

class Genre(models.Model):
    """Жанр"""

    name = models.CharField('Имя', max_length=100)
    description = models.TextField('Описание')
    url = models.SlugField(max_length=100, unique=True)

    def __str__(self) -> str:
        return self.name    

    class Meta:
        verbose_name = "Жанр"
        verbose_name_plural = "Жанры"


class Movie(models.Model):
    """Фильм"""

    title = models.CharField("Название", max_length=100)
    tagline = models.CharField("Слоган", max_length=100, default='')
    description = models.TextField("Описание")
    poster = models.ImageField("Постер", upload_to='movies/')
    year = models.PositiveBigIntegerField("Дата выхода", default=2019)
    country = models.CharField("Страна", max_length=30)
    # directors = models.ManyToManyField(Actor, verbose_name="режиссер")
    # actors = models.ManyToManyField()
    # genres = models.ManyToManyField()
    # world_premiere = models.DateField()

    # category = models.ForeignKey()
    # url = models.SlugField()
    # draft = models.BooleanField()


    def __str__(self) -> str:
        return self.name
    
    class Meta:
        verbose_name = 'Фильм'
        verbose_name_plural = 'фильмы'