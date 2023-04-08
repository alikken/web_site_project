from rest_framework.generics import ListAPIView, GenericAPIView, ListCreateAPIView
from .serializers import  *
from rest_framework.generics import ListAPIView

from rest_framework import generics
from django.contrib.auth import authenticate
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.status import HTTP_401_UNAUTHORIZED
from rest_framework.permissions import IsAdminUser
from rest_framework import status
from .models import *
from rest_framework.permissions import IsAuthenticated
from .serializers import CinemaSerializer



class CinemaList(ListAPIView):
    serializer_class = CinemaSerializer
    queryset = Cinema.objects.all()
    print(queryset)
    # permission_classes = [IsAuthenticated]


# class CityList(ListAPIView):
#     serializer_class = 