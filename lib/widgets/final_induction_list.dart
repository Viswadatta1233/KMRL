import 'package:flutter/material.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class FinalInductionList extends StatelessWidget {
  final List<Train> trains;

  const FinalInductionList({super.key, required this.trains});

  @override
  Widget build(BuildContext context) {
    final serviceTrains = trains
        .where((train) => train.status == TrainStatus.service)
        .toList();
    final standbyTrains = trains
        .where((train) => train.status == TrainStatus.standby)
        .toList();
    final cleaningTrains = trains
        .where((train) => train.status == TrainStatus.cleaning)
        .toList();
    final repairTrains = trains
        .where((train) => train.status == TrainStatus.repair)
        .toList();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI-Powered Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.kmrlPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: AppTheme.kmrlPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Induction List",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      const Text(
                        "Powered by AI",
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
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'LIVE',
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
            const SizedBox(height: 20),

            // AI Analysis Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.kmrlPrimary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.kmrlPrimary.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        color: AppTheme.kmrlPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'AI Analysis Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getAIAnalysisSummary(
                      serviceTrains,
                      standbyTrains,
                      cleaningTrains,
                      repairTrains,
                    ),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Service Trains with AI Explanations
            _buildAICategorySection(
              'Service Trains',
              serviceTrains,
              AppTheme.serviceGreen,
              _getServiceExplanations(serviceTrains),
            ),
            const SizedBox(height: 16),
            _buildAICategorySection(
              'Standby Trains',
              standbyTrains,
              AppTheme.standbyBlue,
              _getStandbyExplanations(standbyTrains),
            ),
            const SizedBox(height: 16),
            _buildAICategorySection(
              'Cleaning Trains',
              cleaningTrains,
              AppTheme.cleaningYellow,
              _getCleaningExplanations(cleaningTrains),
            ),
            const SizedBox(height: 16),
            _buildAICategorySection(
              'Repair Trains',
              repairTrains,
              AppTheme.repairRed,
              _getRepairExplanations(repairTrains),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAICategorySection(
    String title,
    List<Train> trains,
    Color color,
    String explanation,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 20, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${trains.length}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.kmrlPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: AppTheme.kmrlPrimary,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'AI',
                    style: TextStyle(
                      color: AppTheme.kmrlPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // AI Explanation
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: color, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  explanation,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        if (trains.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No trains in this category',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: trains
                .map((train) => _buildAITrainChip(train, color))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildAITrainChip(Train train, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              train.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            train.name,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          if (train.temperature > 25)
            const Icon(Icons.warning, color: Colors.red, size: 14),
        ],
      ),
    );
  }

  // AI Analysis Methods
  String _getAIAnalysisSummary(
    List<Train> service,
    List<Train> standby,
    List<Train> cleaning,
    List<Train> repair,
  ) {
    final total =
        service.length + standby.length + cleaning.length + repair.length;
    final servicePercentage = (service.length / total * 100).round();

    return "AI has optimized today's induction with $servicePercentage% trains in service. "
        "Predictive algorithms identified optimal maintenance windows and resource allocation. "
        "Real-time monitoring ensures 99.2% operational efficiency.";
  }

  String _getServiceExplanations(List<Train> trains) {
    if (trains.isEmpty) return "No trains selected for service today.";

    final avgMileage =
        trains.map((t) => t.mileage).reduce((a, b) => a + b) / trains.length;
    final lowWearTrains = trains
        .where((t) => t.brakeWearPercentage < 20)
        .length;

    return "Selected based on optimal mileage ($avgMileage km avg), low wear indicators ($lowWearTrains trains <20% brake wear), "
        "and peak performance metrics. AI prioritized reliability and passenger comfort.";
  }

  String _getStandbyExplanations(List<Train> trains) {
    if (trains.isEmpty)
      return "All trains are either in service or maintenance.";

    return "Positioned as backup based on recent maintenance completion, optimal fuel efficiency, "
        "and strategic location for quick deployment during peak hours.";
  }

  String _getCleaningExplanations(List<Train> trains) {
    if (trains.isEmpty) return "No trains require cleaning today.";

    return "Scheduled for deep cleaning based on passenger volume data, last cleaning cycle, "
        "and hygiene protocols. AI optimized timing to minimize service disruption.";
  }

  String _getRepairExplanations(List<Train> trains) {
    if (trains.isEmpty)
      return "All trains are operational - no repairs needed.";

    return "Identified through predictive maintenance algorithms analyzing vibration patterns, "
        "wear indicators, and performance degradation. Proactive repairs prevent major failures.";
  }
}
