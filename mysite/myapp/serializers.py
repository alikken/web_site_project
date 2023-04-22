from rest_framework import serializers
from .models import *

class GenreSerializer(serializers.ModelSerializer):


    class Meta:
        model = Genre
        fields = ('title',)

class MovieSerializer(serializers.ModelSerializer):

    genre = GenreSerializer(many=True)

    class Meta:
        model = Movie
        fields = '__all__'

class MovieShowSerializer(serializers.ModelSerializer):

    movie = MovieSerializer()

    class Meta:
        model = ShowMovie
        fields = '__all__'

class CinemaSerializer(serializers.ModelSerializer):
    city = serializers.CharField()
    
    class Meta:
        model = Cinema
        fields = '__all__'
        
class HallSerializer(serializers.ModelSerializer):

    cinema = serializers.CharField()
    show_movie = MovieShowSerializer(many=True)

    class Meta:
        model = Hall 
        fields = '__all__'

class SeatSerializer(serializers.ModelSerializer):


    class Meta:
        model = Seat
        fields = '__all__'

class TicketSerializer(serializers.ModelSerializer):

    seat_nimber = SeatSerializer()

    class Meta:
        model = Ticket
        fields = '__all__'


class RatingSerializer(serializers.ModelSerializer):

    movie = MovieSerializer()

    class Meta:
        model = Rating
        fields = '__all__'



