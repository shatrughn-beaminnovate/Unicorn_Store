// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class AttributesOption {
  final int? id;
  final String? option_name;
  final int? sort_order;
  final String? swatch_value;
  final String? attribute_name;

  AttributesOption(this.id, this.option_name, this.sort_order, this.swatch_value, this.attribute_name);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'option_name': option_name,
      'sort_order': sort_order,
      'swatch_value': swatch_value,
      'attribute_name': attribute_name,
    };
  }

  factory AttributesOption.fromJson(Map<String, dynamic> map) {
    return AttributesOption(
      map['id'] != null ? map['id'] as int : null,
      map['option_name'] != null ? map['option_name'] as String : null,
      map['sort_order'] != null ? map['sort_order'] as int : null,
      map['swatch_value'] != null ? map['swatch_value'] as String : null,
      map['attribute_name'] != null ? map['attribute_name'] as String : null,
    );
  }

  @override
  String toString() {
    return 'AttributesOption(id: $id, option_name: $option_name, sort_order: $sort_order, swatch_value: $swatch_value, attribute_name: $attribute_name)';
  }
}
