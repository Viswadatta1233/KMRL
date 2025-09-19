import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';
import '../models/train_model.dart';
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
    final finalInductionList = ref.watch(finalInductionListProvider);

    // Filter only service status trains from the final induction list
    final serviceTrains = finalInductionList
        .where((train) => train.status == TrainStatus.service)
        .toList();

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
                      // AI Header for Dispatch Check
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.kmrlPrimary.withOpacity(0.1),
                              Colors.green.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.kmrlPrimary.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AI-Powered Dispatch Check',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.kmrlPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Final dispatch readiness for service trains only',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.green),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'SERVICE ONLY',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      FinalDispatchCheck(trains: serviceTrains),
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
                      CleaningUpdateForm(trains: serviceTrains),
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
                      RepairUpdateForm(trains: serviceTrains),
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
