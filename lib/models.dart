class WeatherEntity {
  final String description;
  final String icon;

  WeatherEntity({this.description, this.icon});

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherEntity(description: description, icon: icon);
  }
}

class MainEntity {
  final double temperature;

  MainEntity({this.temperature});

  factory MainEntity.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return MainEntity(temperature: temperature);
  }
}

class WeatherResponse {
  final String cityName;
  final MainEntity mainEntity;
  final WeatherEntity weatherEntity;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherEntity.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.mainEntity, this.weatherEntity});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = MainEntity.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherEntity.fromJson(weatherInfoJson);

    return WeatherResponse(
        cityName: cityName, mainEntity: tempInfo, weatherEntity: weatherInfo);
  }
}