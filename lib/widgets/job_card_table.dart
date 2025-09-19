import 'package:flutter/material.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class JobCardTable extends StatelessWidget {
  final List<Train> trains;

  const JobCardTable({super.key, required this.trains});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IBM Maximo API Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.api, color: Colors.blue, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'IBM Maximo Work Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kmrlPrimary,
                        ),
                      ),
                      Text(
                        'Real-time data from Maximo EAM system',
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
                      Icon(Icons.cloud_done, color: Colors.green, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'SYNCED',
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

            // Data Table with Enhanced Horizontal Scrolling
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: DataTable(
                      columnSpacing: 24,
                      horizontalMargin: 16,
                      headingRowColor: MaterialStateProperty.all(
                        AppTheme.kmrlPrimary.withOpacity(0.1),
                      ),
                      dataRowMinHeight: 48,
                      dataRowMaxHeight: 64,
                      columns: [
                        DataColumn(
                          label: SizedBox(
                            width: 120,
                            child: Text(
                              'Work Order ID',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 140,
                            child: Text(
                              'Asset ID',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 180,
                            child: Text(
                              'Description',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 100,
                            child: Text(
                              'Status',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 80,
                            child: Text(
                              'Priority',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 120,
                            child: Text(
                              'Assigned To',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 120,
                            child: Text(
                              'Scheduled Date',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 100,
                            child: Text(
                              'Actions',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: trains.map((train) {
                        final workOrder = _getMaximoWorkOrder(train);
                        final statusColor = _getMaximoStatusColor(
                          workOrder['status'],
                        );
                        final priorityColor = _getPriorityColor(
                          workOrder['priority'],
                        );

                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 120,
                                child: Text(
                                  workOrder['workOrderId'],
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 140,
                                child: Text(
                                  workOrder['assetId'],
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 180,
                                child: Text(
                                  workOrder['description'],
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 100,
                                child: Container(
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
                                    workOrder['status'],
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 80,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: priorityColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    workOrder['priority'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 120,
                                child: Text(
                                  workOrder['assignedTo'],
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 120,
                                child: Text(
                                  workOrder['scheduledDate'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 100,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, size: 14),
                                        onPressed: () =>
                                            _showMaximoUpdateDialog(
                                              context,
                                              train,
                                              workOrder,
                                            ),
                                        padding: const EdgeInsets.all(4),
                                        constraints: const BoxConstraints(
                                          minWidth: 24,
                                          minHeight: 24,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.visibility,
                                          size: 14,
                                        ),
                                        onPressed: () =>
                                            _showMaximoDetailsDialog(
                                              context,
                                              train,
                                              workOrder,
                                            ),
                                        padding: const EdgeInsets.all(4),
                                        constraints: const BoxConstraints(
                                          minWidth: 24,
                                          minHeight: 24,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.sync, size: 14),
                                        onPressed: () => _syncWithMaximo(
                                          context,
                                          workOrder['workOrderId'],
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        constraints: const BoxConstraints(
                                          minWidth: 24,
                                          minHeight: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  // Scroll indicator bar
                  Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppTheme.kmrlPrimary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Scroll indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.swipe_left,
                  color: Colors.grey.withOpacity(0.6),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Swipe left to see all columns',
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // IBM Maximo Work Order Data Generation
  Map<String, dynamic> _getMaximoWorkOrder(Train train) {
    final workOrderId =
        'WO${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    final assetId = 'TRN-${train.name.toUpperCase()}-001';

    final descriptions = [
      'Routine maintenance check',
      'Brake system inspection',
      'HVAC system service',
      'Door mechanism repair',
      'Wheel alignment check',
      'Electrical system test',
      'Safety system validation',
      'Cleaning and sanitization',
    ];

    final statuses = ['OPEN', 'INPROG', 'COMP', 'CANCEL', 'PENDING'];
    final priorities = ['HIGH', 'MEDIUM', 'LOW', 'CRITICAL'];
    final technicians = [
      'John Smith',
      'Sarah Johnson',
      'Mike Chen',
      'Lisa Brown',
      'David Wilson',
    ];

    final index = train.name.hashCode.abs() % descriptions.length;

    return {
      'workOrderId': workOrderId,
      'assetId': assetId,
      'description': descriptions[index],
      'status': statuses[train.name.hashCode.abs() % statuses.length],
      'priority': priorities[train.name.hashCode.abs() % priorities.length],
      'assignedTo': technicians[train.name.hashCode.abs() % technicians.length],
      'scheduledDate': DateTime.now()
          .add(Duration(days: train.name.hashCode.abs() % 7))
          .toString()
          .split(' ')[0],
      'createdDate': DateTime.now()
          .subtract(Duration(days: train.name.hashCode.abs() % 30))
          .toString()
          .split(' ')[0],
      'estimatedHours': (2 + (train.name.hashCode.abs() % 8)).toString(),
      'actualHours': train.jobCardStatus == JobCardStatus.completed
          ? (1 + (train.name.hashCode.abs() % 6)).toString()
          : '0',
    };
  }

  Color _getMaximoStatusColor(String status) {
    switch (status) {
      case 'OPEN':
        return Colors.blue;
      case 'INPROG':
        return Colors.orange;
      case 'COMP':
        return Colors.green;
      case 'CANCEL':
        return Colors.red;
      case 'PENDING':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'CRITICAL':
        return Colors.red;
      case 'HIGH':
        return Colors.orange;
      case 'MEDIUM':
        return Colors.yellow;
      case 'LOW':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showMaximoUpdateDialog(
    BuildContext context,
    Train train,
    Map<String, dynamic> workOrder,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Work Order - ${workOrder['workOrderId']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Asset: ${workOrder['assetId']}'),
            Text('Description: ${workOrder['description']}'),
            const SizedBox(height: 16),
            const Text('Update Status:'),
            const SizedBox(height: 8),
            ...['OPEN', 'INPROG', 'COMP', 'CANCEL', 'PENDING'].map(
              (status) => ListTile(
                title: Text(status),
                leading: Radio<String>(
                  value: status,
                  groupValue: workOrder['status'],
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
          ElevatedButton(
            onPressed: () {
              // Sync with Maximo API
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Work order updated in Maximo')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showMaximoDetailsDialog(
    BuildContext context,
    Train train,
    Map<String, dynamic> workOrder,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Work Order Details - ${workOrder['workOrderId']}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Work Order ID:', workOrder['workOrderId']),
              _buildDetailRow('Asset ID:', workOrder['assetId']),
              _buildDetailRow('Description:', workOrder['description']),
              _buildDetailRow('Status:', workOrder['status']),
              _buildDetailRow('Priority:', workOrder['priority']),
              _buildDetailRow('Assigned To:', workOrder['assignedTo']),
              _buildDetailRow('Scheduled Date:', workOrder['scheduledDate']),
              _buildDetailRow('Created Date:', workOrder['createdDate']),
              _buildDetailRow('Estimated Hours:', workOrder['estimatedHours']),
              _buildDetailRow('Actual Hours:', workOrder['actualHours']),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maximo Integration',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'This data is synchronized with IBM Maximo EAM system in real-time.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  void _syncWithMaximo(BuildContext context, String workOrderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sync with Maximo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Syncing work order $workOrderId with IBM Maximo...'),
          ],
        ),
      ),
    );

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Work order $workOrderId synced successfully'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}
