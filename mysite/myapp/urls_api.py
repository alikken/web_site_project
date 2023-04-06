from django.urls import path
from .api_views import CinemaList


urlpatterns = [
    path('cinema/', CinemaList.as_view()),
]