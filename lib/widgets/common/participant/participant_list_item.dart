import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'package:eduventure_video_call/constants/colors.dart';

class ParticipantListItem extends StatefulWidget {
  final Participant participant;
  const ParticipantListItem({Key? key, required this.participant})
      : super(key: key);

  @override
  State<ParticipantListItem> createState() => _ParticipantListItemState();
}

class _ParticipantListItemState extends State<ParticipantListItem> {
  Stream? videoStream;
  Stream? audioStream;

  @override
  void initState() {
    widget.participant.streams.forEach((key, Stream stream) {
      if (stream.kind == "video") {
        videoStream = stream;
      } else if (stream.kind == 'audio') {
        audioStream = stream;
      }
      log("Stream: " + stream.kind.toString());
    });

    super.initState();
    addParticipantListener(widget.participant);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      decoration: BoxDecoration(
          color: gray02, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: colorPrimary),
            ),
            child: const Icon(Icons.person),
          ),
          Expanded(
              child: Text(
            widget.participant.isLocal ? "You" : widget.participant.displayName,
            style:  TextStyle(
              color: colorBlack,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: audioStream != null ? colorPrimary : colorPrimary,
              border: Border.all(color: audioStream != null ? colorPrimary : colorPrimary,),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(audioStream != null ? Icons.mic : Icons.mic_off, color: colorBlack,),
          ),
          Container(
            // margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: videoStream != null ?colorPrimary : colorPrimary,
              border: Border.all(color: videoStream != null ? colorPrimary : colorPrimary,),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(videoStream != null?Icons.videocam:Icons.videocam_off, color: colorBlack,)
          ),
        ],
      ),
    );
  }

  void addParticipantListener(Participant participant) {
    participant.on(Events.streamEnabled, (Stream _stream) {
      if (mounted) {
        setState(() {
          if (_stream.kind == "video") {
            videoStream = _stream;
          } else if (_stream.kind == 'audio') {
            audioStream = _stream;
          }
        });
      }
    });

    participant.on(Events.streamDisabled, (Stream _stream) {
      if (mounted) {
        setState(() {
          if (_stream.kind == "video") {
            videoStream = null;
          } else if (_stream.kind == 'audio') {
            audioStream = null;
          }
        });
      }
    });
  }
}
