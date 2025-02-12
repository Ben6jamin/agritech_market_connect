from django.contrib import admin
from .models import Seed, Fertilizer, MarketPrice, WeatherForecast, FarmingTip

admin.site.register(Seed)
admin.site.register(Fertilizer)
admin.site.register(MarketPrice)
admin.site.register(WeatherForecast)
admin.site.register(FarmingTip)