import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  final String location; // e.g., 'Kolkata'
  final String url;      // e.g., 'Asia/Kolkata'
  final String flag;     // e.g., 'india.png'

  late String time;      // formatted time (e.g., "10:23 AM")
  late String fulltime; // raw full datetime string from API
  late bool isDaytime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      final response = await http.get(
        Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // fulltime = raw full timestamp from API
        fulltime = data['dateTime']; // e.g., "2024-06-05T10:23:00"

        // Parse and format
        DateTime now = DateTime.parse(fulltime);

        isDaytime = now.hour > 6 && now.hour < 20 ? true : false ;
        time = DateFormat.jm().format(now); // e.g., "10:23 AM"

      } else {
        print('Failed to load: ${response.statusCode}');
        time = 'Could not load time';
        fulltime = '';
        isDaytime = true;
      }
    } catch (e) {
      print('Error: $e');
      time = 'Error occurred';
      fulltime = '';
      isDaytime = true;
    }
  }
}