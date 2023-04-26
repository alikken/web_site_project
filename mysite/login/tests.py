from django.test import TestCase, Client
from django.urls import reverse
from .forms import UserRegistrationForm
from .models import CustomUser


# тест регистрации
class UserRegistrationTestCase(TestCase):
    def setUp(self):
        self.client = Client()
        self.url = reverse('register')
        self.form_data = {'username': 'testuser', 'email': 'testuser@test.com', 'password1': 'testpassword', 'password2': 'testpassword'}

    def test_registration(self):
        response = self.client.post(self.url, self.form_data)
        self.assertEqual(response.status_code, 302)
        
        user = CustomUser.objects.get(username=self.form_data['username'])
        self.assertEqual(user.email, self.form_data['email'])
        self.assertTrue(user.check_password(self.form_data['password1']))
        
        self.assertRedirects(response, reverse('home'))
        
        response = self.client.get(self.url)
        self.assertTemplateUsed(response, 'auth/registration.html')
        self.assertIsInstance(response.context['form'], UserRegistrationForm)

# тест логина
class CustomLoginTestCase(TestCase):
    
    def setUp(self):
        self.client = Client()
        self.url = reverse('login')
        self.credentials = {'username': 'testuser', 'email':"testuser@test.com", 'password': 'testpassword'}
        CustomUser.objects.create_user(**self.credentials)

    def test_login(self):
        response = self.client.post(self.url, self.credentials)
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, reverse('home'))
        
        response = self.client.get(reverse('home'))
        self.assertRedirects(response, f"{reverse('login')}?next={reverse('home')}")
