import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:eduventure_video_call/constants/colors.dart';
import 'package:eduventure_video_call/utils/spacer.dart';
import 'package:eduventure_video_call/utils/toast.dart';

class JoiningDetails extends StatefulWidget {
  final bool isCreateMeeting;
  final Function onClickMeetingJoin;

  const JoiningDetails(
      {Key? key,
      required this.isCreateMeeting,
      required this.onClickMeetingJoin})
      : super(key: key);

  @override
  State<JoiningDetails> createState() => _JoiningDetailsState();
}

class _JoiningDetailsState extends State<JoiningDetails> {
  String _meetingId = "";
  String _displayName = "";
  String meetingMode = "GROUP";
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0),
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: gray02),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child:
            Center(
              child: Text(
                "GROUP",
                textAlign: TextAlign.center,
                style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        const VerticalSpacer(16),
        if (!widget.isCreateMeeting)
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: gray02),
            child: TextField(
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontWeight: FontWeight.w500,
                color: colorBlack,
                fontSize: 14
              ),
              onChanged: ((value) => _meetingId = value),
              decoration: InputDecoration(
                  constraints: BoxConstraints.tightFor(
                    width: ResponsiveValue<double>(context, conditionalValues: [
                      Condition.equals(name: MOBILE, value: maxWidth / 1.3),
                      Condition.equals(name: TABLET, value: maxWidth / 1.3),
                      Condition.equals(name: DESKTOP, value: 640),
                    ]).value!,
                  ),
                  hintText: "Enter meeting code",
                  hintStyle:  TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorBlack,
                    fontSize: 14
                  ),
                  border: InputBorder.none),
            ),
          ),
        if (!widget.isCreateMeeting) const VerticalSpacer(16),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: gray02),
          child: TextField(
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontWeight: FontWeight.w500,
              color: colorBlack,
                fontSize: 14
            ),
            onChanged: ((value) => _displayName = value),
            decoration: InputDecoration(
                constraints: BoxConstraints.tightFor(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: maxWidth / 1.3),
                    Condition.equals(name: TABLET, value: maxWidth / 1.3),
                    Condition.equals(name: DESKTOP, value: 640),
                  ]).value!,
                ),
                hintText: "Enter your name",
                hintStyle:  TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorBlack,
                    fontSize: 14
                ),
                border: InputBorder.none),
          ),
        ),
        const VerticalSpacer(16),
        MaterialButton(
            minWidth: ResponsiveValue<double>(context, conditionalValues: [
              Condition.equals(name: MOBILE, value: maxWidth / 1.3),
              Condition.equals(name: TABLET, value: maxWidth / 1.3),
              Condition.equals(name: DESKTOP, value: 650),
            ]).value!,
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: colorPrimary,
            elevation: 0,
            child:  Text("Join Meeting", style: TextStyle(fontSize: 16, color: colorWhite)),
            onPressed: () {
              if (_displayName.trim().isEmpty) {
                showSnackBar(
                     "Please enter name",  context);
                return;
              }
              if (!widget.isCreateMeeting && _meetingId.trim().isEmpty) {
                showSnackBar(
                     "Please enter meeting id",  context);
                return;
              }
              widget.onClickMeetingJoin(
                  _meetingId.trim(), meetingMode, _displayName.trim());
            }),
      ],
    );
  }
}
