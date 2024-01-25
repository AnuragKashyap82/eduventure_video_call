import 'package:flutter/material.dart';
import 'package:eduventure_video_call/utils/spacer.dart';

import '../../../constants/colors.dart';

// Meeting ActionBar
class MeetingActionBar extends StatelessWidget {
  // control states
  final bool isMicEnabled, isCamEnabled, isScreenShareEnabled;
  final String recordingState;

  // callback functions
  final void Function() onCallEndButtonPressed,
      onCallLeaveButtonPressed,
      onMicButtonPressed,
      onCameraButtonPressed,
      onChatButtonPressed;

  final void Function(String) onMoreOptionSelected;

  final void Function(TapDownDetails) onSwitchMicButtonPressed;
  const MeetingActionBar({
    Key? key,
    required this.isMicEnabled,
    required this.isCamEnabled,
    required this.isScreenShareEnabled,
    required this.recordingState,
    required this.onCallEndButtonPressed,
    required this.onCallLeaveButtonPressed,
    required this.onMicButtonPressed,
    required this.onSwitchMicButtonPressed,
    required this.onCameraButtonPressed,
    required this.onMoreOptionSelected,
    required this.onChatButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PopupMenuButton(
              position: PopupMenuPosition.under,
              padding: const EdgeInsets.all(0),
              color: gray02,
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: colorPrimary),
                  color: colorPrimary,
                ),
                padding: const EdgeInsets.all(8),
                child:  Icon(
                  Icons.call_end,
                  size: 30,
                  color: colorBlack,
                ),
              ),
              offset: const Offset(0, -185),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) => {
                    if (value == "leave")
                      onCallLeaveButtonPressed()
                    else if (value == "end")
                      onCallEndButtonPressed()
                  },
              itemBuilder: (context) => <PopupMenuEntry>[
                    _buildMeetingPoupItem(
                      "leave",
                      "Leave",
                      "Only you will leave the call",
                      Icon(Icons.output_rounded, color: colorBlack,),
                    ),
                    const PopupMenuDivider(),
                    _buildMeetingPoupItem(
                      "end",
                      "End",
                      "End call for all participants",
                      Icon(Icons.group_remove, color: colorBlack,),
                    ),
                  ]),

          // Mic Control
          GestureDetector(
            onTap: onMicButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: colorPrimary),
                color:   colorPrimary,
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    isMicEnabled ? Icons.mic : Icons.mic_off,
                    size: 30,
                    color: isMicEnabled ? colorBlack : colorBlack,
                  ),
                  GestureDetector(
                      onTapDown: (details) =>
                          {onSwitchMicButtonPressed(details)},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: isMicEnabled ? colorBlack : colorBlack,
                        ),
                      )),
                ],
              ),
            ),
          ),

          // Camera Control
          GestureDetector(
            onTap: onCameraButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: colorPrimary),
                color: isCamEnabled ? colorPrimary : colorPrimary,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(isCamEnabled?Icons.videocam:Icons.videocam_off, color: colorBlack,)
            ),
          ),

          GestureDetector(
            onTap: onChatButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: colorPrimary),
                color: colorPrimary,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.chat_rounded, color: colorBlack,)
            ),
          ),

          // More options
          PopupMenuButton(
              position: PopupMenuPosition.under,
              padding: const EdgeInsets.all(0),
              color: gray02,
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: colorPrimary),
                  color: colorPrimary
                  // color: red,
                ),
                padding: const EdgeInsets.all(8),
                child:  Icon(
                  Icons.more_vert,
                  size: 30,
                  color: colorBlack,
                ),
              ),
              offset: const Offset(0, -250),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) => {onMoreOptionSelected(value.toString())},
              itemBuilder: (context) => <PopupMenuEntry>[
                    _buildMeetingPoupItem(
                      "recording",
                      recordingState == "RECORDING_STARTED"
                          ? "Stop Recording"
                          : recordingState == "RECORDING_STARTING"
                              ? "Recording is starting"
                              : "Start Recording",
                      null,
                      Icon(Icons.record_voice_over_outlined, color: colorBlack,)
                    ),
                    const PopupMenuDivider(),
                    _buildMeetingPoupItem(
                      "screenshare",
                      isScreenShareEnabled
                          ? "Stop Screen Share"
                          : "Start Screen Share",
                      null,
                        Icon(Icons.share_rounded, color: colorBlack,)
                    ),
                    const PopupMenuDivider(),
                    _buildMeetingPoupItem(
                      "participants",
                      "Participants",
                      null,
                        Icon(Icons.groups, color: colorBlack,)
                    ),
                  ]),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _buildMeetingPoupItem(
      String value, String title, String? description, Widget leadingIcon) {
    return PopupMenuItem(
      value: value,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Row(children: [
        leadingIcon,
        const HorizontalSpacer(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorBlack),
            ),
            if (description != null) const VerticalSpacer(4),
            if (description != null)
              Text(
                description,
                style:  TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, color: Colors.green),
              )
          ],
        )
      ]),
    );
  }
}
