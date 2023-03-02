
from django.urls import path, include
from myapp import views
from django.conf import settings
from django.conf.urls.static import static
from django.conf import settings
from movies import views


urlpatterns = [
    
    path('movies/', views.movie, name='movies'),
    path('movie/', views.moviesingle, name='movie'),
]


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
