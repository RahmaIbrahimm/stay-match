import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/add_basic_info_widgets/property_details_screen_section.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/shared/validation_helper.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../manager/add_property_cubit.dart';
import '../shared/add_property_app_bar.dart';
import '../shared/add_property_buttons.dart';
import '../shared/progress_bar.dart';
import 'room_capacity_section.dart';
import 'tenant_preferences_section.dart';

class AddBasicInfoBody extends StatefulWidget {
  const AddBasicInfoBody({super.key});

  @override
  State<AddBasicInfoBody> createState() => _AddBasicInfoBodyState();
}

class _AddBasicInfoBodyState extends State<AddBasicInfoBody> {
  late TextEditingController nameController,
      descController,
      rentController,
      depositController,
      sizeController,
      dateController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final req = context.read<AddPropertyCubit>().apartmentRequest;
    nameController = TextEditingController(text: req.name);
    descController = TextEditingController(text: req.description);
    rentController = TextEditingController(
      text: (req.monthlyRent ?? 0) > 0 ? req.monthlyRent.toString() : '',
    );
    depositController = TextEditingController(
      text: (req.deposite ?? 0) > 0 ? req.deposite.toString() : '',
    );
    sizeController = TextEditingController(
      text: (req.size ?? 0) > 0 ? req.size.toString() : '',
    );
    dateController = TextEditingController(
      text: req.availableFrom?.split('T')[0],
    );
  }

  @override
  void dispose() {
    for (var c in [
      nameController,
      descController,
      rentController,
      depositController,
      sizeController,
      dateController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String isoDate = picked.toIso8601String();
      setState(() => dateController.text = isoDate.split('T')[0]);
      if (context.mounted)
        context.read<AddPropertyCubit>().apartmentRequest.availableFrom = isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      buildWhen: (_, current) => current is AddPropertyFormUpdated,
      builder: (context, state) {
        final cubit = context.read<AddPropertyCubit>();

        return Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              AddPropertyAppBar(cubit: cubit, title: AppStrings.addProperty),
              SliverToBoxAdapter(
                child: RPadding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProgressBar(stepNumber: cubit.currentStep + 1),
                ),
              ),
              SliverToBoxAdapter(
                child: RPadding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      PropertyDetailsSection(
                        cubit: cubit,
                        nameController: nameController,
                        descController: descController,
                        rentController: rentController,
                        depositController: depositController,
                        sizeController: sizeController,
                        dateController: dateController,
                        onSelectDate: () => _selectDate(context),
                      ),
                      SizedBox(height: 32.h),
                      RoomCapacitySection(cubit: cubit),
                      SizedBox(height: 32.h),
                      TenantPreferencesSection(cubit: cubit),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: RPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: AddPropertyButtons(
                    cubit: cubit,
                    nextPageRoute: AppRouting.addAmenitiesName,
                    onNextPressed: () => _handleValidationAndNavigation(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleValidationAndNavigation() {
    final cubit = context.read<AddPropertyCubit>();
    final req = cubit.apartmentRequest;
    final t = req.allowedTenants;

    // 1. Check TextFields (Name, Description, Rent, Size)
    // This triggers the red error text under the fields
    if (!_formKey.currentState!.validate()) {
      _showError("Please fix the errors in the form");
      return;
    }

    // 2. Check Allowed Tenants Selection
    final bool hasHumanTenant = t != null &&
        (t.allowsFamilies == true || t.allowsChildren == true ||
            t.allowsStudents == true || t.allowsWorkers == true);

    if (!hasHumanTenant) {
      if (t?.petsAllowed == true) {
        _showError("Pets aren't enough! Please select at least one other tenant type.");
      } else {
        _showError("Please select at least one allowed tenant category.");
      }
      return;
    }

    // 3. Check Preferred Gender
    if (req.allowedTenants?.workerGender == null || req.allowedTenants?.studentGender == null) {
      _showError("Please select the preferred gender for tenants.");
      return;
    }

    // 4. Check Availability Date
    if (req.availableFrom == null) {
      _showError("Please select when the property will be available.");
      return;
    }

    // 5. Final Step: If the helper confirms everything is 100% valid
    if (ValidationHelper.isBasicInfoValid(req)) {
      cubit.nextStep();
      context.pushNamed(AppRouting.addAmenitiesName);
    }
  }

// Helper to show the SnackBar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.medium14poppins.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
      ),
    );
  }}