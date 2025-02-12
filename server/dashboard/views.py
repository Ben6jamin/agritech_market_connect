from rest_framework import generics
from .models import Seed, Fertilizer, MarketPrice, WeatherForecast, FarmingTip
from .serializers import SeedSerializer, FertilizerSerializer, MarketPriceSerializer, WeatherForecastSerializer, FarmingTipSerializer

class SeedListView(generics.ListAPIView):
    queryset = Seed.objects.all()
    serializer_class = SeedSerializer

class FertilizerListView(generics.ListAPIView):
    queryset = Fertilizer.objects.all()
    serializer_class = FertilizerSerializer

class MarketPriceListView(generics.ListAPIView):
    queryset = MarketPrice.objects.all()
    serializer_class = MarketPriceSerializer

class WeatherForecastListView(generics.ListAPIView):
    queryset = WeatherForecast.objects.all().order_by('-date')
    serializer_class = WeatherForecastSerializer


class FarmingTipListView(generics.ListAPIView):
    queryset = FarmingTip.objects.all().order_by('-created_at')
    serializer_class = FarmingTipSerializer

