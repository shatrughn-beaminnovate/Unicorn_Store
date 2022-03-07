import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/search_zip_address.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Address%20Manager/address_manager_details_repository.dart';

part 'search_zip_address_event.dart';
part 'search_zip_address_state.dart';

class SearchZipAddressBloc
    extends Bloc<SearchZipAddressEvent, SearchZipAddressState> {
  SearchZipAddressBloc() : super(SearchZipAddressInitial()) {
    final AddressManagerDetailsRepository _addressManagerDetailsRepository =
        AddressManagerDetailsRepository();

    on<LoadSearchZipAddress>((event, emit) async {
      try {
        emit(SearchZipAddressLoading());
        final _addressDetails = await _addressManagerDetailsRepository
            .searchPincodeAddress(event.pincode,event.token);
        emit(SearchZipAddressLoaded(_addressDetails));
      } catch (e) {
        emit(SearchZipAddressError(e.toString()));
      }
    });
  }
}
