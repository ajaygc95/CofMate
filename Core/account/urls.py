from django.urls import path, include

from django.conf import settings
from rest_framework import routers

from django.conf.urls.static import static
from .views import hello, RegisterView, UserListView, ImageUploadView, ProfileViewSet

router = routers.DefaultRouter()
router.register(r'profiles', ProfileViewSet, basename='profile')


urlpatterns = [
    path('', include(router.urls)),
    path('register/', RegisterView.as_view(), name='register'),
    path('users/', UserListView.as_view(), name='user-list'),
    path('image/', ImageUploadView.as_view(), name='image_upload'),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)