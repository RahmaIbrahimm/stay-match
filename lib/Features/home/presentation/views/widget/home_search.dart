// import 'package:flutter/material.dart';
//
// class HomeSearch extends StatefulWidget {
//   HomeSearch({super.key, required this.validator, required this.hintText});
//
//   final String? Function(String?) validator;
//   final String hintText;
//
//   @override
//   State<HomeSearch> createState() => _HomeSearchState();
// }
//
// class _HomeSearchState extends State<HomeSearch> {
//   final TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   decoration: BoxDecoration(color: AppColors.containerColor),
//     //   child: Padding(
//     //     padding: const EdgeInsets.all(6),
//     //     child: Column(
//     //       children: [
//     //         Divider(thickness: 0.5, color: Colors.black),
//     //         SizedBox(height: 6),
//     //         CustomTextFormField(
//     //           hintText: hintText,
//     //           validator: validator,
//     //           controller: controller,
//     //           hintStyle: AppStyles.caption.copyWith(
//     //             color: AppColors.textColorSecondary,
//     //           ),
//     //           suffixIcon: IconButton(
//     //             color: AppColors.textColorSecondary,
//     //             onPressed: () {},
//     //             icon: Icon(Icons.search, size: 16),
//     //           ),
//     //           strokeWidth: 0.5,
//     //         ),
//     //         // Expanded(
//     //         //   flex: 2,
//     //         //   child: CustomElevatedButton(
//     //         //     text: AppStrings.search,
//     //         //     onPressed: () {},
//     //         //     textStyle: AppStyles.smallButton,
//     //         //   ),
//     //         // ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//     return DefaultTabController(child: TabBar(tabs:[Text('data'),Text('data')]));
//   }
// }