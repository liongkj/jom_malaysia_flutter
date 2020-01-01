import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressVM {
  AddressVM(
      {@required this.add1,
      this.add2,
      @required this.city,
      @required this.state,
      @required this.postalCode,
      @required this.coordinates,
      @required this.country});
  String add1;
  String add2;
  String city;
  String state;
  String postalCode;
  String country;
  CoordinatesModel coordinates;

  final _stateList = {"NSN": "Negeri Sembilan"};
  final _countryList = {"MY": "Malaysia"};

  @override
  String toString() {
    return '$add1, ${add2?.toString()}, $postalCode $city, ${_stateList[this.state]}, ${_countryList[this.country]}';
  }

  factory AddressVM.fromJson(Map<String, dynamic> json) =>
      _$AddressVMFromJson(json);

  Map<String, dynamic> toJson() => _$AddressVMToJson(this);
}
