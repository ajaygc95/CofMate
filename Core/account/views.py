
from django.shortcuts import render
from django.http import HttpResponse

from rest_framework.response import Response
from rest_framework import status, generics, viewsets
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.views import APIView
from rest_framework.authentication import TokenAuthentication

from .serializers import (RegisterSerializer, ProfileSerializer, LoginSerializer, UserSerializer,ImageUploadSerializer, ImageSerializer)
from django.contrib.auth.models import User
from .models import  Profile, Image, Interest
from django.core.exceptions import PermissionDenied, ObjectDoesNotExist
from rest_framework.exceptions import NotFound

def hello(request):
    return HttpResponse("Hello World")

class RegisterView(generics.GenericAPIView):
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        response_data = {
            "message": "User registered successfully"
        }
        return Response(response_data, status=status.HTTP_201_CREATED)

class LoginView(generics.CreateAPIView):
    serializer_class = LoginSerializer

class UserListView(generics.ListAPIView):
    queryset = User.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = UserSerializer

class ImageUploadView(APIView):

    def post(self, request, format=None):
        serializer = ImageUploadSerializer(data=request.data)
        if serializer.is_valid():
            profile = Profile.objects.get(user=request.user)
            image = Image(image=serializer.validated_data['image'])
            image.save()
            profile.images.add(image)
            profile.save()
            return Response(ImageSerializer(image).data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = ProfileSerializer
    queryset = Profile.objects.all()

    def get_queryset(self):
        user_id = self.kwargs.get('pk')  # retrieve the user ID from the URL
        try:
            profile = self.queryset.get(user=user_id)  # retrieve the profile for the user
        except ObjectDoesNotExist:
            raise NotFound("You don't have a profile created yet")  # raise a custom error if no profile exists
        if user_id == str(self.request.user.id):  # only allow the owner of the profile to access it
            return self.queryset.filter(user=user_id)
        else:
            raise PermissionDenied('You do not have permission to view this profile')
    
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def update(self, request, *args, **kwargs):
            partial = kwargs.pop('partial', False)
            instance = self.get_object()
            if instance.user != request.user:
                return Response(status=status.HTTP_403_FORBIDDEN)
            serializer = self.get_serializer(instance, data=request.data, partial=partial)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)