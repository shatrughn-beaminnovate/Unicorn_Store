part of 'accessories_data_fetch_bloc.dart';

abstract class AccessoriesDataFetchState extends Equatable {
  const AccessoriesDataFetchState();
  
  @override
  List<Object> get props => [];
}

class AccessoriesDataFetchInitial extends AccessoriesDataFetchState {}

class AccessoriesDataFetchLoading extends AccessoriesDataFetchState {}

class AccessoriesDataFetchLoaded extends AccessoriesDataFetchState {
  final AccessoriesListData accessoriesListData;

  const AccessoriesDataFetchLoaded(this.accessoriesListData);
}

class AccessoriesDataFetchError extends AccessoriesDataFetchState {
  final String? message;
  const AccessoriesDataFetchError(this.message);
}