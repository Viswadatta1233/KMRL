import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class FinalDispatchCheck extends ConsumerStatefulWidget {
  final List<Train> trains;

  const FinalDispatchCheck({super.key, required this.trains});

  @override
  ConsumerState<FinalDispatchCheck> createState() => _FinalDispatchCheckState();
}

class _FinalDispatchCheckState extends ConsumerState<FinalDispatchCheck> {
  final Map<String, bool> _dispatchStatus = {};

  @override
  void initState() {
    super.initState();
    // Initialize dispatch status for all trains
    for (final train in widget.trains) {
      _dispatchStatus[train.name] = train.status == TrainStatus.service;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Final Dispatch Check',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Toggle dispatch readiness for each train:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...widget.trains.map((train) => _buildDispatchCard(train)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitDispatchStatus,
                icon: const Icon(Icons.send),
                label: const Text('Submit Dispatch Status'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDispatchCard(Train train) {
    final isReady = _dispatchStatus[train.name] ?? false;
    final canDispatch =
        train.isCleaned &&
        !train.hasRepairIssues &&
        train.status == TrainStatus.service;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.getStatusColor(train.status),
              child: Text(
                train.name[0],
                style: const TextStyle(color: Colors.white),
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
                    'Status: ${AppTheme.getStatusText(train.status)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  if (!canDispatch)
                    const Text(
                      'Cannot dispatch - Check cleaning/repair status',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                ],
              ),
            ),
            Switch(
              value: isReady,
              onChanged: canDispatch
                  ? (value) {
                      setState(() {
                        _dispatchStatus[train.name] = value;
                      });
                    }
                  : null,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  void _submitDispatchStatus() {
    final readyTrains = _dispatchStatus.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${readyTrains.length} trains marked as ready for dispatch',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
