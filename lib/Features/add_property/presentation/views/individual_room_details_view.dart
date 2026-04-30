import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/shared/progress_bar.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../manager/add_property_cubit.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/location_and_gallery_widgets/property_gallery_widget.dart';

// Brand Colors from image_a8aeb9.png
const Color kPrimaryNavy = Color(0xFF1A2E63);
const Color kAccentBlue = Color(0xFFE8EEF9);
const Color kTextGrey = Color(0xFF667085);
const Color kBorderColor = Color(0xFFD0D5DD);

class IndividualRoomDetailsView extends StatelessWidget {
  const IndividualRoomDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyCubit, AddPropertyState>(
      listener: (context, state) {
        if (state is AddPropertySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message), backgroundColor: Colors.green),
          );
        } else if (state is AddPropertyFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errMessage), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddPropertyCubit>();
        final rooms = cubit.roomRequest.rooms ?? [];

        return Scaffold(
          backgroundColor: AppColors.fieldFillColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: kPrimaryNavy),
            title: const Text("Step 3 of 5",
                style: TextStyle(color: kTextGrey, fontSize: 14)),
            actions: [
              Text(
                "${((cubit.currentStep + 1) / 5 * 100).toInt()}% Complete",
                style: const TextStyle(color: kTextGrey, fontSize: 12),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Column(
            children: [
              ProgressBar(stepNumber: BlocProvider
                  .of<AddPropertyCubit>(context)
                  .currentStep),
              LinearProgressIndicator(
                value: 3 / 5,
                backgroundColor: kAccentBlue,
                color: kPrimaryNavy,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Individual Room Details",
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryNavy)),
                      const SizedBox(height: 4),
                      const Text(
                          "Provide specific information for each unit or room available in your property.",
                          style: TextStyle(color: kTextGrey, fontSize: 13)),
                      const SizedBox(height: 24),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rooms.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                        itemBuilder: (context, index) =>
                            RoomDetailCard(index: index, room: rooms[index]),
                      ),

                      const SizedBox(height: 20),

                      _buildAddRoomButton(cubit),

                      const SizedBox(height: 32),
                      const Text("Property Images", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryNavy)),
                      const SizedBox(height: 12),
                      // PropertyGalleryWidget(),
                      const SizedBox(height: 40),
                      _buildBottomButtons(cubit, state),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddRoomButton(AddPropertyCubit cubit) {
    return InkWell(
      onTap: () => cubit.addRoom(),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: kAccentBlue.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: kPrimaryNavy.withValues(alpha: 0.2), style: BorderStyle.solid),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: kPrimaryNavy),
            SizedBox(width: 8),
            Text("Add Another Room", style: TextStyle(
                color: kPrimaryNavy, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainImagePicker(AddPropertyCubit cubit) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor, style: BorderStyle.none),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: kAccentBlue, shape: BoxShape.circle),
            child: const Icon(
                Icons.apartment_outlined, color: kPrimaryNavy, size: 30),
          ),
          const SizedBox(height: 12),
          const Text("Drag & drop or Click to upload",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("PNG, JPG up to 10MB (Min 5 photos recommended)",
              style: TextStyle(color: kTextGrey, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(AddPropertyCubit cubit, AddPropertyState state) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => cubit.prevStep(),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 52),
              side: const BorderSide(color: kBorderColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
                "Previous", style: TextStyle(color: Colors.black)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: state is AddPropertyLoading ? null : () =>
                cubit.submit(),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryNavy,
              minimumSize: const Size(0, 52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: state is AddPropertyLoading
                ? const SizedBox(height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
                : const Text("Continue", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class RoomDetailCard extends StatelessWidget {
  final int index;
  final dynamic room;

  const RoomDetailCard({super.key, required this.index, required this.room});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPropertyCubit>();
    final roomImages = cubit.localRoomImages[index] ?? [];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kBorderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: kAccentBlue, borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.bed_outlined, color: kPrimaryNavy),
        ),
        title: Text(room.roomName ?? "Room ${index + 1}: Master Suite",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: kPrimaryNavy)),
        subtitle: const Text("Fully Furnished • En-suite",
            style: TextStyle(fontSize: 12, color: kTextGrey)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Room Photos", style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildAddPhotoButton(() => cubit.pickRoomImages(index)),
                      ...roomImages.map((file) => _buildImagePreview(file)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                _buildLabel("Room Name"),
                TextField(
                  decoration: const InputDecoration(hintText: "Master Bedroom"),
                  onChanged: (v) => cubit.updateRoomBasicData(index, name: v),
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField(
                        "Monthly Rent", "1200", Icons.attach_money, (v) =>
                        cubit.updateRoomBasicData(
                            index, rent: int.tryParse(v)))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField(
                        "Deposit", "1200", Icons.attach_money, (v) =>
                        cubit.updateRoomBasicData(
                            index, deposit: int.tryParse(v)))),
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField(
                        "Min. Stay (Months)", "6", null, (v) =>
                        cubit.updateRoomBasicData(index))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField(
                        "Available From", "05/11/2024",
                        Icons.calendar_today_outlined, null, readOnly: true)),
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildStyledCounter(
                        "Total Capacity", room.capacity ?? 1, (v) =>
                        cubit.updateRoomCapacity(index, total: v))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStyledCounter(
                        "Available Spots", room.capacityAvailable ?? 1, (v) =>
                        cubit.updateRoomCapacity(index, available: v))),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Fully Furnished", style: TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryNavy)),
                    Switch(
                      value: room.furnished ?? true,
                      activeColor: Colors.white,
                      activeTrackColor: kPrimaryNavy,
                      onChanged: (v) =>
                          cubit.updateRoomBasicData(index, isEnSuite: v),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                _buildLabel("Bathroom Type"),
                Row(
                  children: [
                    _buildChoiceBtn("En-suite", room.enSuiteBathroom, () =>
                        cubit.updateRoomBasicData(index, isEnSuite: true)),
                    const SizedBox(width: 12),
                    _buildChoiceBtn("Shared", room.sharedBathroom, () =>
                        cubit.updateRoomBasicData(index, isEnSuite: false)),
                  ],
                ),

                const SizedBox(height: 20),
                _buildLabel("Key Features"),
                _buildKeyFeatures(cubit, index, room),

                const SizedBox(height: 20),
                _buildLabel("Room Amenities"),
                _buildAmenities(cubit, index, room),

                const SizedBox(height: 20),
                _buildLabel("Allowed Tenants"),
                _buildTenantChips(cubit, index, room),

                const SizedBox(height: 20),
                _buildGenderSection(cubit, index, room),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- Helper Widget Builders ---

  Widget _buildLabel(String text) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: kPrimaryNavy)),
      );

  Widget _buildTextField(String label, String hint, IconData? icon,
      Function(String)? onChanged, {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        TextField(
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon, size: 18) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildAddPhotoButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: kAccentBlue.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kPrimaryNavy.withValues(alpha: 0.1)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, color: kPrimaryNavy, size: 20),
            Text("Add Photo",
                style: TextStyle(fontSize: 10, color: kPrimaryNavy)),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(File file) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(file, width: 90, height: 90, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildStyledCounter(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          height: 48,
          decoration: BoxDecoration(color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () => onChanged(value > 1 ? value - 1 : 1),
                  icon: const Icon(Icons.remove, size: 16)),
              Text("$value",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(onPressed: () => onChanged(value + 1),
                  icon: const Icon(Icons.add, size: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceBtn(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? kAccentBlue : Colors.white,
            border: Border.all(color: isSelected ? kPrimaryNavy : kBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(text, style: TextStyle(
              color: isSelected ? kPrimaryNavy : kTextGrey,
              fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildKeyFeatures(AddPropertyCubit cubit, int idx, dynamic room) {
    return Wrap(
      spacing: 8,
      children: [
        _buildFeatureChip("Balcony", Icons.balcony, room.balcony, () =>
            cubit.toggleRoomKeyFeature(idx, 'Balcony')),
        _buildFeatureChip("Window", Icons.window, room.window, () =>
            cubit.toggleRoomKeyFeature(idx, 'Window')),
        _buildFeatureChip("Pets Allowed", Icons.pets, room.petsAllowed, () =>
            cubit.toggleRoomKeyFeature(idx, 'Pets')),
      ],
    );
  }

  Widget _buildFeatureChip(String label, IconData icon, bool selected,
      VoidCallback onTap) {
    return FilterChip(
      avatar: Icon(icon, size: 14, color: selected ? kPrimaryNavy : kTextGrey),
      label: Text(label, style: TextStyle(
          color: selected ? kPrimaryNavy : kTextGrey, fontSize: 12)),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: Colors.white,
      selectedColor: kAccentBlue,
      checkmarkColor: kPrimaryNavy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: selected ? kPrimaryNavy : kBorderColor)),
    );
  }

  Widget _buildAmenities(AddPropertyCubit cubit, int idx, dynamic room) {
    final amenities = [
      {'key': 'airConditioning', 'label': 'Air conditioning'},
      {'key': 'closet', 'label': 'Closet'},
      {'key': 'mirror', 'label': 'Full Mirror'},
      {'key': 'fan', 'label': 'Ceiling Fan'},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 4),
      itemCount: amenities.length,
      itemBuilder: (context, i) {
        final item = amenities[i];
        final isSelected = room.roomAmenities?.toJson()[item['key']] ?? false;
        return Row(
          children: [
            Checkbox(
              value: isSelected,
              activeColor: kPrimaryNavy,
              onChanged: (_) => cubit.toggleRoomAmenity(idx, item['key']!),
            ),
            Text(item['label']!, style: const TextStyle(fontSize: 12)),
          ],
        );
      },
    );
  }

  Widget _buildTenantChips(AddPropertyCubit cubit, int idx, dynamic room) {
    return Wrap(
      spacing: 8,
      children: [
        _buildSimpleChip("Families", room.allowedTenants?.allowsFamilies, () =>
            cubit.toggleRoomTenantType(idx, 'Families')),
        _buildSimpleChip("Children", room.allowedTenants?.allowsChildren, () =>
            cubit.toggleRoomTenantType(idx, 'Children')),
        _buildSimpleChip("Students", room.allowedTenants?.allowsStudents, () =>
            cubit.toggleRoomTenantType(idx, 'Students')),
        _buildSimpleChip("Workers", room.allowedTenants?.allowsWorkers, () =>
            cubit.toggleRoomTenantType(idx, 'Workers')),
      ],
    );
  }

  Widget _buildSimpleChip(String label, bool? selected, VoidCallback onTap) {
    bool isSel = selected ?? false;
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(label, style: TextStyle(color: isSel
            ? kPrimaryNavy
            : kTextGrey, fontSize: 12)),
        backgroundColor: isSel ? kAccentBlue : const Color(0xFFF2F4F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: isSel ? kPrimaryNavy : Colors.transparent)),
      ),
    );
  }

  Widget _buildGenderSection(AddPropertyCubit cubit, int idx, dynamic room) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Gender preference:",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Row(
            children: [
              _buildRadio(
                  "Male", "Male", room, (v) => cubit.updateRoomGender(idx, v)),
              _buildRadio("Female", "Female", room, (v) =>
                  cubit.updateRoomGender(idx, v)),
              _buildRadio(
                  "Any", "any", room, (v) => cubit.updateRoomGender(idx, v)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRadio(String label, String value, dynamic room,
      Function(String) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: room.allowedTenants?.workerGender ?? "any",
          activeColor: kPrimaryNavy,
          onChanged: (v) => onChanged(v!),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}