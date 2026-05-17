part of 'saved_properties_cubit.dart';

sealed class SavedPropertiesState extends Equatable {
  const SavedPropertiesState();
}

final class SavedPropertiesInitial extends SavedPropertiesState {
  @override
  List<Object> get props => [];
}

final class SavedPropertiesLoading extends SavedPropertiesState {
  @override
  List<Object> get props => [];
}

final class SavedPropertiesSuccess extends SavedPropertiesState {
  final MySavedResponse response;

  const SavedPropertiesSuccess({required this.response});

  @override
  List<Object> get props => [];
}

final class SavedPropertiesFailure extends SavedPropertiesState {
  final String errMessage;

  const SavedPropertiesFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class ToggleLoading extends SavedPropertiesState {
  @override
  List<Object> get props => [];
}

final class ToggleSuccess extends SavedPropertiesState {
  @override
  List<Object> get props => [];
}
final class ToggleFailure extends SavedPropertiesState {
  final String errMessage;

  const ToggleFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
final class FilterChanged extends SavedPropertiesState {
  final String currentType;
  const FilterChanged({required this.currentType});

  @override
  List<Object> get props => [currentType];
}