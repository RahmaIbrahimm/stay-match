// lib/features/location/presentation/manager/location_state.dart

part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class GovernoratesLoadedState extends LocationState {
  final List<Governorate> governorates;

  const GovernoratesLoadedState(this.governorates);

  @override
  List<Object?> get props => [governorates];
}

class LocationErrorState extends LocationState {
  final String message;
  final String? details;

  const LocationErrorState({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];
}