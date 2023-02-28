// ignore_for_file: camel_case_types, non_constant_identifier_names

class weatherModel {
  locationModel? location;
  currentModel? current;
  forecastModel? forecast;

  weatherModel.fromJson(Map<String, dynamic> json) {
    location = json["location"] != null
        ? locationModel.fromJson(json["location"])
        : null;
    current =
        json["current"] != null ? currentModel.fromJson(json["current"]) : null;
    forecast = json["forecast"] != null
        ? forecastModel.fromJson(json["forecast"])
        : null;
  }
}

class locationModel {
  String? name;
  String? localtime;
  locationModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    localtime = json["localtime"];
  }
}

class currentModel {
  String? last_updated;
  currentConditionModel? condition;
  dynamic wind_degree;
  currentModel.fromJson(Map<String, dynamic> json) {
    last_updated = json["last_updated"];
    condition = json["condition"] != null
        ? currentConditionModel.fromJson(json["condition"])
        : null;
    wind_degree = json["wind_degree"];
  }
}

class currentConditionModel {
  String? text;
  String? image;
  currentConditionModel.fromJson(Map<String, dynamic> json) {
    text = json["text"];
    image = json["icon"];
  }
}

class forecastModel {
  List<forecastdayModel> forecastday = [];
  forecastModel.fromJson(Map<String, dynamic> json) {
    json['forecastday'].forEach((element) {
      forecastday.add(forecastdayModel.fromJson(element));
    });
  }
}

class forecastdayModel {
  dayTempModel? day;
  List<hourTempModel> hour = [];
  forecastdayModel.fromJson(Map<String, dynamic> json) {
    day = json["day"] != null ? dayTempModel.fromJson(json["day"]) : null;
    json['hour'].forEach((element) {
      hour.add(hourTempModel.fromJson(element));
    });
  }
}

class dayTempModel {
  dynamic avgtemp_c;
  dynamic maxtemp_c;
  dynamic mintemp_c;
  dayTempModel.fromJson(Map<String, dynamic> json) {
    avgtemp_c = json['avgtemp_c'];
    maxtemp_c = json['maxtemp_c'];
    mintemp_c = json['mintemp_c'];
  }
}

class hourTempModel {
  String? time;
  dynamic temp_c;
  hourConditionModel? condition;
  hourTempModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temp_c = json['temp_c'];
    condition = json['condition'] != null
        ? hourConditionModel.fromJson(json['condition'])
        : null;
  }
}

class hourConditionModel {
  String? text;
  String? image;
  hourConditionModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['icon'];
  }
}
