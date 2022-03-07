import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/State/state_list.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Address%20Manager/address_manager_details_repository.dart';

part 'state_data_api_fetch_event.dart';
part 'state_data_api_fetch_state.dart';

class StateDataApiFetchBloc
    extends Bloc<StateDataApiFetchEvent, StateDataApiFetchState> {
  StateDataApiFetchBloc() : super(StateDataApiFetchInitial()) {
    final AddressManagerDetailsRepository _addressManagerDetailsRepository =
        AddressManagerDetailsRepository();

    on<LoadStateData>((event, emit) async {
      try {
        emit(StateDataApiFetchLoading());
        final _stateList = await _addressManagerDetailsRepository
            .getStateList(event.countryID,event.token);
        emit(StateDataApiFetchLoaded(_stateList));
      } catch (e) {
        emit(StateDataApiFetchError(e.toString()));
      }
    });
  }
}
