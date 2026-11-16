import 'package:flutter/material.dart';

class AboutVRoutePage extends StatelessWidget {
  const AboutVRoutePage({super.key});

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
        title: Text('About VRoute'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/about_vroute_image.png',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              const Text(
                'About VRoute',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              const Text(
                'This app is designed to provide an interactive experience for university students and visitors. '
                    'VRoute offers detailed information about the university, its facilities, and AR experiences to navigate '
                    'and explore the campus more efficiently. With features like puzzles and interactive AR views, VRoute ensures '
                    'that every user has a unique and enjoyable journey within the campus.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              const Text(
                'One of the purposes of designing this application stems from the lessons I learned from my own challenges. When I came to Abdullah Gül University, I directly skipped the preparatory year by passing the exemption exam and started my department. Because of this, I didn\'t have the chance to get to know the university as thoroughly as the 90% of students who attend the preparatory program. Naturally, not knowing the campus, the buildings, or the way things work—like where things are located, how processes are carried out, the campus structure, and classroom arrangements—was very challenging for me.This is exactly where the idea of designing an application about the university comes from in my case. With this application, I aim to provide meaningful and valuable information about the university to everyone who has just arrived or is considering coming here. Even if they aren\'t physically at the university or haven\'t come yet, they will have access to detailed information and sufficient data about the campus.\n\n'
                'Not only that, but I also see this application as highly open to improvement. If I were to work with a team instead of as an individual, I believe that in the future, this application could have an excellent user interface, become a realistic marketing tool, and fully meet the universitys promotional needs. I frequently reflect on this, and after completing this phase of the project, I am determined to continue working on this application and present it to the university administration. I sincerely hope that my enthusiasm and determination for this project will continue.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
