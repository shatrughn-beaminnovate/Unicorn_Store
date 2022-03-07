part of 'state_data_api_fetch_bloc.dart';

abstract class StateDataApiFetchEvent extends Equatable {
  const StateDataApiFetchEvent();

  @override
  List<Object> get props => [];
}

class LoadStateData extends StateDataApiFetchEvent {
  final String countryID;
  final String token;

  const LoadStateData({required this.countryID,required this.token});

   @override
  List<Object> get props => [countryID,token];




}
