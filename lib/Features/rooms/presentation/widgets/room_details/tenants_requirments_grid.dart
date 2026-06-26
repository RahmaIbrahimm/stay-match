import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/room_details/requirment_cell.dart';

class TenantRequirementsGrid extends StatelessWidget {
  final RoomDetailsResponseData data;

  const TenantRequirementsGrid({required this.data});

  String _gender() {
    final t = data.allowedTenants;
    if (t == null) return 'Any';
    if (t.workerGender != null && t.allowsWorkers == true) {
      return '${_cap(t.workerGender!)} Only';
    }
    if (t.studentGender != null && t.allowsStudents == true) {
      return '${_cap(t.studentGender!)} Only';
    }
    return 'Any';
  }

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  String _occupancy() {
    final avail = data.capacityAvailable;
    if (avail == null) return '—';
    return avail == 1 ? '1 Person Only' : '$avail People';
  }

  @override
  Widget build(BuildContext context) {
    final cells = [
      RequirementCell(
        icon: data.allowedTenants?.studentGender?.toLowerCase() == 'female'
            ? MdiIcons.genderFemale
            : MdiIcons.genderMale,
        label: 'GENDER',
        value: _gender(),
      ),
      RequirementCell(
        icon: Icons.school_outlined,
        label: 'STATUS',
        value: data.allowedTenants?.allowsStudents == true
            ? 'Students OK'
            : 'No Students',
      ),
      RequirementCell(
        icon: Icons.work_outline,
        label: 'PROFESSION',
        value: data.allowedTenants?.allowsWorkers == true
            ? 'Workers OK'
            : 'No Workers',
      ),
      RequirementCell(
        icon: Icons.people_outline,
        label: 'OCCUPANCY',
        value: _occupancy(),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 1.5,
      children: cells,
    );
  }
}