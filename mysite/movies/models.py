from datetime import date
from django.db import models

# Create your models here.



class Category(models.Model):
    """Категории"""

    name =  models.CharField("Категория", max_length=150)
    description = models.TextField("Описание")
    url = models.SlugField(max_length=160)

    def __str__(self) -> str:
        return self.name
    
    class Meta:
        verbose_name = "Категория"
        verbose_name_plural = "Категории"

class Actor(models.Model):
    """Актеры и режисеры"""

    name = models.CharField("Имя", max_length=150)
    age = models.PositiveSmallIntegerField("Возраст", default=0)
    description = models.TextField("Описание")
    image = models.ImageField("Изображение", upload_to="actor/")

    def __str__(self) -> str:
        return self.name
    
    class Meta:
        verbose_name = "Актеры и Режисеры"
        verbose_name_plural = "Актеры и Режисеры"

class Genre(models.Model):
    """Жанр"""

    name = models.CharField("Имя", max_length=100)
    description = models.TextField("Описание")
    url = models.SlugField(max_length=100, unique=True)

    def __str__(self) -> str:
        return self.name    

    class Meta:
        verbose_name = "Жанр"
        verbose_name_plural = "Жанры"


class Movie(models.Model):
    """Фильм"""

    title = models.CharField("Название", max_length=100)
    tagline = models.CharField("Слоган", max_length=100, default="")
    description = models.TextField("Описание")
    poster = models.ImageField("Постер", upload_to="movies/")
    year = models.PositiveBigIntegerField("Дата выхода", default=2019)
    country = models.CharField("Страна", max_length=30)
    directors = models.ManyToManyField(Actor, verbose_name="режиссер", related_name="film_director")
    actors = models.ManyToManyField(Actor, verbose_name="актеры", related_name="film_actor")
    genres = models.ManyToManyField(Genre, verbose_name="жанры")
    KZ_premiere = models.DateField("Примьера в КЗ", default=date.today)

    category = models.ForeignKey(
        Category, verbose_name="Категория", on_delete=models.SET_NULL, null=True
    )
    url = models.SlugField(max_length=160, unique=True)
    draft = models.BooleanField("Черновик", default=False)


    def __str__(self) -> str:
        return self.title
    
    class Meta:
        verbose_name = "Фильм"
        verbose_name_plural = "фильмы"


class MovieShorts(models.Model):
    """Кадры их фильма"""
    title = models.CharField("Заголовок", max_length=100)
    description = models.TextField("Описание")
    image = models.ImageField("Изображения", upload_to="movie_shorts/")
    movie = models.ForeignKey(Movie, verbose_name="Фильм", on_delete=models.CASCADE)


    def __str__(self) -> str:
        return self.title

    class Meta:
        verbose_name = "Кадр из фильма"
        verbose_name_plural = "Кадры из фильма"

class RatingStar(models.Model):
    """Звезда рейтинга"""

    value = models.PositiveIntegerField("Значение", default=0)

    def __str__(self) -> str:
        return self.value
    
    class Meta:
        verbose_name = "Везда рейтинга"
        verbose_name_plural = "Звезды рейтинга"

class Rating(models.Model):
    """Рейтинг"""
    ip = models.CharField("IP адрес", max_length=15)
    star = models.ForeignKey(RatingStar, verbose_name="звезда", on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, verbose_name="фильм", on_delete=models.CharField)
    
    def __str__(self) -> str:
        return f"{self.star} - {self.movie}"
    
    class Meta:
        verbose_name = "Рейтинг"
        verbose_name_plural = "Рейтинги"

class Review(models.Model): 
    """Отзывы"""
    name = models.CharField("Имя", max_length=100)
    title = models.CharField("Заголовок", max_length=100)
    description = models.TextField("Описание", max_length=5000)

    movie = models.ForeignKey(Movie, verbose_name="фильм", on_delete=models.CASCADE)

    def __str__(self) -> str:
        return f"{self.name} - {self.title}"
    
    class Meta:
        verbose_name = "Отзыв"
        verbose_name_plural = "Отзывы"
        