import 'package:flutter/material.dart';
import '../models/train_model.dart';

class CBCTSensorFeed extends StatelessWidget {
  final List<Train> trains;

  const CBCTSensorFeed({super.key, required this.trains});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Temperature Monitoring',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...trains.map((train) => _buildTemperatureCard(train)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'System Alerts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAlertCard(
                  'High Temperature Alert',
                  'Train Krishna showing temperature above normal range',
                  Icons.warning,
                  Colors.red,
                ),
                const SizedBox(height: 8),
                _buildAlertCard(
                  'Sensor Maintenance Due',
                  'CBCT sensors on Train Tapti require calibration',
                  Icons.build,
                  Colors.orange,
                ),
                const SizedBox(height: 8),
                _buildAlertCard(
                  'System Update Available',
                  'New firmware version available for sensor network',
                  Icons.system_update,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTemperatureCard(Train train) {
    final isHighTemp = train.temperature > 25;
    final tempColor = isHighTemp ? Colors.red : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tempColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tempColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(isHighTemp ? Icons.warning : Icons.thermostat, color: tempColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  train.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Temperature: ${train.temperature.toStringAsFixed(1)}°C'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tempColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isHighTemp ? 'HIGH' : 'NORMAL',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(
    String title,
    String message,
    IconData icon,
    Color color,
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
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
