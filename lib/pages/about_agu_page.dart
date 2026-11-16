import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AboutAGUPage extends StatelessWidget {
  const AboutAGUPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final accent    = isDark ? AppColors.teal : AppColors.tealDark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(gradient: isDark ? AppColors.darkBg : AppColors.lightBg),
            child: const SizedBox.expand(),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
                    child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/agu_kullan1.png', fit: BoxFit.cover),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.65),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 20, left: 20, right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Abdullah Gül University',
                              style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w700,
                                color: Colors.white, fontFamily: 'Poppins',
                              ),
                            ),
                            Text('Kayseri, Turkey · Est. 2010',
                              style: TextStyle(
                                fontSize: 13, color: Colors.white70, fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _section(
                        'Origins',
                        'The first steps towards founding Abdullah Gül University were taken by the Kayseri City Council and other city notables in 2007. The aim was to raise the profile of education in Kayseri in line with the city\'s own vision of its development.',
                        textColor, subColor, accent,
                      ),
                      const SizedBox(height: 20),
                      _imageCard('assets/agu_kullan3.png'),
                      const SizedBox(height: 20),
                      _section(
                        'The Name',
                        'The University was named after the 11th president of the Turkish Republic, Abdullah Gül, who accepted this honor — for the university is dedicated to the quest to become a distinguished, high-quality university in Turkey and to compete with international institutions.',
                        textColor, subColor, accent,
                      ),
                      const SizedBox(height: 20),
                      _imageCard('assets/agu_kullan4.png'),
                      const SizedBox(height: 20),
                      _section(
                        'Foundation',
                        'The university was formally founded on 21 July 2010 as Turkey\'s first foundation-supported State University. AGU admitted its first students in the 2013–2014 Academic Year.',
                        textColor, subColor, accent,
                      ),
                      const SizedBox(height: 20),
                      _imageCard('assets/agu_kullan5.png'),
                      const SizedBox(height: 20),
                      _section(
                        'Campus',
                        'Education is conducted at the site of Turkey\'s first industrial complex — the historic Sümerbank Kayseri Textile Factory (1935–1999) — transformed into a modern educational campus.',
                        textColor, subColor, accent,
                      ),
                      const SizedBox(height: 24),
                      _facultiesCard(isDark, textColor, subColor, accent),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String body, Color textColor, Color subColor, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w700, color: accent,
        )),
        const SizedBox(height: 8),
        Text(body, style: GoogleFonts.inter(
          fontSize: 14, height: 1.75, color: textColor,
        )),
      ],
    );
  }

  Widget _imageCard(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(path, height: 170, width: double.infinity, fit: BoxFit.cover),
    );
  }

  Widget _facultiesCard(bool isDark, Color textColor, Color subColor, Color accent) {
    const faculties = [
      ('Engineering', ['Computer Engineering', 'Electrical & Electronics Engineering', 'Industrial Engineering', 'Civil Engineering']),
      ('Architecture', ['Architecture']),
      ('Management Sciences', ['Business Administration', 'Economics']),
      ('Humanities & Social Sciences', ['Political Science & International Relations', 'Psychology']),
      ('Life & Natural Sciences', ['Molecular Biology & Genetics', 'Bioengineering']),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0x1EFFFFFF) : const Color(0xCCFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Faculties & Programs', style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w700, color: textColor,
              )),
              const SizedBox(height: 14),
              ...faculties.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6, height: 6,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
                        ),
                        const SizedBox(width: 8),
                        Text('Faculty of ${f.$1}', style: GoogleFonts.inter(
                          fontSize: 13, fontWeight: FontWeight.w600, color: accent,
                        )),
                      ],
                    ),
                    ...f.$2.map((dept) => Padding(
                      padding: const EdgeInsets.only(left: 14, top: 4),
                      child: Text('· $dept', style: GoogleFonts.inter(
                        fontSize: 12, color: subColor,
                      )),
                    )),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
