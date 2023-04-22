from django.test import TestCase

# # Create your tests here.
# from django.test import TestCase, Client
# from django.urls import reverse
# from .models import Movie, CustomUser, Rating


# class RateTestCase(TestCase):

#     def setUp(self):
#         self.client = Client()
#         self.user = CustomUser.objects.create_user(
#             username='testuser', email='USER@mail.com', password='testpass')
#         # self.movie = Movie.objects.create(
#         #     title='Test Movie', url='test-movie', release_date='2022-01-01')

#     def test_rate_movie(self):
#         url = reverse('rate', args=(self.movie.url, 5))
#         self.client.force_login(self.user)
#         response = self.client.get(url)
#         self.assertEqual(response.status_code, 200)
#         self.assertTrue(Rating.objects.filter(
#             movie=self.movie, user=self.user).exists())
