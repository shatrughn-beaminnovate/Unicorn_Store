import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Account%20Information/account_info_details.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Account%20Information/address_details.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Account%20Information/account_information_details_repository.dart';

part 'account_information_api_fetch_event.dart';
part 'account_information_api_fetch_state.dart';

class AccountInformationApiFetchBloc extends Bloc<
    AccountInformationApiFetchEvent, AccountInformationApiFetchState> {
  AccountInformationApiFetchBloc()
      : super(AccountInformationApiFetchInitial()) {
    final AccountInformationDetailsRepository _accountInformationRepository =
        AccountInformationDetailsRepository();

    on<LoadAccountDetailsApiFetch>((event, emit) async {
      try {
        emit(AccountInformationApiFetchLoading());
        final _accountDetails = await _accountInformationRepository
            .getAccountDetails( event.token);

        emit(AccountInformationApiFetchLoaded(_accountDetails));
      } catch (e) {
        emit(AccountInformationApiFetchError(e.toString()));
      }
    });

    //Updating Customer Address
    on<UpdateCustomerAccountDetailsEvent>((event, emit) async {
      try {
        emit(AccountInformationApiFetchLoading());

        final _updateUserAddressResponse =
            await _accountInformationRepository.updateUserAccountInformation(event.token,event.addressData);

        emit(UpdateCustomerAccountDetailsSuccess(_updateUserAddressResponse));
      } catch (e) {
        emit(AccountInformationApiFetchError(e.toString()));
      }
    });
  }
}
