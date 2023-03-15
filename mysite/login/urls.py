
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from login import views


urlpatterns = [
    
    path('register/', views.register, name='register'),
    path('login/', views.CustomLogin.as_view(), name='login'),
    path('logout/', views.CustomLogout.as_view(), name='logout'),
]


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
