from rest_framework import serializers
from .models import FeedBack, Seed, Fertilizer, MarketPrice, WeatherForecast, FarmingTip

class SeedSerializer(serializers.ModelSerializer):
    class Meta:
        model = Seed
        fields = '__all__'

class FertilizerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Fertilizer
        fields = '__all__'

class MarketPriceSerializer(serializers.ModelSerializer):
    class Meta:
        model = MarketPrice
        fields = '__all__'

class WeatherForecastSerializer(serializers.ModelSerializer):
    class Meta:
        model = WeatherForecast
        fields = '__all__'

class FarmingTipSerializer(serializers.ModelSerializer):
    class Meta:
        model = FarmingTip
        fields = '__all__'
        
class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = FeedBack
        fields = ['message']
