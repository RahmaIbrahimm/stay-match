import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../apartments/data/models/all_apartments.dart';
import '../../../apartments/presentation/widgets/shared/apartment_card.dart';


class ApartmentList extends StatelessWidget {
  const ApartmentList({
    super.key,
    required this.properties,
  });

  final List<AllApartmentsItems>? properties;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return properties!.isEmpty
        ? Center(
      child: Text('No rooms available', style: TextStyle(fontSize: 30.sp)),
    )
        : SizedBox(
      height: 320.h,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: properties!.length,
        itemBuilder: (context, index) {
          return ApartmentCard(property: properties?[index]);
        }, separatorBuilder: (BuildContext context, int index) {
        return  SizedBox(width: 16.w,);
      },
      ),
    );
  }
}
// lib/features/shared/presentation/widgets/apartment_list.dart
// import 'package:flutter/material.dart';
// import '../../../shared/presentation/views/apartments/data/models/all_apartments.dart';
// import '../../../shared/presentation/views/apartments/presentation/widgets/apartment_card.dart';
//
// class ApartmentList extends StatelessWidget {
//   final List<Items>? shared;
//   final ListViewType listViewType;
//
//   const ApartmentList({
//     super.key,
//     required this.shared,
//     this.listViewType = ListViewType.horizontal,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (shared == null || shared!.isEmpty) {
//       return const Center(
//         child: Text(
//           'No rooms available',
//           style: TextStyle(fontSize: 30),
//         ),
//       );
//     }
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         switch (listViewType) {
//           case ListViewType.horizontal:
//             return _buildHorizontalList(constraints);
//           case ListViewType.grid:
//             return _buildGridView(constraints);
//           case ListViewType.vertical:
//             return _buildVerticalList(constraints);
//         }
//       },
//     );
//   }
//
//   Widget _buildHorizontalList(BoxConstraints constraints) {
//     return SizedBox(
//       height: constraints.maxHeight,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: shared!.length,
//         separatorBuilder: (context, index) => const SizedBox(width: 16),
//         itemBuilder: (context, index) {
//           return SizedBox(
//             width: constraints.maxWidth * 0.7, // 70% of parent width
//             child: ApartmentCard(
//               property: shared![index],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildGridView(BoxConstraints constraints) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.75,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       itemCount: shared!.length,
//       itemBuilder: (context, index) {
//         return ApartmentCard(
//           property: shared![index],
//         );
//       },
//     );
//   }
//
//   Widget _buildVerticalList(BoxConstraints constraints) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: shared!.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 16),
//       itemBuilder: (context, index) {
//         return ApartmentCard(
//           property: shared![index],
//         );
//       },
//     );
//   }
// }
//
// enum ListViewType {
//   horizontal,
//   grid,
//   vertical,
// }