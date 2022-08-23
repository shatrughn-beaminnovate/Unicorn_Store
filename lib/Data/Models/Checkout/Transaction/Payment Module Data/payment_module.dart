// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:unicorn_store/Data/Models/Checkout/Transaction/Payment%20Module%20Data/payment_module_data.dart';

class PaymentModule {
  final bool? status;
  final PaymentModuleData? data;
  PaymentModule({
    this.status,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'data': data?.toJson(),
    };
  }

  factory PaymentModule.fromJson(Map<String, dynamic> map) {
    return PaymentModule(
      status: map['status'] != null ? map['status'] as bool : null,
      data: map['data'] != null
          ? PaymentModuleData.fromJson(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() => 'PaymentModule(status: $status, data: $data)';
}
