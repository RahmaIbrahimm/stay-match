import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/shared/add_property_app_bar.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(AppStrings.editProfile, style: AppStyles.bold20poppins),
          centerTitle: true,
          pinned: true,
          leading: Icon(Icons.arrow_back, color: Colors.black),
          actions: [Icon(Icons.menu,color: Colors.black,)],
          actionsPadding: EdgeInsetsGeometry.directional(end: 12.w),
        ),

      ],
    );
  }
}

// return Scaffold(
//   backgroundColor: Colors.white,
//   appBar: AppBar(
//     title: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
//     centerTitle: true,
//     backgroundColor: Colors.white,
//     elevation: 0,
//     leading: const Icon(Icons.arrow_back, color: Colors.black),
//     actions: [
//       IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.grid_view_rounded, color: Colors.black)
//       )
//     ],
//   ),
//   body: SingleChildScrollView(
//     padding: EdgeInsets.symmetric(horizontal: 20.w),
//     child: Column(
//       children: [
//         SizedBox(height: 20.h),
//         _buildAvatarSection(),
//         SizedBox(height: 12.h),
//         Text("Ahmed Hassan", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
//         Text("Architecture Student @ AUC", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
//         Text("New Cairo, Egypt", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
//
//         SizedBox(height: 24.h),
//         _buildTextField("Full Name", _nameController),
//         _buildTextField("Email Address", TextEditingController(text: "ahmed.hassan@example.com")),
//
//         Row(
//           children: [
//             Expanded(child: _buildTextField("Phone", TextEditingController(text: "+2 234 567 890"))),
//             SizedBox(width: 15.w),
//             Expanded(child: _buildDropdown("Gender", "Male")),
//           ],
//         ),
//
//         _buildTextField("Education", TextEditingController(text: "B.Sc. Architecture")),
//         _buildTextField("Job Title", TextEditingController(text: "Senior Designer")),
//
//         _buildSectionHeader("Compatibility Preferences"),
//         _buildTextField("About Me", _bioController, maxLines: 3),
//
//         _buildToggleTile("Smoker", isSmoker, (v) => setState(() => isSmoker = v)),
//         _buildToggleTile("Has Pets", isPetFriendly, (v) => setState(() => isPetFriendly = v)),
//         _buildToggleTile("Night Owl", isNightOwl, (v) => setState(() => isNightOwl = v)),
//
//         _buildSectionHeader("Housing Preferences"),
//         Row(
//           children: [
//             Expanded(child: _buildDropdown("Governorate", "Cairo")),
//             SizedBox(width: 15.w),
//             Expanded(child: _buildTextField("Budget (\$/mo)", TextEditingController(text: "1200"))),
//           ],
//         ),
//
//         _buildSectionHeader("Vibe Check"),
//         _buildSlider("Cultural Importance", culturalImportance, "High", (v) => setState(() => culturalImportance = v)),
//         _buildSlider("Cleanliness Level", cleanlinessLevel, "Fully Basic", (v) => setState(() => cleanlinessLevel = v)),
//
//         _buildSectionHeader("Account Security"),
//         _buildTextField("New Password", TextEditingController(), obscure: true),
//         _buildTextField("Confirm Password", TextEditingController(), obscure: true),
//
//         SizedBox(height: 20.h),
//         _buildActionButton("Delete Account", Colors.red[50]!, Colors.red, isDelete: true),
//         SizedBox(height: 12.h),
//         _buildActionButton("Save Changes", const Color(0xFF1A2E63), Colors.white),
//         SizedBox(height: 40.h),
//       ],
//     ),
//   ),
// );
// --- UI Component Helpers ---
// File? _profileImage;
// final ImagePicker _picker = ImagePicker();
//
// // Preference States
// bool isSmoker = false;
// bool isPetFriendly = true;
// bool isNightOwl = false;
// double culturalImportance = 0.8;
// double cleanlinessLevel = 0.5;
//
// // Controllers for personal data
// late TextEditingController _nameController;
// late TextEditingController _bioController;
//
// @override
// void initState() {
//   super.initState();
//   // Pre-filling with data as seen in your project summary
//   _nameController = TextEditingController(text: "Ahmed Hassan");
//   _bioController = TextEditingController(
//     text: "Quiet, organized professional looking for a clean space. I enjoy coding and hiking.",
//   );
// }
// final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
// if (pickedFile != null) {
// setState(() {
// _profileImage = File(pickedFile.path);
// });
// // You can now call your binary upload logic here
// }
// Widget _buildAvatarSection() {
//   return Stack(
//     alignment: Alignment.bottomRight,
//     children: [
//       CircleAvatar(
//         radius: 55.r,
//         backgroundColor: Colors.blueGrey[50],
//         backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
//         child: _profileImage == null ? Icon(Icons.person, size: 50.r, color: Colors.grey) : null,
//       ),
//       GestureDetector(
//         onTap: _pickProfileImage,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(color: Color(0xFF1A2E63), shape: BoxShape.circle),
//           child: Icon(Icons.edit, color: Colors.white, size: 16.sp),
//         ),
//       )
//     ],
//   );
// }
//
// Widget _buildSectionHeader(String title) {
//   return Container(
//     width: double.infinity,
//     padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
//     child: Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
//   );
// }
//
// Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1, bool obscure = false}) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 15.h),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
//         SizedBox(height: 6.h),
//         TextField(
//           controller: controller,
//           maxLines: maxLines,
//           obscureText: obscure,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: const Color(0xFFF7F8FA),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
//             contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildDropdown(String label, String value) {
//   return CustomDropDownMenu(menuItems: AppStrings.genderMenuItems, hintText: profile);
// }
//
// Widget _buildToggleTile(String label, bool value, Function(bool) onChanged) {
//   return Container(
//     margin: EdgeInsets.only(bottom: 8.h),
//     decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(10.r)),
//     child: SwitchListTile(
//       title: Text(label, style: TextStyle(fontSize: 14.sp)),
//       value: value,
//       onChanged: onChanged,
//       activeColor: const Color(0xFF1A2E63),
//     ),
//   );
// }
//
// Widget _buildSlider(String label, double value, String trailing, Function(double) onChanged) {
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 13.sp)),
//           Text(trailing, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A2E63))),
//         ],
//       ),
//       Slider(
//         value: value,
//         onChanged: onChanged,
//         activeColor: const Color(0xFF1A2E63),
//         inactiveColor: Colors.grey[200],
//       ),
//     ],
//   );
// }
//
// Widget _buildActionButton(String text, Color bg, Color textColor, {bool isDelete = false}) {
//   return SizedBox(
//     width: double.infinity,
//     height: 50.h,
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: bg,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.r),
//           side: isDelete ? BorderSide(color: Colors.red[100]!) : BorderSide.none,
//         ),
//       ),
//       onPressed: () {},
//       child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 15.sp)),
//     ),
//   );
// }