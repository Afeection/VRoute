import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final accent    = isDark ? AppColors.teal : AppColors.tealDark;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    final email       = FirebaseAuth.instance.currentUser?.email ?? 'Guest';
    final displayName = email.contains('@') ? email.split('@').first : email;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPad + 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w700, color: textColor,
            )),
            Text('Customize your experience', style: GoogleFonts.inter(fontSize: 14, color: subColor)),
            const SizedBox(height: 24),

            // Profile card
            GlassCard(
              borderRadius: 20,
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.tealGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.teal.withValues(alpha: 0.3),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
                        style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(displayName, style: GoogleFonts.poppins(
                          fontSize: 17, fontWeight: FontWeight.w600, color: textColor,
                        )),
                        Text(email, style: GoogleFonts.inter(fontSize: 13, color: subColor),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: accent.withValues(alpha: 0.15),
                    ),
                    child: Text('AGU', style: GoogleFonts.inter(
                      fontSize: 11, fontWeight: FontWeight.w700, color: accent,
                    )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Text('APPEARANCE', style: GoogleFonts.inter(
              fontSize: 11, fontWeight: FontWeight.w600, color: subColor, letterSpacing: 1.2,
            )),
            const SizedBox(height: 10),

            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, mode, _) {
                final dark = mode == ThemeMode.dark;
                return GlassCard(
                  borderRadius: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: dark
                              ? const Color(0xFF1A2A6C).withValues(alpha: 0.5)
                              : const Color(0xFFFFF9C4),
                        ),
                        child: Icon(
                          dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          color: dark ? AppColors.blue : AppColors.gold,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dark ? 'Dark Mode' : 'Light Mode', style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600, color: textColor,
                            )),
                            Text('Toggle app theme', style: GoogleFonts.inter(fontSize: 12, color: subColor)),
                          ],
                        ),
                      ),
                      Switch(
                        value: dark,
                        onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
                        activeColor: AppColors.teal,
                        inactiveThumbColor: AppColors.lightMuted,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 28),

            Text('ABOUT', style: GoogleFonts.inter(
              fontSize: 11, fontWeight: FontWeight.w600, color: subColor, letterSpacing: 1.2,
            )),
            const SizedBox(height: 10),

            GlassCard(
              borderRadius: 16,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _row(Icons.info_outline_rounded, 'About VRoute', accent, textColor, subColor,
                    onTap: () => Navigator.pushNamed(context, '/aboutVRoute'),
                    showDivider: true,
                  ),
                  _row(Icons.school_rounded, 'About AGU', accent, textColor, subColor,
                    onTap: () => Navigator.pushNamed(context, '/aboutAGU'),
                    showDivider: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => _signOut(context),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: Text('Sign Out', style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600,
                )),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    IconData icon,
    String label,
    Color accent,
    Color textColor,
    Color subColor, {
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: accent.withValues(alpha: 0.15),
            ),
            child: Icon(icon, color: accent, size: 18),
          ),
          title: Text(label, style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w500, color: textColor,
          )),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: subColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 68,
            endIndent: 18,
            color: accent.withValues(alpha: 0.1),
          ),
      ],
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Sign Out', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text('Are you sure you want to sign out?', style: GoogleFonts.inter()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Sign Out', style: GoogleFonts.inter(
              color: AppColors.error, fontWeight: FontWeight.w600,
            )),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }
    }
  }
}
