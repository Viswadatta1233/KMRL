import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';
import '../widgets/fitness_certificate_manager.dart';
import '../widgets/repair_status_validator.dart';
import '../widgets/maintenance_confirmation.dart';
import '../widgets/spare_parts_planner.dart';
import '../widgets/final_induction_list.dart';

class SupervisorDashboard extends ConsumerStatefulWidget {
  const SupervisorDashboard({super.key});

  @override
  ConsumerState<SupervisorDashboard> createState() =>
      _SupervisorDashboardState();
}

class _SupervisorDashboardState extends ConsumerState<SupervisorDashboard> {
  @override
  Widget build(BuildContext context) {
    final trains = ref.watch(trainsProvider);
    final maintenanceUpdates = ref.watch(maintenanceUpdatesProvider);
    final spareParts = ref.watch(sparePartsProvider);
    final finalInductionList = ref.watch(finalInductionListProvider);

    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          Container(
            color: AppTheme.kmrlPrimary,
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Tab(icon: Icon(Icons.verified), text: 'Fitness Certificates'),
                Tab(icon: Icon(Icons.build), text: 'Repair Status'),
                Tab(
                  icon: Icon(Icons.check_circle),
                  text: 'Maintenance Confirm',
                ),
                Tab(icon: Icon(Icons.inventory), text: 'Spare Parts'),
                Tab(icon: Icon(Icons.list), text: 'Final Induction'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Fitness Certificates Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fitness Certificate Manager',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FitnessCertificateManager(trains: trains),
                    ],
                  ),
                ),

                // Repair Status Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Repair Status Validator',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RepairStatusValidator(trains: trains),
                    ],
                  ),
                ),

                // Maintenance Confirmation Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Maintenance Confirmation',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      MaintenanceConfirmation(updates: maintenanceUpdates),
                    ],
                  ),
                ),

                // Spare Parts Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Spare Parts Planner',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SparePartsPlanner(requests: spareParts),
                    ],
                  ),
                ),

                // Final Induction List Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Final Induction List',
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
