import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/address_list.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Address%20Manager/address_manager_details_repository.dart';

part 'set_default_address_event.dart';
part 'set_default_address_state.dart';

class SetDefaultAddressBloc extends Bloc<SetDefaultAddressEvent, SetDefaultAddressState> {
  SetDefaultAddressBloc() : super(SetDefaultAddressInitial()) {
     final AddressManagerDetailsRepository _addressManagerDetailsRepository =
        AddressManagerDetailsRepository();
      on<SetDefaultAddresssDetails>((event, emit) async {
      try {
        final _setDefaultAddressResponse =
            await _addressManagerDetailsRepository.setDefaultAddress(
                event.customerId, event.addressId, event.addressType,event.token);
        final _addressDetails = await _addressManagerDetailsRepository
            .getAddressManagerDetails(event.customerId,event.token);
        emit(
            SetDefaultAddressSuccess(_setDefaultAddressResponse, _addressDetails));
      } catch (e) {
        emit(SetDefaultAddressError(e.toString()));
      }
    });
  }
}
