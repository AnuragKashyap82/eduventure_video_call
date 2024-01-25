import 'package:eduventure_video_call/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:eduventure_video_call/utils/spacer.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(strokeWidth: 2, color: colorPrimary,),
            const VerticalSpacer(20),
            Text("Creating a Room",
                style: TextStyle(
                    fontSize: 16,
                    color: colorBlack,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
