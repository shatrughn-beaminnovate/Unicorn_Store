part of 'address_manager_details_api_fetch_bloc.dart';

abstract class AddressManagerDetailsApiFetchEvent extends Equatable {
  const AddressManagerDetailsApiFetchEvent();

  @override
  List<Object> get props => [];
}

class LoadAddressDetailsApiFetch extends AddressManagerDetailsApiFetchEvent {
  final String customerId;
  final String token;

  const LoadAddressDetailsApiFetch({required this.customerId,required this.token});

  @override
  List<Object> get props => [customerId,token];
}


class DeleteCustomerAddressEvent extends AddressManagerDetailsApiFetchEvent {
  final String addressId;
  final String customerId;
  final String token;

  const DeleteCustomerAddressEvent(
      {required this.addressId, required this.customerId,required this.token});

  @override
  List<Object> get props => [addressId, customerId,token];
}



