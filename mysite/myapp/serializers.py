from rest_framework import serializers
# from myapp import models
from .models import *


class CinemaSerializer(serializers.ModelSerializer):
    city = serializers.CharField()
    
    class Meta:
        model = Cinema
        fields = '__all__'
        
class HallSerializer(serializers.ModelSerializer):

    cinema = serializers.CharField()
    show_movie = serializers.StringRelatedField(many=True)

    class Meta:
        model = Hall 
        fields = '__all__'

class SeatSerializer(serializers.ModelSerializer):

    class Meta:
        model = Seat
        fields = '__all__'

class TicketSerializer(serializers.ModelSerializer):

    class Meta:
        model = Ticket
        fields = '__all__'

class MovieShowSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShowMovie
        fields = '__all__'


class MovieSerializer(serializers.ModelSerializer):
    class Meta:
        model = Movie
        fields = '__all__'

# class RatingSerializer(serializers.models):

#     class Meta:
#         model = Rating
#         fields = '__all__'


