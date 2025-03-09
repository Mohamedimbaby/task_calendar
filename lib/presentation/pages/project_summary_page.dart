import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/project/project_stat_card.dart';
import '../widgets/project/productivity_chart.dart';

class ProjectSummaryPage extends StatelessWidget {
  const ProjectSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Text(
              localizations.search,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: localizations.searchProjectHere,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Project Statistics Cards
            Row(
              children: [
                Expanded(
                  child: ProjectStatCard(
                    count: 10,
                    title: localizations.projectInProgress,
                    color: Color(0xFF5B9AE8),
                    icon: Icons.access_time_filled,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ProjectStatCard(
                    count: 24,
                    title: localizations.projectCompleted,
                    color: Color(0xFF65B0A6),
                    icon: Icons.check_circle_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ProjectStatCard(
                    count: 5,
                    title: localizations.projectCancelled,
                    color: Color(0xFFE27777),
                    icon: Icons.cancel,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // View All Projects Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  localizations.viewAllProject,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Productivity Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.productivity,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_horiz),
              ],
            ),

            const SizedBox(height: 20),

            // Productivity Chart
            SizedBox(
              height: 250,
              child: ProductivityChart(),
            ),
          ],
        ),
      ),
    );
  }
}
