from django.contrib import admin
from .models import CustomUser, Cinemas, CitysLocation

# Register your models here.

admin.site.register(CustomUser)
admin.site.register(Cinemas)
admin.site.register(CitysLocation)








# admin.site.register(Product)
# admin.site.register(ProductCategory)