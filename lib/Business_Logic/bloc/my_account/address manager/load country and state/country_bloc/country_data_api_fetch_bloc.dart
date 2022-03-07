import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Address%20Manager/Country%20Dropdown/country_list.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Address%20Manager/address_manager_details_repository.dart';

part 'country_data_api_fetch_event.dart';
part 'country_data_api_fetch_state.dart';

class CountryDataApiFetchBloc extends Bloc<CountryDataApiFetchEvent, CountryDataApiFetchState> {
  CountryDataApiFetchBloc() : super(CountryDataApiFetchInitial()) {
      final AddressManagerDetailsRepository _addressManagerDetailsRepository =
        AddressManagerDetailsRepository();
     on<LoadCountryDataFetchApi>((event, emit) async {
      try {
        //emit(CountryDataApiFetchLoading());
        final _countryList =
            await _addressManagerDetailsRepository.getCountryList(event.token);
        emit(CountryDataApiFetchLoded(_countryList));
      } catch (e) {
        emit(CountryDataApiFetchError(e.toString()));
      }
    });

  }
}
