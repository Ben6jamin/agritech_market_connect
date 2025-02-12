from django.urls import path
from .views import (
    SeedListView, FertilizerListView, MarketPriceListView, 
    WeatherForecastListView, FarmingTipListView
)

urlpatterns = [
    path('seeds/', SeedListView.as_view(), name='seed-list'),
    path('fertilizers/', FertilizerListView.as_view(), name='fertilizer-list'),
    path('market-prices/', MarketPriceListView.as_view(), name='market-price-list'),
    path('weather-updates/', WeatherForecastListView.as_view(), name='weather-update-list'),
    path('farming-tips/', FarmingTipListView.as_view(), name='farming-tip-list'),
]