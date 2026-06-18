part of 'shared_property_cubit.dart';

abstract class SharedPropertyState extends Equatable {
  const SharedPropertyState();
  @override
  List<Object?> get props => [];
}

class SharedPropertyInitial extends SharedPropertyState {}
class SharedPropertyLoading extends SharedPropertyState {}

class SharedPropertySuccess extends SharedPropertyState {
  final SharedApartmentDetails details;
  const SharedPropertySuccess({required this.details});
  @override
  List<Object?> get props => [details];
}

class SharedPropertyFailure extends SharedPropertyState {
  final String errMessage;
  const SharedPropertyFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}