from django.contrib import admin
from .models import Genre, Actor, Movie, MovieShorts, Category, Rating, Review, RatingStar
# Register your models here.


admin.site.register(Category)
admin.site.register(Genre)
admin.site.register(Actor)
admin.site.register(Movie)
admin.site.register(MovieShorts)
admin.site.register(Rating)
admin.site.register(Review)
admin.site.register(RatingStar)



