import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';

class CleaningUpdateForm extends ConsumerStatefulWidget {
  final List<Train> trains;

  const CleaningUpdateForm({super.key, required this.trains});

  @override
  ConsumerState<CleaningUpdateForm> createState() => _CleaningUpdateFormState();
}

class _CleaningUpdateFormState extends ConsumerState<CleaningUpdateForm> {
  String? _selectedTrain;
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
              'Cleaning Update Form',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTrain,
              decoration: const InputDecoration(
                labelText: 'Select Train',
                prefixIcon: Icon(Icons.train),
              ),
              items: widget.trains.map((train) {
                return DropdownMenuItem(
                  value: train.name,
                  child: Text(train.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedTrain = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Cleaning Description',
                prefixIcon: Icon(Icons.cleaning_services),
                hintText: 'Describe what cleaning was performed...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _selectedTrain != null ? _markAsCleaned : null,
                    icon: const Icon(Icons.check),
                    label: const Text('Mark as Cleaned'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _selectedTrain != null
                        ? _markAsNotCleaned
                        : null,
                    icon: const Icon(Icons.close),
                    label: const Text('Mark as Not Cleaned'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Cleaning Status Overview',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...widget.trains.map((train) => _buildCleaningStatusCard(train)),
          ],
        ),
      ),
    );
  }

  Widget _buildCleaningStatusCard(Train train) {
    final isCleaned = train.isCleaned;
    final color = isCleaned ? Colors.green : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(
                isCleaned ? Icons.check : Icons.pending,
                color: Colors.white,
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
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color),
              ),
              child: Text(
                isCleaned ? 'CLEANED' : 'PENDING',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAsCleaned() async {
    if (_selectedTrain == null) return;

    // Update train cleaning status
    ref
        .read(trainsProvider.notifier)
        .updateCleaningStatus(_selectedTrain!, true);

    // Add maintenance update
    final update = MaintenanceUpdate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      trainName: _selectedTrain!,
      type: 'cleaning',
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : 'Cleaning completed',
      timestamp: DateTime.now(),
    );

    ref.read(maintenanceUpdatesProvider.notifier).addMaintenanceUpdate(update);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_selectedTrain marked as cleaned'),
        backgroundColor: Colors.green,
      ),
    );

    // Reset form
    setState(() {
      _selectedTrain = null;
      _descriptionController.clear();
    });
  }

  void _markAsNotCleaned() async {
    if (_selectedTrain == null) return;

    // Update train cleaning status
    ref
        .read(trainsProvider.notifier)
        .updateCleaningStatus(_selectedTrain!, false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_selectedTrain marked as not cleaned'),
        backgroundColor: Colors.orange,
      ),
    );

    // Reset form
    setState(() {
      _selectedTrain = null;
      _descriptionController.clear();
    });
  }
}
