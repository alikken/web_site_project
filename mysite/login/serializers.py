from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *


# class CustomUserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CustomUser
#         fields = '__all__'

#         extra_kwargs = {'password': {'write_only': True}}


#         def create(self, validated_data):
#             user = CustomUser.objects.create_user(
#                 username=validated_data['username'],
#                 email=validated_data['email'],
#                 password=validated_data['password'],
                
#             )