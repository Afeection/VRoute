import 'package:flutter/material.dart';

class AboutAGUPage extends StatelessWidget {
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
        title: Text('About AGU'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/agu_kullan1.png',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 19),
            Text(
              "The first steps towards founding Abdullah Gül University were taken, by the Kayseri City Council and other city notables, in 2007. The aim was to raise the profile of education in Kayseri in line with the city's own vision of its development.",
              style: TextStyle(fontSize: 23, height: 1.5),
            ),
            SizedBox(height: 19),
            Image.asset(
              'assets/agu_kullan3.png',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 19),
            Text(
              "The University was named after the 11th president of the Turkish Republic, Abdullah Gül, who has accepted this honor, for the university is being dedicated to the quest to become a distinguished high-quality university in Turkey and be able to compete with international institutions.",
              style: TextStyle(fontSize: 23, height: 1.5),
            ),
            SizedBox(height: 19),
            Image.asset(
              'assets/agu_kullan4.png',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 19),
            Text(
              "The university was formally founded on 21 July 2010 as Turkey's first foundation supported State University. AGU admitted its first students in 2013 - 2014 Academic Year.",
              style: TextStyle(fontSize: 23, height: 1.5),
            ),
            SizedBox(height: 19),
            Image.asset(
              'assets/agu_kullan5.png',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 19),
            Text(
              "Education is being conducted at the site of Turkey's first industrial complex, which is being transformed from a place of great historical significance to be a notable place of education.\n\n"
              "-Faculty of Engineering\n\n"
              "-Computer Engineering\n\n"
              "-Electrical and Electronics Engineering\n\n"
              "-Industrial Engineering\n\n"
              "-Civil Engineering\n\n"
              "\n\n"
              " -Faculty of Architecture\n\n"
              " -Architecture\n\n"
              " -Faculty of Management Sciences\n\n"
              " -Business Administration\n\n"
              " -Economics\n\n"
              " -Faculty of Humanities and Social Sciences\n\n"
              " -Political Science and International Relations\n\n"
              " -Psychology\n\n"
              "- Faculty of Educational Sciences\n\n"
              " -Faculty of Life and Natural Sciences\n\nMolecular Biology and Genetics\n\nBioengineering\n\n"
              "Schools\n\n -School of Physical Education and Sports\n\n - School of Foreign Languages\n\n"
              " - Centers and Institutes\n\n - Graduate School of Natural Sciences\n\n"
              " - Graduate School of Social Sciences\n\n - Lifelong Learning Center  - (HAYMER)\n\n"
              "Digital Publications Center  - (DYM)\n\nCampus Structure\n\n - Sümer Campus\n\n"
              " - The Sümer Campus was established through the transformation of the Sümerbank Kayseri Textile Factory, which operated between 1935 and 1999, into an educational campus.\n\n"
              "Mimar Sinan Campus\n\n"
              "With its new and modern design, it serves as the main campus of AGÜ.",
              style: TextStyle(fontSize: 23, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
