from django.db import models
from multiupload.fields import MultiFileField

class CityLocation(models.Model):
    name = models.CharField('Город', max_length=128, unique=True)
    # url = models.SlugField(max_length=160, unique=True)

    class Meta:
        verbose_name = "Город"
        verbose_name_plural = 'Города'

    def __str__(self) -> str:
        return self.name
    
class Cinema(models.Model):
    """Модель Кинотеатр"""

    cinema = models.CharField('Название Кинотеатра', max_length=128)
    address = models.CharField('Адрес', max_length=128)
    city = models.ForeignKey(verbose_name='Город', to=CityLocation, on_delete=models.CASCADE)
    image = models.ImageField(verbose_name='Превью', upload_to='media')
    image_detail = models.ImageField(verbose_name='Фото кинотеатра', upload_to='media')
    info = models.TextField('Информация', max_length=5000)
   
    url = models.SlugField(max_length=160, unique=True)

    class Meta:
        verbose_name = "Кинотеатр"
        verbose_name_plural = "Кинотеатры"
    def __str__(self) -> str:
        return self.cinema

"""Модели фильм"""

class Production(models.Model):
    country = models.CharField('Производство', max_length=128)
    class Meta:
        verbose_name = "Производство"
        verbose_name_plural = "Производствы"
    def __str__(self) -> str:
        return self.country
    
class Genre(models.Model):
    title = models.CharField("Жанр", max_length=128)
    class Meta:
        verbose_name = "Жанр"
        verbose_name_plural = "Жанры"
    def __str__(self) -> str:
        return self.title
    
class Regisseur(models.Model):
    name = models.CharField('Имя', max_length=200)
    image = models.ImageField(verbose_name='фото', upload_to='mdeia', blank=True)
    class Meta:
        verbose_name = "Актер|Режиссер"
        verbose_name_plural = "Актеры|Режиссеры"
    def __str__(self) -> str:
        return self.name

class Movie(models.Model):
    title = models.CharField('Название', max_length=128)
    title_img = models.ImageField(upload_to='media')
    detail_img = models.ImageField(upload_to='media')
    genre = models.ManyToManyField(Genre, verbose_name='Жанр')
    production = models.ManyToManyField(Production, verbose_name='Производство')
    premiere = models.DateTimeField("премьера", auto_now=False, auto_now_add=False)
    duration = models.IntegerField(null=True)
    #url
    url = models.SlugField(max_length=160, unique=True)
    regisseur = models.ManyToManyField(Regisseur, verbose_name='Режиссер')

    class Meta:
        verbose_name = "Фильм"
        verbose_name_plural = "Фильмы"

    def __str__(self) -> str:
        return self.title


class Show(models.Model):
    """Показы в кино"""
    movie = models.ForeignKey(Movie, verbose_name='Фильм', on_delete=models.CASCADE)
    cinema = models.ManyToManyField(Cinema, verbose_name='Кинотеатр')

    def __str__(self) -> str:
        return f'{self.movie}|{self.cinema}'
    




