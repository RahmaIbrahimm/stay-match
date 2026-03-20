import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stay_match/core/constants/app_icons.dart';

// Add this temporary debug widget
class DebugSvgWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(AppIcons.sizeIcon),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          print('SVG content loaded, length: ${snapshot.data?.length}');
          return Column(
            children: [
              Text('SVG loaded: ${snapshot.data?.length} chars'),
              SvgPicture.string(
                snapshot.data ?? '',
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
void main(){
  DebugSvgWidget();
}
// Use it in your widget temporarily