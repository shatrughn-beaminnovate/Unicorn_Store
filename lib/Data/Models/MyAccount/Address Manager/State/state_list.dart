import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'state_list.g.dart';

@JsonSerializable()
class StateList {
  @JsonKey(name: "data")
  final List<StateData>? state;

  factory StateList.fromJson(Map<String, dynamic> stateList) =>
      _$StateListFromJson(stateList);
  Map<String, dynamic> toJson() => _$StateListToJson(this);

  StateList(this.state);

  @override
  String toString() => 'StateList(state: $state)';
}
