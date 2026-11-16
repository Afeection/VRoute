import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  static const _apiKey = '2344a779d3123e4bce9a2afa3eb74092';

  String _city        = '';
  String _temp        = '';
  String _feelsLike   = '';
  String _description = '';
  String _humidity    = '';
  String _wind        = '';
  String _iconUrl     = '';
  bool   _loading     = true;
  bool   _error       = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() { _loading = true; _error = false; });
    try {
      final res = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Kayseri&appid=$_apiKey&units=metric',
      ));
      if (res.statusCode != 200) throw Exception();
      final d = json.decode(res.body) as Map<String, dynamic>;
      setState(() {
        _city        = d['name'] as String;
        _temp        = '${(d['main']['temp'] as num).round()}°';
        _feelsLike   = '${(d['main']['feels_like'] as num).round()}°';
        _description = (d['weather'][0]['description'] as String).toUpperCase();
        _humidity    = '${d['main']['humidity']}%';
        _wind        = '${(d['wind']['speed'] as num).round()} m/s';
        _iconUrl     = 'https://openweathermap.org/img/wn/${d['weather'][0]['icon']}@2x.png';
        _loading     = false;
      });
    } catch (_) {
      setState(() { _loading = false; _error = true; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPad + 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weather', style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w700, color: textColor,
            )),
            Text('Kayseri, Turkey', style: GoogleFonts.inter(fontSize: 14, color: subColor)),
            const SizedBox(height: 24),

            if (_loading)
              const Center(child: CircularProgressIndicator(color: AppColors.teal))
            else if (_error)
              _errorCard(context, isDark, textColor, subColor)
            else ...[
              _mainCard(isDark, textColor, subColor),
              const SizedBox(height: 16),
              _statsRow(isDark, textColor, subColor),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _fetch,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text('Refresh', style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDark ? AppColors.teal : AppColors.tealDark,
                    side: BorderSide(color: isDark ? AppColors.teal : AppColors.tealDark),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _mainCard(bool isDark, Color textColor, Color subColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF1A2A6C).withValues(alpha: 0.6), const Color(0xFF2D6A8F).withValues(alpha: 0.5)]
                  : [const Color(0xFF4ECBA8).withValues(alpha: 0.2), const Color(0xFF6B9AFF).withValues(alpha: 0.15)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_city, style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600, color: textColor,
                    )),
                    const SizedBox(height: 4),
                    Text(_description, style: GoogleFonts.inter(
                      fontSize: 13, color: subColor, fontWeight: FontWeight.w500,
                    )),
                    const SizedBox(height: 12),
                    Text(_temp, style: GoogleFonts.poppins(
                      fontSize: 64, fontWeight: FontWeight.w700, color: textColor, height: 1,
                    )),
                    const SizedBox(height: 4),
                    Text('Feels like $_feelsLike', style: GoogleFonts.inter(
                      fontSize: 13, color: subColor,
                    )),
                  ],
                ),
              ),
              if (_iconUrl.isNotEmpty)
                Image.network(_iconUrl, width: 90, height: 90),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statsRow(bool isDark, Color textColor, Color subColor) {
    return Row(
      children: [
        Expanded(child: _statCard(Icons.water_drop_outlined, 'Humidity', _humidity, AppColors.blue, isDark, textColor, subColor)),
        const SizedBox(width: 12),
        Expanded(child: _statCard(Icons.air_rounded, 'Wind', _wind, AppColors.teal, isDark, textColor, subColor)),
      ],
    );
  }

  Widget _statCard(IconData icon, String label, String value, Color color, bool isDark, Color textColor, Color subColor) {
    return GlassCard(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color.withValues(alpha: 0.18),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.inter(fontSize: 11, color: subColor)),
              Text(value, style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w600, color: textColor,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _errorCard(BuildContext context, bool isDark, Color textColor, Color subColor) {
    return GlassCard(
      borderRadius: 20,
      child: Column(
        children: [
          Icon(Icons.cloud_off_rounded, size: 48, color: subColor),
          const SizedBox(height: 12),
          Text('Could not load weather', style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.w600, color: textColor,
          )),
          const SizedBox(height: 4),
          Text('Check your connection and try again', style: GoogleFonts.inter(fontSize: 13, color: subColor)),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: _fetch,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
