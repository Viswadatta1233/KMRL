import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';

class RepairUpdateForm extends ConsumerStatefulWidget {
  final List<Train> trains;

  const RepairUpdateForm({super.key, required this.trains});

  @override
  ConsumerState<RepairUpdateForm> createState() => _RepairUpdateFormState();
}

class _RepairUpdateFormState extends ConsumerState<RepairUpdateForm> {
  String? _selectedTrain;
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();
  bool _hasRepairIssues = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _notesController.dispose();
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
              'Repair Update Form',
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
            SwitchListTile(
              title: const Text('Has Repair Issues'),
              subtitle: const Text('Check if train has repair issues'),
              value: _hasRepairIssues,
              onChanged: (value) => setState(() => _hasRepairIssues = value),
              activeColor: Colors.red,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Repair Description',
                prefixIcon: Icon(Icons.build),
                hintText:
                    'Describe what repair was performed or issue found...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes',
                prefixIcon: Icon(Icons.note),
                hintText: 'Any additional notes or observations...',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _selectedTrain != null ? _submitRepairUpdate : null,
                icon: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  _isLoading ? 'Submitting...' : 'Submit Repair Update',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.kmrlPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Repair Status Overview',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...widget.trains.map((train) => _buildRepairStatusCard(train)),
          ],
        ),
      ),
    );
  }

  Widget _buildRepairStatusCard(Train train) {
    final hasIssues = train.hasRepairIssues;
    final color = hasIssues ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(
                hasIssues ? Icons.warning : Icons.check_circle,
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
                  if (train.repairNotes != null)
                    Text(
                      'Notes: ${train.repairNotes}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
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
                hasIssues ? 'NEEDS REPAIR' : 'OK',
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

  void _submitRepairUpdate() async {
    if (_selectedTrain == null) return;

    setState(() {
      _isLoading = true;
    });

    // Update train repair status
    ref
        .read(trainsProvider.notifier)
        .updateRepairStatus(
          _selectedTrain!,
          _hasRepairIssues,
          _notesController.text.isNotEmpty ? _notesController.text : null,
        );

    // Add maintenance update
    final update = MaintenanceUpdate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      trainName: _selectedTrain!,
      type: 'repair',
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : (_hasRepairIssues ? 'Repair issues reported' : 'Repair completed'),
      timestamp: DateTime.now(),
    );

    ref.read(maintenanceUpdatesProvider.notifier).addMaintenanceUpdate(update);

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Repair update submitted for $_selectedTrain'),
        backgroundColor: Colors.green,
      ),
    );

    // Reset form
    setState(() {
      _selectedTrain = null;
      _descriptionController.clear();
      _notesController.clear();
      _hasRepairIssues = false;
    });
  }
}
