class OperatingHoursList {
  final List<OperatingHours> operating_hours;

  OperatingHoursList({
    this.operating_hours,
});

  factory OperatingHoursList.fromJson(List<dynamic> parsedJson) {

    List<OperatingHours> operating_hours = new List<OperatingHours>();

    operating_hours = parsedJson.map((i)=> OperatingHours.fromJson(i)).toList();

    return OperatingHoursList(
      operating_hours: operating_hours
    );
  }
}

class OperatingHours{
  final int dayOfWeek;
  final String openTime;
  final String closeTime;

  OperatingHours({
    this.dayOfWeek,
    this.openTime,
    this.closeTime
}) ;

  factory OperatingHours.fromJson(Map<String, dynamic> json){
    return OperatingHours(
      dayOfWeek: json['dayOfWeek'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }

}