import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';
import '../providers/app_providers.dart';

class SparePartsPlanner extends ConsumerStatefulWidget {
  final List<SparePartRequest> requests;

  const SparePartsPlanner({super.key, required this.requests});

  @override
  ConsumerState<SparePartsPlanner> createState() => _SparePartsPlannerState();
}

class _SparePartsPlannerState extends ConsumerState<SparePartsPlanner> {
  final _formKey = GlobalKey<FormState>();
  final _partNameController = TextEditingController();
  final _quantityController = TextEditingController();
  String _selectedPriority = 'Medium';

  @override
  void dispose() {
    _partNameController.dispose();
    _quantityController.dispose();
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
              'Request Spare Parts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _partNameController,
                    decoration: const InputDecoration(
                      labelText: 'Part Name',
                      prefixIcon: Icon(Icons.inventory),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter part name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      prefixIcon: Icon(Icons.priority_high),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Low', child: Text('Low')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'High', child: Text('High')),
                      DropdownMenuItem(
                        value: 'Critical',
                        child: Text('Critical'),
                      ),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedPriority = value!),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitRequest,
                      child: const Text('Submit Request'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pending Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...widget.requests.map((request) => _buildRequestCard(request)),
          ],
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      final request = SparePartRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        partName: _partNameController.text,
        quantity: int.parse(_quantityController.text),
        priority: _selectedPriority,
        requestedDate: DateTime.now(),
      );

      ref.read(sparePartsProvider.notifier).addSparePartRequest(request);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Spare parts request submitted'),
          backgroundColor: Colors.green,
        ),
      );

      // Reset form
      _partNameController.clear();
      _quantityController.clear();
      _selectedPriority = 'Medium';
    }
  }

  Widget _buildRequestCard(SparePartRequest request) {
    final priorityColor = _getPriorityColor(request.priority);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.partName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: priorityColor),
                  ),
                  child: Text(
                    request.priority.toUpperCase(),
                    style: TextStyle(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Quantity: ${request.quantity}'),
            Text(
              'Requested: ${request.requestedDate.toLocal().toString().split(' ')[0]}',
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (request.isApproved)
                  const Icon(Icons.check_circle, color: Colors.green, size: 20)
                else
                  const Icon(Icons.pending, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text(
                  request.isApproved ? 'Approved' : 'Pending',
                  style: TextStyle(
                    color: request.isApproved ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Low':
        return Colors.green;
      case 'Medium':
        return Colors.blue;
      case 'High':
        return Colors.orange;
      case 'Critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
