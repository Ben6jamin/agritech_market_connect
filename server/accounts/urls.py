from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
# signup
from .views import SignUpView

urlpatterns = [
    path('login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('signup/', SignUpView.as_view(), name='signup'),
    path('refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]