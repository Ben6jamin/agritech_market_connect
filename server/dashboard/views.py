from rest_framework import generics
from .models import FeedBack, Seed, Fertilizer, MarketPrice, WeatherForecast, FarmingTip
from .serializers import FeedbackSerializer, SeedSerializer, FertilizerSerializer, MarketPriceSerializer, WeatherForecastSerializer, FarmingTipSerializer
from rest_framework.permissions import IsAuthenticated, AllowAny
class SeedListView(generics.ListAPIView):
    queryset = Seed.objects.all()
    serializer_class = SeedSerializer
    permission_classes = [IsAuthenticated]

class FertilizerListView(generics.ListAPIView):
    queryset = Fertilizer.objects.all()
    serializer_class = FertilizerSerializer
    permission_classes = [IsAuthenticated]

class MarketPriceListView(generics.ListAPIView):
    queryset = MarketPrice.objects.all()
    serializer_class = MarketPriceSerializer
    permission_classes = [IsAuthenticated]

class WeatherForecastListView(generics.ListAPIView):
    queryset = WeatherForecast.objects.all().order_by('-date')
    serializer_class = WeatherForecastSerializer
    permission_classes = [IsAuthenticated]


class FarmingTipListView(generics.ListAPIView):
    queryset = FarmingTip.objects.all().order_by('-created_at')
    serializer_class = FarmingTipSerializer
    permission_classes = [IsAuthenticated]

class FeedbacCreateView(generics.CreateAPIView):
    queryset = FeedBack.objects.all()
    serializer_class = FeedbackSerializer
    permission_classes = [IsAuthenticated]
    
    # add user to the serializer modifying the serializer.save() method
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)