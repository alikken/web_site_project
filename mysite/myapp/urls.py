
from django.urls import path
from myapp import views
from django.conf import settings
from django.conf.urls.static import static
from .views import CinemasListView





urlpatterns = [
    path('index/', views.index, name='index'),

    path('city/', views.CityView.as_view(), name='cinema'),
    path('<int:pk>/', views.CityDetailView.as_view()),
    path('<slug:slug>/', views.CinemaDetailView.as_view()),
    #urls for jwt auth
    path('get_theatre_by_city_id', views.CinemasListView.as_view(), name='get_theatre_by_city_id'),
]


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
