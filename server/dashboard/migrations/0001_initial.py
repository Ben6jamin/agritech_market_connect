# Generated by Django 4.2.2 on 2025-02-12 20:54

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='FarmingTip',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=200)),
                ('description', models.TextField()),
                ('image', models.URLField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Fertilizer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, unique=True)),
                ('description', models.TextField()),
                ('price_per_bag', models.DecimalField(decimal_places=2, max_digits=10)),
                ('availability_status', models.BooleanField(default=True)),
                ('image', models.ImageField(blank=True, null=True, upload_to='images/fertilizers/')),
                ('date_added', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='MarketPrice',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('crop', models.CharField(max_length=100)),
                ('price_per_kg', models.DecimalField(decimal_places=2, max_digits=10)),
                ('market_location', models.CharField(max_length=200)),
                ('date_updated', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='Seed',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, unique=True)),
                ('description', models.TextField()),
                ('price_per_kg', models.DecimalField(decimal_places=2, max_digits=10)),
                ('availability_status', models.BooleanField(default=True)),
                ('image', models.ImageField(blank=True, null=True, upload_to='images/seeds/')),
                ('date_added', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='WeatherForecast',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField()),
                ('min_temp', models.FloatField()),
                ('max_temp', models.FloatField()),
                ('condition', models.CharField(max_length=100)),
                ('humidity', models.FloatField()),
                ('wind_speed', models.FloatField()),
            ],
        ),
    ]
