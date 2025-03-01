from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
# signup
from .views import SignUpView,UserDetails

urlpatterns = [
    path('login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('signup/', SignUpView.as_view(), name='signup'),
    path('refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('user/', UserDetails.as_view(), name='user-details'),
]