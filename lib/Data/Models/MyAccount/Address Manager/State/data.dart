import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class StateData {
  final int? id;
  @JsonKey(name: "country_id")
  final int? countryId;
  final String? code;
  final String? name;
  final int? status;
  final int? tax;

  StateData(this.id, this.countryId, this.code, this.name, this.status, this.tax);

  factory StateData.fromJson(Map<String, dynamic> country) =>
      _$StateDataFromJson(country);
  Map<String, dynamic> toJson() => _$StateDataToJson(this);

  @override
  String toString() {
    return 'StateData(id: $id, countryId: $countryId, code: $code, name: $name, status: $status, tax: $tax)';
  }
}
