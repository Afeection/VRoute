import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PuzzlesPage extends StatelessWidget {
  final Uri _url = Uri.parse('https://www.jigsawplanet.com/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzles'),
        backgroundColor: Color(0xFF578E7E),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/puzzle_image.png',
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                "WHY WOULD YOU NAME YOUR PAGE PUZZLES IF YOU CAN NOT OPEN IT , RIGHT ? UNLESS THATS THE PUZZLE ...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "Congratulations, Oh Great Solver of Mysteries! 🎉\n\n"
                "You\'ve done it! Against all odds, through trials of wits and whispers of logic,\n\n "
                    "you\'ve uncovered the sacred... uh... thing! Was it the meaning of life? A recipe for a perfect pancake?\n\n "
                    "Or just a really strange code that said you win? Honestly, we have no idea, but hey, you nailed it!💥\n\n",
                style: TextStyle(fontSize: 19),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: Text(
                  'Click Here to Visit the Link',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
