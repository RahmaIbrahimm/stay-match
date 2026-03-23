import 'package:flutter/material.dart';

enum FilterTypeProperty { apartment, room }

enum FilterTypeGender { student, worker }

typedef OnFiltersChanged =
    void Function({
      bool? allowsFamilies,
      bool? allowsChildren,
      bool? allowsStudents,
      String? studentGender,
      bool? allowsWorkers,
      String? workerGender,
      bool? onlyAvailable,
      FilterTypeProperty? filterType,
    });
typedef OnChangeGender = void Function(String? value);
typedef OnChangedBool = void Function(bool? value);
typedef OnFilterTypeChanged = void Function(FilterTypeProperty value);

class FilterWidget extends StatelessWidget {
  final bool? allowsFamilies;
  final bool? allowsChildren;
  final bool? allowsStudents;
  final String? studentGender;
  final bool? allowsWorkers;
  final String? workerGender;
  final bool? onlyAvailable;
  final FilterTypeProperty filterType;

  // Individual callbacks
  final OnFilterTypeChanged? onFilterTypeChanged;

  // Combined callback
  final OnFiltersChanged? onFiltersChanged;

  const FilterWidget({
    super.key,
    this.allowsFamilies,
    this.allowsChildren,
    this.allowsStudents,
    this.studentGender,
    this.allowsWorkers,
    this.workerGender,
    this.onlyAvailable,
    required this.filterType,
    this.onFilterTypeChanged,
    this.onFiltersChanged,
  });

  void _notifyChanges({
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    String? studentGender,
    bool? allowsWorkers,
    String? workerGender,
    bool? onlyAvailable,
    FilterTypeProperty? filterType,
  }) {
    // Call individual callbacks
    if (filterType != null) onFilterTypeChanged?.call(filterType);

    // Call combined callback with all values
    onFiltersChanged?.call(
      allowsFamilies: allowsFamilies ?? this.allowsFamilies,
      allowsChildren: allowsChildren ?? this.allowsChildren,
      allowsStudents: allowsStudents ?? this.allowsStudents,
      studentGender: studentGender ?? this.studentGender,
      allowsWorkers: allowsWorkers ?? this.allowsWorkers,
      workerGender: workerGender ?? this.workerGender,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      filterType: filterType ?? this.filterType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Example usage
        Switch(
          value: allowsFamilies ?? false,
          onChanged: (value) => _notifyChanges(allowsFamilies: value),
        ),
        // ... rest of your UI
      ],
    );
  }
}