import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'package:eduventure_video_call/constants/colors.dart';
import 'package:eduventure_video_call/utils/api.dart';
import 'package:eduventure_video_call/utils/spacer.dart';
import 'package:eduventure_video_call/utils/toast.dart';
import 'package:eduventure_video_call/widgets/common/app_bar/recording_indicator.dart';

class MeetingAppBar extends StatefulWidget {
  final String token;
  final Room meeting;
  final String recordingState;
  final bool isFullScreen;
  const MeetingAppBar(
      {Key? key,
      required this.meeting,
      required this.token,
      required this.isFullScreen,
      required this.recordingState})
      : super(key: key);

  @override
  State<MeetingAppBar> createState() => MeetingAppBarState();
}

class MeetingAppBarState extends State<MeetingAppBar> {
  Duration? elapsedTime;
  Timer? sessionTimer;

  List<MediaDeviceInfo> cameras = [];

  @override
  void initState() {
    startTimer();
    // Holds available cameras info
    cameras = widget.meeting.getCameras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: !widget.isFullScreen
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        secondChild: const SizedBox.shrink(),
        firstChild: Container(
          color: colorPrimary,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 4),
            child: Row(
              children: [
                if (widget.recordingState == "RECORDING_STARTING" ||
                    widget.recordingState == "RECORDING_STOPPING" ||
                    widget.recordingState == "RECORDING_STARTED")
                  RecordingIndicator(recordingState: widget.recordingState),
                if (widget.recordingState == "RECORDING_STARTING" ||
                    widget.recordingState == "RECORDING_STOPPING" ||
                    widget.recordingState == "RECORDING_STARTED")
                  const HorizontalSpacer(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.meeting.id,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Icon(
                                Icons.copy,
                                size: 16,
                              ),
                            ),
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.meeting.id));
                              showSnackBar(
                                   "Meeting ID has been copied.",
                                   context);
                            },
                          ),
                        ],
                      ),
                      // VerticalSpacer(),
                      Text(
                        elapsedTime == null
                            ? "00:00:00"
                            : elapsedTime.toString().split(".").first,
                        style:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colorBlack),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cameraswitch_outlined, color: colorBlack,),
                  onPressed: () {
                    MediaDeviceInfo newCam = cameras.firstWhere((camera) =>
                        camera.deviceId != widget.meeting.selectedCamId);
                    widget.meeting.changeCam(newCam.deviceId);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> startTimer() async {
    dynamic session = await fetchSession(widget.token, widget.meeting.id);
    DateTime sessionStartTime = DateTime.parse(session['start']);
    final difference = DateTime.now().difference(sessionStartTime);

    setState(() {
      elapsedTime = difference;
      sessionTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            elapsedTime = Duration(
                seconds: elapsedTime != null ? elapsedTime!.inSeconds + 1 : 0);
          });
        },
      );
    });
    // log("session start time" + session.data[0].start.toString());
  }

  @override
  void dispose() {
    if (sessionTimer != null) {
      sessionTimer!.cancel();
    }
    super.dispose();
  }
}
