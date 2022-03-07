import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/address_list.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Address%20Manager/address_manager_details_repository.dart';

part 'address_manager_details_api_fetch_event.dart';
part 'address_manager_details_api_fetch_state.dart';

class AddressManagerDetailsApiFetchBloc extends Bloc<
    AddressManagerDetailsApiFetchEvent, AddressManagerDetailsApiFetchState> {
  AddressManagerDetailsApiFetchBloc()
      : super(AddressManagerDetailsApiFetchInitial()) {
    final AddressManagerDetailsRepository _addressManagerDetailsRepository =
        AddressManagerDetailsRepository();

    on<LoadAddressDetailsApiFetch>((event, emit) async {
      try {
        emit(AddressManagerDetailsApiFetchLoading());
        final _addressDetails = await _addressManagerDetailsRepository
            .getAddressManagerDetails(event.customerId,event.token);

        emit(AddressManagerDetailsApiFetchLoaded(_addressDetails));
      } catch (e) {
        emit(AddressManagerDetailsApiFetchError(e.toString()));
      }
    });


    on<DeleteCustomerAddressEvent>((event, emit) async {
      try {
        emit(AddressManagerDetailsApiFetchLoading());
        final _deleteUserAddressResponse =
            await _addressManagerDetailsRepository
                .deleteUserAddress(event.addressId,event.token);
        final _addressDetails = await _addressManagerDetailsRepository
            .getAddressManagerDetails(event.customerId,event.token);
        emit(DeleteCustomerAddressSuccess(
            _addressDetails, _deleteUserAddressResponse));
      } catch (e) {
        emit(AddressManagerDetailsApiFetchError(e.toString()));
      }
    });


   
  }
}
