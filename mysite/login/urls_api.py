from django.urls import path
from login import api_views as view


urlpatterns = [
    path('registration/', view.RegistrationView.as_view()),
]