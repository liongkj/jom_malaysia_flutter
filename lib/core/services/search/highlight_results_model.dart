import 'package:json_annotation/json_annotation.dart';

part 'highlight_results_model.g.dart';

enum QueryMatchedLevel { none, full }

@JsonSerializable()
class HighLightResultsModel {
  HighLightResultsModel(this.value, this.matchLevel, this.matchedWords);

  String value;
  QueryMatchedLevel matchLevel;
  List<String> matchedWords;

  factory HighLightResultsModel.fromJson(Map<String, dynamic> json) =>
      _$HighLightResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HighLightResultsModelToJson(this);
}
