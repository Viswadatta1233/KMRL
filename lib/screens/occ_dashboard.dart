import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/train_status_grid.dart';
import '../widgets/job_card_table.dart';
import '../widgets/cbct_sensor_feed.dart';
import '../widgets/branding_rule_form.dart';

class OCCDashboard extends ConsumerStatefulWidget {
  const OCCDashboard({super.key});

  @override
  ConsumerState<OCCDashboard> createState() => _OCCDashboardState();
}

class _OCCDashboardState extends ConsumerState<OCCDashboard> {
  @override
  Widget build(BuildContext context) {
    final trains = ref.watch(trainsProvider);
    final brandingRules = ref.watch(brandingRulesProvider);

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
                Tab(icon: Icon(Icons.dashboard), text: 'System Monitor'),
                Tab(icon: Icon(Icons.assignment), text: 'Job Cards'),
                Tab(icon: Icon(Icons.sensors), text: 'CBCT Sensors'),
                Tab(icon: Icon(Icons.campaign), text: 'Branding Rules'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // System Monitor Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'System Monitor Board',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TrainStatusGrid(trains: trains),
                      const SizedBox(height: 16),
                      const Text(
                        'Predictive Spare Parts Suggestions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Likely Needed Soon:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              ...MockData.getPredictiveSpareParts().map(
                                (part) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.warning,
                                        color: Colors.orange,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          part,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Job Cards Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Job Card Status Feed',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      JobCardTable(trains: trains),
                    ],
                  ),
                ),

                // CBCT Sensors Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CBCT Sensor Feed',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CBCTSensorFeed(trains: trains),
                    ],
                  ),
                ),

                // Branding Rules Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Branding Rule Assignment',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BrandingRuleForm(),
                      const SizedBox(height: 24),
                      const Text(
                        'Active Branding Rules',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...brandingRules.map(
                        (rule) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(rule.campaignName),
                            subtitle: Text(
                              '${rule.requiredHours} hours required',
                            ),
                            trailing: Text(
                              '${rule.bestFitTrains.length} trains assigned',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
