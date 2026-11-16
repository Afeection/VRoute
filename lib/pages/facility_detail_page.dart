import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../theme/app_colors.dart';

class FacilityDetailPage extends StatelessWidget {
  const FacilityDetailPage({super.key, required this.facility});

  final Map<String, dynamic> facility;

  Future<void> _triggerPuzzleNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Warning!',
      'YOU SOLVED THE PUZZLE',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id', 'channel_name',
          channelDescription: 'Channel description',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final isOther   = facility['title'] == 'Other Mentions';

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
                      Image.asset(facility['image']!, fit: BoxFit.cover),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20, left: 20, right: 20,
                        child: Text(
                          facility['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 28, fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.teal.withValues(alpha: isDark ? 0.18 : 0.12),
                        ),
                        child: Text(
                          facility['subtitle'] ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.teal : AppColors.tealDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        facility['details']!,
                        style: GoogleFonts.inter(
                          fontSize: 15, height: 1.7, color: textColor,
                        ),
                      ),
                      if (isOther) ...[
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () async {
                              await _triggerPuzzleNotification();
                              if (context.mounted) {
                                Navigator.pushNamed(context, '/puzzles');
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.error,
                              side: const BorderSide(color: AppColors.error, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text('Do Not Touch!', style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600,
                              color: AppColors.error,
                            )),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Seriously, don\'t.',
                            style: GoogleFonts.inter(fontSize: 11, color: subColor),
                          ),
                        ),
                      ],
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
}
