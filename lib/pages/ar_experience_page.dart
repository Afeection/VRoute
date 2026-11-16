import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ARExperiencePage extends StatelessWidget {
  const ARExperiencePage({super.key});

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
                      Text('AR Experience', style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w700, color: textColor,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                    child: Column(
                      children: [
                        _cameraViewport(isDark, subColor, accent),
                        const SizedBox(height: 28),
                        _comingSoonCard(isDark, textColor, subColor, accent),
                        const SizedBox(height: 20),
                        _featureGrid(isDark, textColor, subColor, accent),
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

  Widget _cameraViewport(bool isDark, Color subColor, Color accent) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF1A2A6C).withValues(alpha: 0.5), const Color(0xFF0A1A3C).withValues(alpha: 0.5)]
                  : [const Color(0xFF4ECBA8).withValues(alpha: 0.1), const Color(0xFF6B9AFF).withValues(alpha: 0.1)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
              width: 1.5,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.tealGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.teal.withValues(alpha: 0.35),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.view_in_ar_rounded, color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 16),
                    Text('Point & Explore', style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white,
                    )),
                    const SizedBox(height: 4),
                    Text('AR camera view will appear here', style: GoogleFonts.inter(
                      fontSize: 12, color: subColor,
                    )),
                  ],
                ),
              ),
              Positioned(
                top: 16, left: 16,
                child: _cornerBracket(accent, true, true),
              ),
              Positioned(
                top: 16, right: 16,
                child: _cornerBracket(accent, true, false),
              ),
              Positioned(
                bottom: 16, left: 16,
                child: _cornerBracket(accent, false, true),
              ),
              Positioned(
                bottom: 16, right: 16,
                child: _cornerBracket(accent, false, false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cornerBracket(Color color, bool top, bool left) {
    return SizedBox(
      width: 20, height: 20,
      child: CustomPaint(painter: _CornerPainter(color: color, top: top, left: left)),
    );
  }

  Widget _comingSoonCard(bool isDark, Color textColor, Color subColor, Color accent) {
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: accent.withValues(alpha: 0.15),
                ),
                child: Icon(Icons.construction_rounded, color: accent, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coming Soon', style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w700, color: textColor,
                    )),
                    const SizedBox(height: 2),
                    Text('AR features are under active development', style: GoogleFonts.inter(
                      fontSize: 12, color: subColor,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureGrid(bool isDark, Color textColor, Color subColor, Color accent) {
    const features = [
      (Icons.map_rounded, 'Campus Map', 'Navigate to any building in real-time AR'),
      (Icons.info_outline_rounded, 'Building Info', 'Tap buildings to see details instantly'),
      (Icons.route_rounded, 'Directions', 'Overlay walking paths on camera feed'),
      (Icons.star_rounded, 'Points of Interest', 'Discover hidden spots and facilities'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      children: features.map((f) => ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(16),
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
                Icon(f.$1, color: accent, size: 22),
                const Spacer(),
                Text(f.$2, style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w600, color: textColor,
                )),
                const SizedBox(height: 2),
                Text(f.$3, style: GoogleFonts.inter(
                  fontSize: 10, color: subColor, height: 1.4,
                )),
              ],
            ),
          ),
        ),
      )).toList(),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final bool top;
  final bool left;

  const _CornerPainter({required this.color, required this.top, required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final x = left ? 0.0 : size.width;
    final y = top  ? 0.0 : size.height;
    final dx = left ? size.width : -size.width;
    final dy = top  ? size.height : -size.height;

    canvas.drawLine(Offset(x, y), Offset(x + dx, y), paint);
    canvas.drawLine(Offset(x, y), Offset(x, y + dy), paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => old.color != color;
}
