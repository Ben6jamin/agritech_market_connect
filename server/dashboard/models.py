from django.db import models
from django.contrib.auth.models import User
class Seed(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField()
    price_per_kg = models.DecimalField(max_digits=10, decimal_places=2)
    availability_status = models.BooleanField(default=True)
    image = models.ImageField(upload_to='images/seeds/', null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name


class Fertilizer(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField()
    price_per_bag = models.DecimalField(max_digits=10, decimal_places=2)
    availability_status = models.BooleanField(default=True)
    image = models.ImageField(upload_to='images/fertilizers/', null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name


class MarketPrice(models.Model):
    crop = models.CharField(max_length=100)
    price_per_kg = models.DecimalField(max_digits=10, decimal_places=2)
    market_location = models.CharField(max_length=200)
    date_updated = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.crop} - {self.market_location}"


class FarmingTip(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    image = models.URLField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


class WeatherForecast(models.Model):
    date = models.DateField()
    min_temp = models.FloatField()
    max_temp = models.FloatField()
    condition = models.CharField(max_length=100)  # e.g., "Sunny", "Rainy"
    humidity = models.FloatField()
    wind_speed = models.FloatField()

    def __str__(self):
        return f"Weather for {self.date}"


class FeedBack(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedbacks')
    message = models.TextField()
    date_sent = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Feedback from {self.user.username}"