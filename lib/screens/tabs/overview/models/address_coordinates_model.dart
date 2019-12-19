class Coordinates{
    double longtitude;
    double latitude;

    Coordinates(this.longtitude,this.latitude);

    Coordinates.fromJson(Map<String,dynamic>json)
    : longtitude = json['longtitude'],
      latitude = json['latitude'];
}