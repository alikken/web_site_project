from rest_framework import generics
from .models import CustomUser
from .forms import UserRegistrationForm
from django.http import HttpResponse
import json
class RegistrationView(generics.CreateAPIView):

    model = CustomUser

    def post(self, request):
        form_data = request.data
        print(form_data)

        form =UserRegistrationForm(form_data)

        if form.is_valid():
            form.save()
            return HttpResponse(json.dumps(['YES']))
        
        else:
            response = []
            errors = form.errors

            for field in errors:
                error_msgs = errors[field]
                for error_msg in error_msgs:
                     response.append(error_msg)
            return HttpResponse(json.dumps(response))
                    