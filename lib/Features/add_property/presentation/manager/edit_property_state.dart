// edit_property_state.dart
part of 'edit_property_cubit.dart';

sealed class EditPropertyState extends Equatable {
  const EditPropertyState();
  @override
  List<Object?> get props => [];
}

class EditPropertyInitial extends EditPropertyState {}
class EditPropertyLoading extends EditPropertyState {}

class EditPropertyLoaded extends EditPropertyState {
  final DateTime updatedAt;
  const EditPropertyLoaded(this.updatedAt);
  @override
  List<Object?> get props => [updatedAt];
}

class EditPropertySuccess extends EditPropertyState {
  final String message;
  final int propertyId;
  const EditPropertySuccess({required this.message, required this.propertyId});
  @override
  List<Object?> get props => [message, propertyId];
}

class EditPropertyFailure extends EditPropertyState {
  final String errMessage;
  const EditPropertyFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}