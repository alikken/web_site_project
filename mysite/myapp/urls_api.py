from django.urls import path
from .api_views import *


urlpatterns = [
    path('cinema/', CinemaList.as_view()),
    path('cinema/<int:cinema_id>/halls/', HallApi.as_view()),
    path('seat_anuar/', BookTicketsApi.as_view()),
]