import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../models/train_model.dart';
import '../theme/app_theme.dart';

class BrandingRuleForm extends ConsumerStatefulWidget {
  const BrandingRuleForm({super.key});

  @override
  ConsumerState<BrandingRuleForm> createState() => _BrandingRuleFormState();
}

class _BrandingRuleFormState extends ConsumerState<BrandingRuleForm> {
  final _formKey = GlobalKey<FormState>();
  final _campaignController = TextEditingController();
  final _hoursController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));

  @override
  void dispose() {
    _campaignController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final requiredHours = int.tryParse(_hoursController.text) ?? 0;
      final bestFitTrains = ref
          .read(trainsProvider.notifier)
          .getBestFitTrainsForBranding(requiredHours);

      final brandingRule = BrandingRule(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        campaignName: _campaignController.text,
        requiredHours: requiredHours,
        startDate: _startDate,
        endDate: _endDate,
        bestFitTrains: bestFitTrains
            .take(5)
            .map((train) => train.name)
            .toList(),
      );

      ref.read(brandingRulesProvider.notifier).addBrandingRule(brandingRule);

      // Show results
      _showBestFitTrains(bestFitTrains.take(5).toList());

      // Reset form
      _campaignController.clear();
      _hoursController.clear();
      _startDate = DateTime.now();
      _endDate = DateTime.now().add(const Duration(days: 30));
    }
  }

  void _showBestFitTrains(List<Train> trains) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Best Fit Trains'),
        content: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              const Text(
                'Based on your requirements, here are the best fit trains:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: trains.isEmpty
                    ? const Center(
                        child: Text(
                          'No trains currently available for branding. Please try again later.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: trains.length,
                        itemBuilder: (context, index) {
                          final train = trains[index];
                          return _buildSimpleTrainCard(train);
                        },
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

  Widget _buildSimpleTrainCard(Train train) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.getStatusColor(train.status),
            radius: 20,
            child: Text(
              train.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
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
                  overflow: TextOverflow.ellipsis, // avoids overflow
                ),
                const SizedBox(height: 4),
                Text(
                  'Mileage: ${train.mileage} km',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Wrap( // ✅ Wrap instead of Row to avoid overflow
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildSimpleChip(
                      'Branding',
                      train.isBrandingAvailable
                          ? 'Available'
                          : 'Not Available',
                      train.isBrandingAvailable ? Colors.green : Colors.red,
                    ),
                    _buildSimpleChip(
                      'Repair',
                      train.hasRepairIssues ? 'Required' : 'OK',
                      train.hasRepairIssues ? Colors.red : Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildSimpleChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create New Branding Rule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _campaignController,
                decoration: const InputDecoration(
                  labelText: 'Campaign Name',
                  prefixIcon: Icon(Icons.campaign),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter campaign name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                decoration: const InputDecoration(
                  labelText: 'Required Hours',
                  prefixIcon: Icon(Icons.schedule),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter required hours';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Start Date'),
                      subtitle: Text(
                        _startDate.toLocal().toString().split(' ')[0],
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          setState(() => _startDate = date);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('End Date'),
                      subtitle: Text(
                        _endDate.toLocal().toString().split(' ')[0],
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: _startDate,
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          setState(() => _endDate = date);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Create Branding Rule'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
