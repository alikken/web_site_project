"""mysite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, include
from myapp import views
from django.conf import settings
from django.conf.urls.static import static
from .views import CustomLogin, CustomLogout, get_theatre_by_city_id
from django.conf import settings
from django.contrib.auth.views import LoginView, LogoutView

from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)


urlpatterns = [
    path('index/', views.index, name='index'),
    path('register/', views.register, name='register'),
    path('login/', views.CustomLogin.as_view(), name='login'),
    path('logout/', views.CustomLogout.as_view(), name='logout'),

    path('city/', views.CityView.as_view(), name='cinema'),

    path('<int:pk>/', views.CityDetailView.as_view()),
    path('<slug:slug>/', views.CinemaDetailView.as_view()),
    #urls for jwt auth
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    
    path('api/users/', views.UserListView.as_view(), name='get_users'),

    path('get_theatre_by_city_id', get_theatre_by_city_id, name='get_theatre_by_city_id'),
]


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
