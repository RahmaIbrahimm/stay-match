import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';

import 'info_cell.dart';

class InfoGrid extends StatelessWidget {
  final RoomDetailsResponseData data;

  const InfoGrid({required this.data});

  String _formatDate(String? iso) {
    if (iso == null) return '—';
    try {
      final d = DateTime.parse(iso);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[d.month - 1]} ${d.day}';
    } catch (_) {
      return '—';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cells = [
      InfoCell(
        label: 'DEPOSIT',
        value: data.deposit != null ? '${data.deposit} EGP' : '1 Month',
      ),
      // InfoCell(label: 'AVAILABILITY', value: _formatDate(data.availableFrom)),
      // InfoCell(
      //   label: 'MIN. STAY',
      //   value: data.minimumStay != null
      //       ? '${data.minimumStay} Month${data.minimumStay == 1 ? '' : 's'}'
      //       : '—',
      // ),
      InfoCell(
        label: 'CAPACITY',
        value: data.capacityAvailable != null
            ? '${data.capacityAvailable} of ${data.capacity} free'
            : '—',
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 2.4,
      children: cells,
    );
  }
}