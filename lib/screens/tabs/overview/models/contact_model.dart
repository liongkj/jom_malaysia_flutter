import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactVM {
  ContactVM(
      {this.mobileNumber,
      this.officeNumber,
      this.website,
      this.fax,
      this.email});
  final String mobileNumber;
  final String officeNumber;
  final String website;
  final String fax;
  final String email;

  factory ContactVM.fromJson(Map<String, dynamic> json) =>
      _$ContactVMFromJson(json);

  Map<String, dynamic> toJson() => _$ContactVMToJson(this);
  String getContactNumber() {
    if (mobileNumber.isNotEmpty) {
      return mobileNumber;
    }
    if (officeNumber.isNotEmpty) {
      return officeNumber;
    }
    return null;
  }
}