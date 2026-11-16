import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

const _facilities = <Map<String, String>>[
  {
    'title': 'Steel Building',
    'subtitle': 'Recreation · Admin · Library',
    'image': 'assets/steel_building.png',
    'details': 'The AGÜ Steel Building is divided into two sections, A and B. The A block houses the rectorate, administrative offices, the main library, conference hall, and the main prayer hall. The B block contains table tennis and badminton areas, a copy center, student study tables, classrooms, and an upper-floor cafeteria. It is the central hub where students spend most of their time between classes. Teachers often conduct exams here, and preparatory students take their exemption exams in this building as well.',
  },
  {
    'title': 'BA Building',
    'subtitle': 'Architecture · Dining',
    'image': 'assets/ba_building.png',
    'details': 'The BA Building — Büyük Ambar (Great Warehouse) — was previously a factory warehouse and is now home to the architecture faculty. It features student-friendly study areas and a dining hall that is indispensable to daily campus life. Many faculty offices are on the second floor. Architecture students display their semester projects throughout the building, creating an ever-changing gallery worth exploring.',
  },
  {
    'title': 'Factory Building',
    'subtitle': 'Engineering · Labs · Dining',
    'image': 'assets/factory_building.png',
    'details': 'Once a primary production building of the original Sümer Factory, the Factory Building now houses laboratories, classrooms, upper-floor study areas, and a technology design office with incubation centers. It is the home of electrical and electronics engineering students. The building has the only amphitheater-style classroom on campus and a dining area used during lunch hours that becomes a study space outside of meal times.',
  },
  {
    'title': 'Laboratory Building',
    'subtitle': 'Molecular Biology · Research',
    'image': 'assets/laboratory_building.png',
    'details': "The Laboratory Building is home to molecular biology and genetics students and hosts departmental labs across its three floors including the basement. The building's futuristic exterior — described by many as looking like a spaceship — greets visitors right at the campus entrance. Its proximity to the Student Center (10 meters away) makes it a popular spot for studying between lab sessions.",
  },
  {
    'title': 'Fitness Center',
    'subtitle': 'Sports · Reservations',
    'image': 'assets/fitness_center.png',
    'details': 'The Fitness Center was previously used by Kayserispor, the professional football club — a testament to the quality of its equipment. Students can register for a free subscription at booked.com and use it on designated days and hours. The center also manages all tournament operations and sports field reservations on campus.',
  },
  {
    'title': 'Sport Facilities',
    'subtitle': 'Football · Basketball · Tennis',
    'image': 'assets/sport_facilities.png',
    'details': 'Campus sports facilities include football, basketball, volleyball, tennis, table tennis, and badminton. The turf football field, basketball courts, and tennis courts can be reserved through the Fitness Center in 90-minute slots. Table tennis and badminton inside the Steel Building require no reservation. These areas are the primary social spaces on campus where students meet and form friendships.',
  },
  {
    'title': 'Other Mentions',
    'subtitle': 'Cafés · Services · Rector',
    'image': 'assets/other_mentions.png',
    'details': "Notable campus spots include House M Café, Starbucks, Elif Café, and Afili Café. The International Office handles Erasmus applications and international student matters. A greenhouse area, the Rectorate Building, Sports Directorate, and Health Center are also on campus. The Health Center provides medical reports and daytime care; a nurse is present during tournaments. Campus access is managed via ID cards at two security checkpoints.\n\nRector: Prof. Cengiz Yılmaz — B.S. Hacettepe University (Business, 1991), MBA Texas Tech (1995), Ph.D. Marketing Texas Tech (1999). Previously a faculty member at Boğaziçi University and METU. Assigned as AGU Rector in May 2021.",
  },
];

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({super.key});

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    final filtered = _query.isEmpty
        ? _facilities
        : _facilities.where((f) =>
            f['title']!.toLowerCase().contains(_query.toLowerCase()) ||
            f['subtitle']!.toLowerCase().contains(_query.toLowerCase()),
          ).toList();

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Facilities', style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.w700, color: textColor,
                )),
                Text('Explore every building on campus', style: GoogleFonts.inter(fontSize: 14, color: subColor)),
                const SizedBox(height: 16),
                GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  borderRadius: 16,
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    style: GoogleFonts.inter(color: textColor, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search facilities...',
                      hintStyle: GoogleFonts.inter(color: subColor, fontSize: 14),
                      prefixIcon: Icon(Icons.search_rounded, color: subColor, size: 20),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPad + 90),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final f = filtered[i];
                return GlassCard(
                  padding: EdgeInsets.zero,
                  borderRadius: 18,
                  onTap: () => Navigator.pushNamed(context, '/facilityDetail', arguments: f),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(17)),
                        child: Image.asset(f['image']!, width: 90, height: 80, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(f['title']!, style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600, color: textColor,
                              )),
                              const SizedBox(height: 2),
                              Text(f['subtitle']!, style: GoogleFonts.inter(fontSize: 12, color: subColor)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: subColor),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
