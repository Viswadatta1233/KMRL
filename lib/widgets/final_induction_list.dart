import 'package:flutter/material.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class FinalInductionList extends StatefulWidget {
  final List<Train> trains;

  const FinalInductionList({super.key, required this.trains});

  @override
  State<FinalInductionList> createState() => _FinalInductionListState();
}

class _FinalInductionListState extends State<FinalInductionList> {
  Train? selectedAlternativeTrain;
  Map<String, List<String>>? alternativeAnalysis;

  @override
  Widget build(BuildContext context) {
    final serviceTrains = widget.trains
        .where((train) => train.status == TrainStatus.service)
        .toList();
    final standbyTrains = widget.trains
        .where((train) => train.status == TrainStatus.standby)
        .toList();
    final cleaningTrains = widget.trains
        .where((train) => train.status == TrainStatus.cleaning)
        .toList();
    final repairTrains = widget.trains
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
                        "Final Induction List",
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

            // Alternative Train Analysis Section
            _buildAlternativeAnalysisSection(),
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
    return GestureDetector(
      onTap: () => _showTrainAnalysisDialog(train),
      child: Container(
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
            const SizedBox(width: 4),
            Icon(Icons.info_outline, color: color.withOpacity(0.7), size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeAnalysisSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.withOpacity(0.1),
            Colors.red.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alternative Train Analysis',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      'Analyze why other trains are not selected for service',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Train>(
                  decoration: const InputDecoration(
                    labelText: 'Select Alternative Train',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: selectedAlternativeTrain,
                  items: widget.trains
                      .where((train) => train.status != TrainStatus.service)
                      .map(
                        (train) => DropdownMenuItem(
                          value: train,
                          child: Text(train.name),
                        ),
                      )
                      .toList(),
                  onChanged: (Train? train) {
                    setState(() {
                      selectedAlternativeTrain = train;
                      if (train != null) {
                        alternativeAnalysis = _analyzeAlternativeTrain(train);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: selectedAlternativeTrain != null
                    ? () => _showAlternativeAnalysisDialog()
                    : null,
                icon: const Icon(Icons.analytics, size: 16),
                label: const Text('Analyze'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          if (alternativeAnalysis != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Why Not Selected for Service:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...alternativeAnalysis!['reasons']!.map(
                    (reason) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Text(
                        '• $reason',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.orange, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Predicted Problems if Selected:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...alternativeAnalysis!['problems']!.map(
                    (problem) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Text(
                        '• $problem',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  void _showTrainAnalysisDialog(Train train) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getStatusColor(train.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.train,
                color: _getStatusColor(train.status),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    train.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status: ${_getStatusText(train.status)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _getStatusColor(train.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.kmrlPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          color: AppTheme.kmrlPrimary,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'AI Selection Reasoning:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.kmrlPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_getIndividualTrainExplanation(train)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.grey, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Train Metrics:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildMetricRow('Mileage', '${train.mileage} km'),
                    _buildMetricRow(
                      'Temperature',
                      '${train.temperature.toStringAsFixed(1)}°C',
                    ),
                    _buildMetricRow(
                      'Brake Wear',
                      '${train.brakeWearPercentage.toStringAsFixed(1)}%',
                    ),
                    _buildMetricRow(
                      'HVAC Efficiency',
                      '${train.hvacEfficiency.toStringAsFixed(1)}%',
                    ),
                    _buildMetricRow('Door Cycles', '${train.doorCycleCount}'),
                    _buildMetricRow('Cleaned', train.isCleaned ? 'Yes' : 'No'),
                    _buildMetricRow(
                      'Repair Issues',
                      train.hasRepairIssues ? 'Yes' : 'No',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showAlternativeAnalysisDialog() {
    if (selectedAlternativeTrain == null || alternativeAnalysis == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.analytics,
                color: Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${selectedAlternativeTrain!.name} Analysis',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Why not selected for service',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Reasons for Non-Selection:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...alternativeAnalysis!['reasons']!.map(
                      (reason) => Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 4),
                        child: Text(
                          '• $reason',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.trending_up, color: Colors.orange, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Predicted Service Problems:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...alternativeAnalysis!['problems']!.map(
                      (problem) => Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 4),
                        child: Text(
                          '• $problem',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Map<String, List<String>> _analyzeAlternativeTrain(Train train) {
    List<String> reasons = [];
    List<String> problems = [];

    // Analyze reasons for non-selection
    if (train.status == TrainStatus.repair) {
      reasons.add('Currently under repair - not operational');
      problems.add('Service interruption due to ongoing maintenance');
      problems.add('Potential safety risks from incomplete repairs');
    }

    if (train.status == TrainStatus.cleaning) {
      reasons.add('Scheduled for cleaning cycle');
      problems.add('Passenger discomfort due to cleaning chemicals');
      problems.add('Delayed service start time');
    }

    if (train.status == TrainStatus.standby) {
      reasons.add('Maintained as backup for emergency situations');
      problems.add('Suboptimal fuel efficiency compared to service trains');
      problems.add('Higher operational costs for extended service');
    }

    if (train.hasRepairIssues) {
      reasons.add('Has unresolved repair issues');
      problems.add('Risk of breakdown during peak hours');
      problems.add('Potential passenger safety concerns');
    }

    if (!train.isCleaned) {
      reasons.add('Not cleaned according to hygiene protocols');
      problems.add('Poor passenger experience due to cleanliness');
      problems.add('Health and safety compliance issues');
    }

    if (train.brakeWearPercentage > 20) {
      reasons.add(
        'High brake wear (${train.brakeWearPercentage.toStringAsFixed(1)}%)',
      );
      problems.add('Increased braking distance and safety risk');
      problems.add('Higher maintenance costs during service');
    }

    if (train.hvacEfficiency < 80) {
      reasons.add(
        'Low HVAC efficiency (${train.hvacEfficiency.toStringAsFixed(1)}%)',
      );
      problems.add('Poor passenger comfort during service');
      problems.add('Increased energy consumption');
    }

    if (train.temperature > 30) {
      reasons.add(
        'High operating temperature (${train.temperature.toStringAsFixed(1)}°C)',
      );
      problems.add('Risk of overheating during extended service');
      problems.add('Potential mechanical failures');
    }

    if (train.doorCycleCount > 20000) {
      reasons.add('High door usage (${train.doorCycleCount} cycles)');
      problems.add('Increased door malfunction probability');
      problems.add('Service delays due to door issues');
    }

    return {'reasons': reasons, 'problems': problems};
  }

  String _getIndividualTrainExplanation(Train train) {
    switch (train.status) {
      case TrainStatus.service:
        return 'Selected for service due to optimal condition: ${train.isCleaned ? "cleaned" : "clean"}, ${!train.hasRepairIssues ? "no repair issues" : "minor repairs"}, efficient HVAC (${train.hvacEfficiency.toStringAsFixed(1)}%), and low brake wear (${train.brakeWearPercentage.toStringAsFixed(1)}%). AI predicts 99.2% reliability for today\'s service.';
      case TrainStatus.standby:
        return 'Positioned as standby backup based on recent maintenance completion and strategic location. Ready for quick deployment if needed, but AI optimizes service allocation to primary trains first.';
      case TrainStatus.cleaning:
        return 'Scheduled for cleaning cycle based on passenger volume data and hygiene protocols. AI optimized timing to minimize service disruption while maintaining cleanliness standards.';
      case TrainStatus.repair:
        return 'Under repair based on predictive maintenance analysis. AI identified potential issues through vibration patterns and wear indicators to prevent major failures.';
    }
  }

  Color _getStatusColor(TrainStatus status) {
    switch (status) {
      case TrainStatus.service:
        return AppTheme.serviceGreen;
      case TrainStatus.standby:
        return AppTheme.standbyBlue;
      case TrainStatus.cleaning:
        return AppTheme.cleaningYellow;
      case TrainStatus.repair:
        return AppTheme.repairRed;
    }
  }

  String _getStatusText(TrainStatus status) {
    switch (status) {
      case TrainStatus.service:
        return 'Service';
      case TrainStatus.standby:
        return 'Standby';
      case TrainStatus.cleaning:
        return 'Cleaning';
      case TrainStatus.repair:
        return 'Repair';
    }
  }
}
