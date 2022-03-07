import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Country {
  final int? id;
  final int? sequence;
  final String? name;

  @JsonKey(name: "iso_code_2")
  final String? isoCode2;
  @JsonKey(name: "iso_code_3")
  final String? isoCode3;
  @JsonKey(name: "address_format")
  final String? addressFormat;
  @JsonKey(name: "zip_required")
  final int? zipRequired;
  final int? status;
  final int? tax;

  Country(this.id, this.sequence, this.name, this.isoCode2, this.isoCode3,
      this.addressFormat, this.zipRequired, this.status, this.tax);

  factory Country.fromJson(Map<String, dynamic> country) =>
      _$CountryFromJson(country);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  

  @override
  String toString() {
    return 'Country(id: $id, sequence: $sequence, name: $name, isoCode2: $isoCode2, isoCode3: $isoCode3, addressFormat: $addressFormat, zipRequired: $zipRequired, status: $status, tax: $tax)';
  }
}
