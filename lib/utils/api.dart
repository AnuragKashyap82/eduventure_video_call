import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> createMeeting(String _token) async {
  final String? _VIDEOSDK_API_ENDPOINT = "https://api.videosdk.live/v2";

  final Uri getMeetingIdUrl = Uri.parse('$_VIDEOSDK_API_ENDPOINT/rooms');
  final http.Response meetingIdResponse =
      await http.post(getMeetingIdUrl, headers: {
    "Authorization": _token,
  });

  if (meetingIdResponse.statusCode != 200) {
    throw Exception(json.decode(meetingIdResponse.body)["error"]);
  }
  var _meetingID = json.decode(meetingIdResponse.body)['roomId'];
  return _meetingID;
}

Future<bool> validateMeeting(String token, String meetingId) async {
  final String? _VIDEOSDK_API_ENDPOINT = "https://api.videosdk.live/v2";

  final Uri validateMeetingUrl =
      Uri.parse('$_VIDEOSDK_API_ENDPOINT/rooms/validate/$meetingId');
  final http.Response validateMeetingResponse =
      await http.get(validateMeetingUrl, headers: {
    "Authorization": token,
  });

  if (validateMeetingResponse.statusCode != 200) {
    throw Exception(json.decode(validateMeetingResponse.body)["error"]);
  }

  return validateMeetingResponse.statusCode == 200;
}

Future<dynamic> fetchSession(String token, String meetingId) async {
  final String? _VIDEOSDK_API_ENDPOINT = "https://api.videosdk.live/v2";

  final Uri getMeetingIdUrl =
      Uri.parse('$_VIDEOSDK_API_ENDPOINT/sessions?roomId=$meetingId');
  final http.Response meetingIdResponse =
      await http.get(getMeetingIdUrl, headers: {
    "Authorization": token,
  });
  List<dynamic> sessions = jsonDecode(meetingIdResponse.body)['data'];
  return sessions.first;
}
