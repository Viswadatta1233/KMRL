import 'package:flutter/material.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class JobCardTable extends StatelessWidget {
  final List<Train> trains;

  const JobCardTable({super.key, required this.trains});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text(
                'Train Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Job Card Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Mileage',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Last Maintenance',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: trains.map((train) {
            final statusColor = AppTheme.getJobCardStatusColor(
              train.jobCardStatus,
            );
            final statusText = AppTheme.getJobCardStatusText(
              train.jobCardStatus,
            );

            return DataRow(
              cells: [
                DataCell(Text(train.name)),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                DataCell(Text('${train.mileage} km')),
                DataCell(Text(train.lastMaintenanceDate.split('T')[0])),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 16),
                        onPressed: () => _showUpdateDialog(context, train),
                      ),
                      IconButton(
                        icon: const Icon(Icons.visibility, size: 16),
                        onPressed: () => _showDetailsDialog(context, train),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Train train) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Job Card - ${train.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select new status:'),
            const SizedBox(height: 16),
            ...JobCardStatus.values.map(
              (status) => ListTile(
                title: Text(AppTheme.getJobCardStatusText(status)),
                leading: Radio<JobCardStatus>(
                  value: status,
                  groupValue: train.jobCardStatus,
                  onChanged: (value) {
                    // Update logic would go here
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Train train) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Job Card Details - ${train.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ${AppTheme.getJobCardStatusText(train.jobCardStatus)}',
            ),
            Text('Mileage: ${train.mileage} km'),
            Text(
              'Last Maintenance: ${train.lastMaintenanceDate.split('T')[0]}',
            ),
            Text('Cleaned: ${train.isCleaned ? 'Yes' : 'No'}'),
            Text('Repair Issues: ${train.hasRepairIssues ? 'Yes' : 'No'}'),
            if (train.repairNotes != null) Text('Notes: ${train.repairNotes}'),
          ],
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
}
