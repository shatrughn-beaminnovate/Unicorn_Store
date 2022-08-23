part of 'view_cart_product_list_bloc.dart';

abstract class ViewCartProductListEvent extends Equatable {
  const ViewCartProductListEvent();

  @override
  List<Object> get props => [];
}

class LoadCartProductList extends ViewCartProductListEvent
{ 

  final String token;

  const LoadCartProductList(this.token);
 
  @override
  List<Object> get props => [token];

}