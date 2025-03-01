from django.contrib import admin
from .models import Seed, Fertilizer, MarketPrice, WeatherForecast, FarmingTip, FeedBack

admin.site.register(Seed)
admin.site.register(Fertilizer)
admin.site.register(MarketPrice)
admin.site.register(WeatherForecast)
admin.site.register(FarmingTip)
admin.site.register(FeedBack)