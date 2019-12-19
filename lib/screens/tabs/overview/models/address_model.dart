import 'address_coordinates_model.dart';

class Address {
  String add1;
  String add2;
  String city;
  String state;
  String postalCode;
  String country;
  Coordinates coordinates;

  Address(this.add1, this.add2, this.city,this.state,this.postalCode,this.country,this.coordinates);

  Address.fromJson(Map<String, dynamic> json)
      : add1 = json['add1'],
        add2 = json['add2'],
        city = json['city'],
        state = json['state'],
        postalCode = json['postalCode'],
        country = json['country'],
        coordinates = Coordinates.fromJson(json['coordinates']);
}