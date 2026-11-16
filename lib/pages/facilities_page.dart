import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class FacilitiesPage extends StatelessWidget {
  final List<Map<String, dynamic>> facilities = [
    {
      "title": "Steel Building",
      "details": "The AGÜ Steel Building, with its student-friendly spaces such as table tennis, badminton playing areas, a copy center, and numerous student tables and study areas, also houses classrooms. On its upper floor, there is a cafeteria, while its lower floors accommodate various functional laboratory classrooms. The building is multipurpose and student-friendly. The steel building is divided into two sections, A and B. The A block of the building contains the rectorate and various administrative offices, along with offices for many professors and teachers. Therefore, it wouldn't be wrong to say that students often resolve their issues in this building.As mentioned earlier, the building includes spaces such as game areas and the copy center—a sort of student service center where students can make photocopies and fulfill other needs they might have at school. It's safe to say that this building is a central hub for students. Visitors or members of the school will agree that the steel building is one of the most frequented places, where students gather, chat, and spend most of their time during the day.",
      "image": 'assets/steel_building.png',
    },
    {
      "title": "BA Building",
      "details": "The BA Building derives its name from Büyük Ambar (Great Warehouse). Previously a factory warehouse, this building is now the home of architecture students. It has a very student-friendly study area and a dining hall that is indispensable for students. Additionally, many teachers' offices are located on its second floor, making it a frequented location for students.",
      "image": 'assets/ba_building.png',
    },
    {
      "title": "Factory Building",
      "details": "As the name suggests, the Factory Building was one of the primary production buildings of the old factory. Currently under renovation and expansion, this building also houses many laboratories and classrooms. Additionally, the newly integrated upper-floor study areas are among the main reasons why students prefer this building.",
      "image": 'assets/factory_building.png',
    },
    {
      "title": "Laboratory Building",
      "details": "As the name suggests, the Laboratory Building is especially home to molecular biology and genetics students, while also hosting various student groups' laboratories and classrooms. It can be said that the basement level is equipped with laboratories accessible to students from all departments.",
      "image": 'assets/laboratory_building.png',
    },
    {
      "title": "Fitness Center",
      "details": "When I first came to school, the most common thing I heard about the Fitness Center was that it was previously used by the Kayserispor professional football team. I think this alone is enough to demonstrate the quality of the equipment here. Upon arrival at the school, you can register for a free subscription to the Fitness Center via booked.com.",
      "image": 'assets/fitness_center.png',
    },
    {
      "title": "Sport Facilities",
      "details": "Sports facilities include football, basketball, volleyball, tennis, table tennis, and badminton areas. Reservations for the football turf field, basketball, and tennis courts can be made through the Fitness Center for one-and-a-half-hour slots during available times.",
      "image": 'assets/sport_facilities.png',
    },
    {
      "title": "Other Mentions",
      "details": "AGÜ is a relatively new third-generation state university, established after the Sümer Factory. Other notable places on campus include House M Café, Starbucks, Elif Café, and Afili Café. The International Office, which handles Erasmus applications and other international student matters, is also located here.",
      "image": 'assets/other_mentions.png',
    },
  ];

  void _sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'Channel description',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF578E7E),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Facilities'),
      ),
      body: Container(
        color: Color(0xFFFF9D23),
        child: ListView.builder(
          itemCount: facilities.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                facilities[index]["title"]!,
                style: TextStyle(fontSize: 18, color: Color(0xFF2A004E)),
              ),
              trailing: Icon(Icons.arrow_forward, color: Color(0xFF2A004E)),
              onTap: () {
                _showDetails(context, facilities[index]);
              },
            );
          },
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, Map<String, dynamic> facility) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                facility["title"]!,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A004E),
                ),
              ),
              SizedBox(height: 16),
              Image.asset(
                facility["image"]!,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    facility["details"]!,
                    style: TextStyle(fontSize: 25, color: Colors.black87),
                  ),
                ),
              ),
              if (facility["title"] == "Other Mentions")
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      _sendNotification(
                        'Warning!',
                        'YOU SOLVED THE PUZZLE',
                      );
                      Navigator.pushNamed(context, '/puzzles');
                    },
                    child: Text(
                      'Do Not Touch!',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
