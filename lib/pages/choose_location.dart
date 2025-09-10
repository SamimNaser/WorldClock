import 'package:flutter/material.dart';
import '../world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  @override
  Widget build(BuildContext context) {

    List<WorldTime> locations = [
      WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin'),
      WorldTime(location: 'London', flag: 'uk.png', url: 'Europe/London'),
      WorldTime(location: 'Jakarta', flag: 'indonesia.png', url: 'Asia/Jakarta'),
      WorldTime(location: 'Seoul', flag: 'south_korea.png', url: 'Asia/Seoul'),
      WorldTime(location: 'Kolkata', flag: 'india.png', url: 'Asia/Kolkata'),
      WorldTime(location: 'Cairo', flag: 'egypt.png', url: 'Africa/Cairo'),
      WorldTime(location: 'New York', flag: 'usa.png', url: 'America/New_York'),
    ];

    void updateTime(index) async {
      WorldTime instance = locations[index];
      await instance.getTime();

      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'fulltime': instance.fulltime,
        'isDaytime': instance.isDaytime,
      });
    }

      return Scaffold(
        backgroundColor: Colors.black, // Dark background
        appBar: AppBar(
          backgroundColor: Colors.grey[900], // Darker AppBar
          title: const Text(
            'Choose a Location',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4.0),
              child: Card(
                color: Colors.grey[850], // Dark card
                child: ListTile(
                  onTap: () => updateTime(index),
                  title: Text(
                    locations[index].location,
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}
