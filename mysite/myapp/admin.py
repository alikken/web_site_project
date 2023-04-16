from django.contrib import admin
from .models import (Cinema, 
    CityLocation, 
    Movie, 
    Hall, 
    Ticket,
    Genre,
    ShowMovie,
    Seat,
    Rating,
    )

# Register your models here.


admin.site.register(Cinema)
admin.site.register(CityLocation)
admin.site.register(Movie)
admin.site.register(Hall)
admin.site.register(Ticket)
admin.site.register(Genre)
admin.site.register(ShowMovie)
admin.site.register(Seat)
admin.site.register(Rating)





