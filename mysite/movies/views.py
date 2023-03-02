from django.shortcuts import render

# Create your views here.


def movie(request):
    return render(request, template_name='movie/movies.html')

def moviesingle(request):
    return render(request, template_name='movie/moviesingle.html')