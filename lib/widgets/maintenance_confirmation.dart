import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';
import '../providers/app_providers.dart';

class MaintenanceConfirmation extends ConsumerWidget {
  final List<MaintenanceUpdate> updates;

  const MaintenanceConfirmation({super.key, required this.updates});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingUpdates = updates
        .where((update) => !update.isApproved)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Maintenance Confirmations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (pendingUpdates.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'No pending maintenance confirmations',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              ...pendingUpdates.map(
                (update) => _buildUpdateCard(context, ref, update),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard(
    BuildContext context,
    WidgetRef ref,
    MaintenanceUpdate update,
  ) {
    final isCleaning = update.type == 'cleaning';
    final icon = isCleaning ? Icons.cleaning_services : Icons.build;
    final color = isCleaning ? Colors.blue : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  update.trainName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color),
                  ),
                  child: Text(
                    update.type.toUpperCase(),
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
            Text(update.description),
            const SizedBox(height: 4),
            Text(
              'Submitted: ${update.timestamp.toLocal().toString().split('.')[0]}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 12),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ElevatedButton.icon(
            //         onPressed: () => _approveUpdate(context, ref, update),
            //         icon: const Icon(Icons.check, size: 16),
            //         label: const Text('Approve'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.green,
            //           foregroundColor: Colors.white,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: ElevatedButton.icon(
            //         onPressed: () => _rejectUpdate(context, ref, update),
            //         icon: const Icon(Icons.close, size: 16),
            //         label: const Text('Reject'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.red,
            //           foregroundColor: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void _approveUpdate(
    BuildContext context,
    WidgetRef ref,
    MaintenanceUpdate update,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        final commentsController = TextEditingController();
        return AlertDialog(
          title: const Text('Approve Maintenance Update'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Approve ${update.type} update for ${update.trainName}?'),
              const SizedBox(height: 16),
              TextField(
                controller: commentsController,
                decoration: const InputDecoration(
                  labelText: 'Comments (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(maintenanceUpdatesProvider.notifier)
                    .approveMaintenanceUpdate(
                      update.id,
                      commentsController.text,
                    );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Maintenance update approved'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Approve'),
            ),
          ],
        );
      },
    );
  }

  void _rejectUpdate(
    BuildContext context,
    WidgetRef ref,
    MaintenanceUpdate update,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        final commentsController = TextEditingController();
        return AlertDialog(
          title: const Text('Reject Maintenance Update'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Reject ${update.type} update for ${update.trainName}?'),
              const SizedBox(height: 16),
              TextField(
                controller: commentsController,
                decoration: const InputDecoration(
                  labelText: 'Reason for rejection',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(maintenanceUpdatesProvider.notifier)
                    .rejectMaintenanceUpdate(
                      update.id,
                      commentsController.text,
                    );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Maintenance update rejected'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }
}
