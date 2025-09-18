import 'package:flutter/material.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class TrainStatusGrid extends StatelessWidget {
  final List<Train> trains;

  const TrainStatusGrid({super.key, required this.trains});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive grid parameters
        final screenWidth = constraints.maxWidth;
        final crossAxisCount = screenWidth > 600 ? 5 : 4;
        final cardWidth =
            (screenWidth - (crossAxisCount - 1) * 4) / crossAxisCount;
        final childAspectRatio =
            cardWidth / 60; // Fixed height of 60px for better readability

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: trains.length,
          itemBuilder: (context, index) {
            final train = trains[index];
            return _buildTrainCard(train);
          },
        );
      },
    );
  }

  Widget _buildTrainCard(Train train) {
    final statusColor = AppTheme.getStatusColor(train.status);
    final statusText = AppTheme.getStatusText(train.status);

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: statusColor, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                train.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                statusText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (train.temperature > 25)
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.warning, color: Colors.red, size: 10),
              ),
          ],
        ),
      ),
    );
  }
}
