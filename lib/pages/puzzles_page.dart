import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class PuzzlesPage extends StatelessWidget {
  const PuzzlesPage({super.key});

  static final _url = Uri.parse('https://www.jigsawplanet.com/');

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(gradient: isDark ? AppColors.darkBg : AppColors.lightBg),
            child: const SizedBox.expand(),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.black.withValues(alpha: 0.06),
                            border: Border.all(
                              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                            ),
                          ),
                          child: Icon(Icons.arrow_back_rounded, color: textColor, size: 18),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text('Puzzles', style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w700, color: textColor,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
                    child: Column(
                      children: [
                        _heroCard(isDark, textColor, subColor),
                        const SizedBox(height: 24),
                        _messageCard(isDark, textColor, subColor),
                        const SizedBox(height: 20),
                        _linkButton(context, isDark),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroCard(bool isDark, Color textColor, Color subColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [AppColors.error.withValues(alpha: 0.15), const Color(0xFF1A0A0A).withValues(alpha: 0.6)]
                  : [AppColors.error.withValues(alpha: 0.08), const Color(0xFFFFF0F0).withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.25), width: 1.5),
          ),
          child: Column(
            children: [
              Image.asset('assets/puzzle_image.png', height: 200, fit: BoxFit.contain),
              const SizedBox(height: 20),
              Text(
                'WHY WOULD YOU NAME YOUR PAGE\nPUZZLES IF YOU CAN\'T OPEN IT?\n\nUNLESS... THAT\'S THE PUZZLE.',
                style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w700,
                  color: AppColors.error, height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageCard(bool isDark, Color textColor, Color subColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(22),
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: AppColors.tealGradient,
                    ),
                    child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Text('Congratulations, Solver!', style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w700, color: textColor,
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'You\'ve done it. Against all odds, through trials of wit and whispers of logic, '
                'you\'ve uncovered the sacred... uh... thing.\n\n'
                'Was it the meaning of life? A recipe for a perfect pancake? Or just a really '
                'strange code that said you win? Honestly, we have no idea — but hey, you nailed it.',
                style: GoogleFonts.inter(
                  fontSize: 14, height: 1.75, color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linkButton(BuildContext context, bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () async {
          if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open link.')),
              );
            }
          }
        },
        icon: const Icon(Icons.open_in_new_rounded, size: 18),
        label: Text('Visit JigsawPlanet', style: GoogleFonts.poppins(
          fontSize: 15, fontWeight: FontWeight.w600,
        )),
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? AppColors.teal : AppColors.tealDark,
          side: BorderSide(
            color: isDark ? AppColors.teal : AppColors.tealDark,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
