
from django.urls import path
from myapp import views
from django.conf import settings
from django.conf.urls.static import static

from .views import CinemasListView





urlpatterns = [
    path('home/', views.HomePage.as_view(), name='home'),
    # path('home/', views.CityView.as_view(), name='city'),
    # path('<int:pk>/', views.CityDetailView.as_view()),
    
    path('movie/<slug:slug>/', views.MoviePage.as_view()),
    path('cinema/<slug:slug>/', views.CinemaDetailView.as_view()),
    path('get_theatre_by_city_id', views.CinemasListView.as_view(), name='get_theatre_by_city_id'),

    # path('hall/<int:hall_id>/select_seat/', views.select_seat, name='select_seat')
    path('halls/<int:hall_id>/', views.BookTickets.as_view()),
    # path('check_seat/', views.check_seat, name='check_seat'),
    path('ticket/list/', views.TicketList.as_view()),
]


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
