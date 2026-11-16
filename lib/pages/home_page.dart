import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final email     = FirebaseAuth.instance.currentUser?.email ?? '';
    final name      = email.contains('@') ? email.split('@').first : 'Explorer';

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPad + 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_greeting(), style: GoogleFonts.inter(fontSize: 14, color: subColor)),
                      const SizedBox(height: 2),
                      Text(name, style: GoogleFonts.poppins(
                        fontSize: 26, fontWeight: FontWeight.w700, color: textColor,
                      )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/aboutVRoute'),
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: AppColors.tealGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.teal.withValues(alpha: 0.35),
                          blurRadius: 12, offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.explore_rounded, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // AR banner
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/arExperience'),
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A2A6C), Color(0xFF2D6A8F), Color(0xFF4ECBA8)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teal.withValues(alpha: 0.3),
                      blurRadius: 20, offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20, top: -20,
                      child: Container(
                        width: 140, height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.07),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 24, top: 0, bottom: 0,
                      child: Center(
                        child: Icon(
                          Icons.view_in_ar_rounded,
                          size: 72,
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('NEW', style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w700,
                              color: Colors.white, letterSpacing: 1,
                            )),
                          ),
                          const SizedBox(height: 10),
                          Text('AR Campus\nExperience', style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.w700,
                            color: Colors.white, height: 1.2,
                          )),
                          const Spacer(),
                          Row(
                            children: [
                              Text('Explore in AR', style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.white.withValues(alpha: 0.85),
                                fontWeight: FontWeight.w500,
                              )),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            Text('Explore Campus', style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600, color: textColor,
            )),
            const SizedBox(height: 14),

            GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
              children: [
                _NavTile(
                  title: 'About AGU',
                  sub: 'University info',
                  icon: Icons.school_rounded,
                  gradient: AppColors.tealGradient,
                  onTap: () => Navigator.pushNamed(context, '/aboutAGU'),
                  isDark: isDark,
                ),
                _NavTile(
                  title: 'About VRoute',
                  sub: 'App story',
                  icon: Icons.info_rounded,
                  gradient: AppColors.blueGradient,
                  onTap: () => Navigator.pushNamed(context, '/aboutVRoute'),
                  isDark: isDark,
                ),
                _NavTile(
                  title: 'Puzzles',
                  sub: 'Can you find it?',
                  icon: Icons.lock_rounded,
                  gradient: AppColors.purpleGradient,
                  onTap: () => _showPuzzleDialog(context, isDark),
                  isDark: isDark,
                ),
                _NavTile(
                  title: 'Campus Map',
                  sub: 'Navigate around',
                  icon: Icons.map_rounded,
                  gradient: AppColors.goldGradient,
                  onTap: () => Navigator.pushNamed(context, '/arExperience'),
                  isDark: isDark,
                ),
              ],
            ),
            const SizedBox(height: 28),

            Text('Campus Life', style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600, color: textColor,
            )),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 18,
                    child: Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.gold.withValues(alpha: 0.18),
                          ),
                          child: const Icon(Icons.wb_sunny_rounded, color: AppColors.gold, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kayseri', style: GoogleFonts.poppins(
                                fontSize: 13, fontWeight: FontWeight.w600, color: textColor,
                              )),
                              Text('Tap for weather', style: GoogleFonts.inter(fontSize: 11, color: subColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 18,
                    child: Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.blue.withValues(alpha: 0.18),
                          ),
                          child: const Icon(Icons.chat_bubble_rounded, color: AppColors.blue, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Community', style: GoogleFonts.poppins(
                                fontSize: 13, fontWeight: FontWeight.w600, color: textColor,
                              )),
                              Text('Share thoughts', style: GoogleFonts.inter(fontSize: 11, color: subColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPuzzleDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkBg2 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Access Denied', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        )),
        content: Text('This page cannot be opened... or can it?', style: GoogleFonts.inter(
          color: isDark ? AppColors.darkSubtext : AppColors.lightSubtext,
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('OK', style: GoogleFonts.inter(
              color: isDark ? AppColors.teal : AppColors.tealDark,
              fontWeight: FontWeight.w600,
            )),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.title,
    required this.sub,
    required this.icon,
    required this.gradient,
    required this.onTap,
    required this.isDark,
  });

  final String title;
  final String sub;
  final IconData icon;
  final LinearGradient gradient;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkGlass : AppColors.lightGlass,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: gradient.colors.first.withValues(alpha: 0.35),
                        blurRadius: 10, offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    )),
                    Text(sub, style: GoogleFonts.inter(
                      fontSize: 11,
                      color: isDark ? AppColors.darkSubtext : AppColors.lightSubtext,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
