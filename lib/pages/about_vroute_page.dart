import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AboutVRoutePage extends StatelessWidget {
  const AboutVRoutePage({super.key});

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
                expandedHeight: 260,
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
                      Image.asset('assets/about_vroute_image.png', fit: BoxFit.cover),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20, left: 20, right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('VRoute', style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white,
                            )),
                            Text('Your campus, explored.', style: GoogleFonts.inter(
                              fontSize: 13, color: Colors.white70,
                            )),
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
                      _chip('Campus Guide · AR Experience · Community', accent),
                      const SizedBox(height: 20),
                      _infoCard(
                        isDark, textColor, subColor,
                        'What is VRoute?',
                        'VRoute is designed to provide an interactive experience for university students and visitors. '
                        'It offers detailed information about the university, its facilities, and AR experiences to navigate '
                        'and explore the campus more efficiently. With features like puzzles and interactive AR views, '
                        'VRoute ensures that every user has a unique and enjoyable journey within the campus.',
                      ),
                      const SizedBox(height: 16),
                      _infoCard(
                        isDark, textColor, subColor,
                        'The Story Behind It',
                        'One of the purposes of designing this application stems from lessons learned from real challenges. '
                        'When first arriving at Abdullah Gül University — skipping the preparatory year by passing the exemption exam — '
                        'there was no chance to learn the campus the way 90% of students do through the prep program. '
                        'Not knowing the buildings, processes, classroom arrangements, or campus structure was genuinely difficult.\n\n'
                        'That experience is exactly where this idea came from. VRoute aims to give every newcomer — '
                        'or even someone who hasn\'t arrived yet — meaningful, accurate information about the campus '
                        'before they ever set foot on it.',
                      ),
                      const SizedBox(height: 16),
                      _infoCard(
                        isDark, textColor, subColor,
                        'Looking Forward',
                        'VRoute is highly open to improvement. With a full team and continued development, '
                        'it could become a realistic marketing and navigation tool that fully meets the university\'s '
                        'promotional needs. The goal is to present this to the university administration and continue '
                        'growing it beyond the current phase.',
                      ),
                      const SizedBox(height: 24),
                      _statsRow(isDark, textColor, subColor, accent),
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

  Widget _chip(String label, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: accent.withValues(alpha: 0.12),
      ),
      child: Text(label, style: GoogleFonts.inter(
        fontSize: 11, fontWeight: FontWeight.w500, color: accent,
      )),
    );
  }

  Widget _infoCard(bool isDark, Color textColor, Color subColor, String title, String body) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? const Color(0x1EFFFFFF) : const Color(0xCCFFFFFF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w700, color: textColor,
              )),
              const SizedBox(height: 10),
              Text(body, style: GoogleFonts.inter(
                fontSize: 14, height: 1.75, color: textColor,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statsRow(bool isDark, Color textColor, Color subColor, Color accent) {
    const stats = [
      (Icons.school_rounded, '7', 'Faculties'),
      (Icons.business_rounded, '7', 'Buildings'),
      (Icons.people_rounded, '5K+', 'Students'),
    ];

    return Row(
      children: stats.map((s) {
        final isLast = s == stats.last;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0x1EFFFFFF) : const Color(0xCCFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(s.$1, color: accent, size: 20),
                      const SizedBox(height: 6),
                      Text(s.$2, style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700, color: textColor,
                      )),
                      Text(s.$3, style: GoogleFonts.inter(fontSize: 11, color: subColor)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
