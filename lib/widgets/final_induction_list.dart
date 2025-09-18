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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Induction List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCategorySection(
              'Service Trains',
              serviceTrains,
              AppTheme.serviceGreen,
            ),
            const SizedBox(height: 16),
            _buildCategorySection(
              'Standby Trains',
              standbyTrains,
              AppTheme.standbyBlue,
            ),
            const SizedBox(height: 16),
            _buildCategorySection(
              'Cleaning Trains',
              cleaningTrains,
              AppTheme.cleaningYellow,
            ),
            const SizedBox(height: 16),
            _buildCategorySection(
              'Repair Trains',
              repairTrains,
              AppTheme.repairRed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Train> trains, Color color) {
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
          ],
        ),
        const SizedBox(height: 8),
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
                .map((train) => _buildTrainChip(train, color))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildTrainChip(Train train, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            train.name,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          if (train.temperature > 25)
            const Icon(Icons.warning, color: Colors.red, size: 16),
        ],
      ),
    );
  }
}
