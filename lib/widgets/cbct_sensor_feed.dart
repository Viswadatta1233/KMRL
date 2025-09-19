import 'package:flutter/material.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class CBCTSensorFeed extends StatelessWidget {
  final List<Train> trains;

  const CBCTSensorFeed({super.key, required this.trains});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AI-Powered Predictive Maintenance Header
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.kmrlPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.analytics,
                        color: AppTheme.kmrlPrimary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Predictive Maintenance',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.kmrlPrimary,
                            ),
                          ),
                          Text(
                            'Real-time sensor analysis & spare parts prediction',
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
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.smart_toy, color: Colors.blue, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'AI ACTIVE',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

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
                            Icons.psychology,
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
                        _getAIAnalysisSummary(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Predictive Maintenance Data
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.sensors, color: AppTheme.kmrlPrimary, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Predictive Maintenance Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...trains
                    .take(8)
                    .map((train) => _buildPredictiveMaintenanceCard(train)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // AI-Generated Alerts
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Procurement Alerts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildAIAlertCard(
                  'Brake Wear Alert',
                  '3 trains showing >80% brake wear - replacement needed in 2 weeks',
                  Icons.dangerous,
                  Colors.red,
                  'HIGH PRIORITY',
                ),
                const SizedBox(height: 8),
                _buildAIAlertCard(
                  'HVAC Efficiency Drop',
                  '5 trains showing reduced HVAC efficiency - filter replacement recommended',
                  Icons.air,
                  Colors.orange,
                  'MEDIUM',
                ),
                const SizedBox(height: 8),
                _buildAIAlertCard(
                  'Vibration Anomaly',
                  'Train Krishna showing unusual vibration patterns - inspection required',
                  Icons.vibration,
                  Colors.yellow,
                  'MONITOR',
                ),
                const SizedBox(height: 8),
                _buildAIAlertCard(
                  'Predictive Spare Parts',
                  'AI recommends ordering: Brake pads (20 units), HVAC filters (15 units)',
                  Icons.inventory,
                  Colors.blue,
                  'PLANNING',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPredictiveMaintenanceCard(Train train) {
    final brakeWearStatus = _getBrakeWearStatus(train.brakeWearPercentage);
    final hvacStatus = _getHVACStatus(train.hvacEfficiency);
    final vibrationStatus = _getVibrationStatus(train.vibrationLevel);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.kmrlPrimary,
                child: Text(
                  train.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Mileage: ${train.mileage} km',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.kmrlPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'AI MONITORED',
                  style: TextStyle(
                    color: AppTheme.kmrlPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sensor Data Grid
          Row(
            children: [
              Expanded(
                child: _buildSensorMetric(
                  'Brake Wear',
                  '${train.brakeWearPercentage.toStringAsFixed(1)}%',
                  brakeWearStatus.color,
                  Icons.dangerous,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSensorMetric(
                  'HVAC Efficiency',
                  '${train.hvacEfficiency.toStringAsFixed(1)}%',
                  hvacStatus.color,
                  Icons.air,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSensorMetric(
                  'Vibration',
                  '${train.vibrationLevel.toStringAsFixed(1)} Hz',
                  vibrationStatus.color,
                  Icons.vibration,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSensorMetric(
                  'Door Cycles',
                  '${train.doorCycleCount}',
                  Colors.blue,
                  Icons.door_front_door,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSensorMetric(
                  'Wheel Wear',
                  '${train.wheelWear.toStringAsFixed(1)} mm',
                  train.wheelWear > 10 ? Colors.red : Colors.green,
                  Icons.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSensorMetric(
                  'Temperature',
                  '${train.temperature.toStringAsFixed(1)}°C',
                  train.temperature > 25 ? Colors.red : Colors.green,
                  Icons.thermostat,
                ),
              ),
            ],
          ),

          // AI Prediction
          if (brakeWearStatus.needsAttention ||
              hvacStatus.needsAttention ||
              vibrationStatus.needsAttention)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology, color: Colors.orange, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getAIPrediction(train),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
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

  Widget _buildSensorMetric(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 12,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: color.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAlertCard(
    String title,
    String message,
    IconData icon,
    Color color,
    String priority,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for status determination
  ({Color color, bool needsAttention}) _getBrakeWearStatus(double percentage) {
    if (percentage > 80) return (color: Colors.red, needsAttention: true);
    if (percentage > 60) return (color: Colors.orange, needsAttention: true);
    return (color: Colors.green, needsAttention: false);
  }

  ({Color color, bool needsAttention}) _getHVACStatus(double efficiency) {
    if (efficiency < 70) return (color: Colors.red, needsAttention: true);
    if (efficiency < 85) return (color: Colors.orange, needsAttention: true);
    return (color: Colors.green, needsAttention: false);
  }

  ({Color color, bool needsAttention}) _getVibrationStatus(double level) {
    if (level > 3.0) return (color: Colors.red, needsAttention: true);
    if (level > 2.5) return (color: Colors.orange, needsAttention: true);
    return (color: Colors.green, needsAttention: false);
  }

  String _getAIPrediction(Train train) {
    final predictions = <String>[];

    if (train.brakeWearPercentage > 80) {
      predictions.add('Brake replacement in 1-2 weeks');
    }
    if (train.hvacEfficiency < 70) {
      predictions.add('HVAC filter replacement needed');
    }
    if (train.vibrationLevel > 3.0) {
      predictions.add('Vibration inspection required');
    }
    if (train.wheelWear > 10) {
      predictions.add('Wheel maintenance due');
    }

    if (predictions.isEmpty) {
      return 'All systems optimal - no maintenance required';
    }

    return 'AI Prediction: ${predictions.join(', ')}';
  }

  String _getAIAnalysisSummary() {
    final highWearTrains = trains
        .where((t) => t.brakeWearPercentage > 80)
        .length;
    final lowEfficiencyTrains = trains
        .where((t) => t.hvacEfficiency < 70)
        .length;
    final highVibrationTrains = trains
        .where((t) => t.vibrationLevel > 3.0)
        .length;

    return "AI analysis of ${trains.length} trains shows $highWearTrains requiring brake attention, "
        "$lowEfficiencyTrains with HVAC issues, and $highVibrationTrains with vibration anomalies. "
        "Predictive algorithms recommend proactive maintenance to prevent failures.";
  }
}
