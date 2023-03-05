from rest_framework import serializers
from myapp import models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomUser
        fields = '__all__'