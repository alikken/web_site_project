from django.db import models
from multiupload.fields import MultiFileField
from login.models import CustomUser


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
    image = models.ImageField(verbose_name='Превью', upload_to='media', blank=True)
    image_detail = models.ImageField(verbose_name='Фото кинотеатра', upload_to='media', blank=True)
    info = models.TextField('Информация', max_length=5000)
   
    url = models.SlugField(max_length=160, unique=True)

    class Meta:
        verbose_name = "Кинотеатр"
        verbose_name_plural = "Кинотеатры"
    def __str__(self) -> str:
        return self.cinema
    
class Genre(models.Model):
    title = models.CharField("Жанр", max_length=128)
    class Meta:
        verbose_name = "Жанр"
        verbose_name_plural = "Жанры"
    def __str__(self) -> str:
        return self.title
    
class Movie(models.Model):
    title = models.CharField('Название', max_length=128)
    img = models.ImageField(upload_to='media', blank=True)
    genre = models.ManyToManyField(Genre, verbose_name='Жанр')
    description = models.TextField(max_length=200, null=True, blank=True)
    url = models.SlugField(max_length=160, unique=True, blank=True, null=True)
    class Meta:
        verbose_name = "Фильм"
        verbose_name_plural = "Фильмы"

    def __str__(self) -> str:
        return self.title

class ShowMovie(models.Model):
    movie_show = models.ForeignKey(Movie, on_delete=models.CASCADE, null=True, blank=True)
    time_show = models.TimeField(default='08:00')

class Hall(models.Model):
    cinema = models.ForeignKey(Cinema, on_delete=models.CASCADE)
    name = models.CharField(max_length=45)
    show_movie = models.ManyToManyField(ShowMovie)
   
    row_count = models.PositiveIntegerField(default=10)
    col_count = models.PositiveIntegerField(default=20)

    def __str__(self) -> str:
            return self.name

class Seat(models.Model):
    hall = models.ForeignKey(Hall, on_delete=models.CASCADE)
    row = models.IntegerField()
    col = models.IntegerField()

class Ticket(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=1500)
    seat_number = models.ForeignKey(Seat, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now=False, auto_now_add=False)




