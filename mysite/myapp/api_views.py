from rest_framework.generics import ListAPIView, GenericAPIView, ListCreateAPIView, CreateAPIView
from .serializers import  *



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
from django.http import HttpResponse
import json

class CinemaList(ListAPIView):
    serializer_class = CinemaSerializer
    queryset = Cinema.objects.all()

    # permission_classes = (IsAuthenticated, )
    print(queryset)

#Matix flutter
class HallApi(APIView):
    
    def get(self, request, cinema_id):
        halls = Hall.objects.filter(cinema__id=cinema_id)
        serializer = HallSerializer(halls, many=True)
        print(serializer.data)
        # return Response(serializer.data)
        return HttpResponse(json.dumps(serializer.data))
    

    
class BookTicketsApi(ListCreateAPIView):
    
    model = Seat

    def post(self, request):
        pass

        
    






