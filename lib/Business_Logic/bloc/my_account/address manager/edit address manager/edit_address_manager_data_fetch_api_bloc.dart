import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/Edit%20Address%20Manager/address_data.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/Edit%20Address%20Manager/edit_address_list.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Address%20Manager/address_manager_details_repository.dart';

part 'edit_address_manager_data_fetch_api_event.dart';
part 'edit_address_manager_data_fetch_api_state.dart';

class EditAddressManagerDataFetchApiBloc extends Bloc<
    EditAddressManagerDataFetchApiEvent, EditAddressManagerDataFetchApiState> {
  EditAddressManagerDataFetchApiBloc()
      : super(EditAddressManagerDataFetchApiInitial()) {
    final AddressManagerDetailsRepository _addressManagerDetailsRepository =
        AddressManagerDetailsRepository();

    on<LoadEditAddressManagerDataFetchApi>((event, emit) async {
      try {
       // emit(EditAddressManagerDataFetchApiLoading());
        final _addressDetails = await _addressManagerDetailsRepository
            .getAddressManagerDetailsEdit( event.addressId,event.token);

        emit(EditAddressManagerDataFetchApiLoaded(_addressDetails));
      } catch (e) {
        emit(EditAddressManagerDataFetchApiError(e.toString()));
      }
    });

    
    on<AddCustomerAddressEvent>((event, emit) async {
      try {
        emit(EditAddressManagerDataFetchApiLoading());
        final _addUserAddressResponse =
            await _addressManagerDetailsRepository.addUserAddress(event.addressData,event.token);

        emit(AddCustomerAddressSuccess(_addUserAddressResponse));
      } catch (e) {
        emit(EditAddressManagerDataFetchApiError(e.toString()));
      }
    });

     on<UpdateCustomerAddressEvent>((event, emit) async {
      try {
                emit(EditAddressManagerDataFetchApiLoading());

        final _updateUserAddressResponse =
            await _addressManagerDetailsRepository
                .updateUserAddress(event.addressId,event.addressData,event.token);

        emit(UpdateCustomerAddressSuccess(_updateUserAddressResponse));
      } catch (e) {
        emit(EditAddressManagerDataFetchApiError(e.toString()));
      }
    });

  
  }
}
