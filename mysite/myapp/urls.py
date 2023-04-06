
from django.urls import path
from myapp import views
from django.conf import settings
from django.conf.urls.static import static
from .api_views import CinemaList
from .views import CinemasListView





urlpatterns = [
    path('home/', views.HomePage.as_view(), name='home'),
    # path('home/', views.CityView.as_view(), name='city'),
    # path('<int:pk>/', views.CityDetailView.as_view()),
    path('<slug:slug>/', views.CinemaDetailView.as_view()),
    path('get_theatre_by_city_id', views.CinemasListView.as_view(), name='get_theatre_by_city_id'),


    
]


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
