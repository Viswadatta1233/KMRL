import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';
import '../widgets/final_dispatch_check.dart';
import '../widgets/cleaning_update_form.dart';
import '../widgets/repair_update_form.dart';
import '../widgets/final_induction_list.dart';

class MaintenanceDashboard extends ConsumerStatefulWidget {
  const MaintenanceDashboard({super.key});

  @override
  ConsumerState<MaintenanceDashboard> createState() =>
      _MaintenanceDashboardState();
}

class _MaintenanceDashboardState extends ConsumerState<MaintenanceDashboard> {
  @override
  Widget build(BuildContext context) {
    final trains = ref.watch(trainsProvider);
    final finalInductionList = ref.watch(finalInductionListProvider);

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            color: AppTheme.kmrlPrimary,
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.check_circle), text: 'Dispatch Check'),
                Tab(icon: Icon(Icons.cleaning_services), text: 'Cleaning'),
                Tab(icon: Icon(Icons.build), text: 'Repair'),
                Tab(icon: Icon(Icons.list), text: 'Induction List'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Final Dispatch Check Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Final Dispatch Check',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FinalDispatchCheck(trains: trains),
                    ],
                  ),
                ),

                // Cleaning Update Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cleaning Update Form',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CleaningUpdateForm(trains: trains),
                    ],
                  ),
                ),

                // Repair Update Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Repair Update Form',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RepairUpdateForm(trains: trains),
                    ],
                  ),
                ),

                // Daily Induction List Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daily Induction List',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FinalInductionList(trains: finalInductionList),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
