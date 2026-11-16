import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String email = args?['email'] ?? 'Guest';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF578E7E),
        title: Text('HOME'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome, $email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D3D3D),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
              children: [
                _buildGridItem(context, 'ABOUT AGU', '/aboutAGU'),
                _buildGridItem(context, 'FACILITIES', '/facilities'),
                _buildGridItem(context, 'ABOUT VROUTE', '/aboutVRoute'),
                _buildGridItem(context, 'WEATHER in Kayseri', '/weatherPage'),
                _buildGridItem(context, 'COMMENTS', '/comments'),
                _buildGridItem(context, 'PUZZLES', null),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/arExperience');
            },
            child: Container(
              height: 80,
              color: Color(0xFF577BC1),
              child: Center(
                child: Text(
                  'AR EXPERIENCE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF93827),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String? route) {
    return GestureDetector(
      onTap: () {
        if (title == 'PUZZLES') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Access Denied'),
              content: Text('Page Puzzles can not be opened, or is it tho?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Card(
        color: Color(0xFF577BC1),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF93827),
            ),
          ),
        ),
      ),
    );
  }
}
