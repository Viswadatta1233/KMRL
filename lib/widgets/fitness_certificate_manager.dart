import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';

class FitnessCertificateManager extends ConsumerStatefulWidget {
  final List<Train> trains;

  const FitnessCertificateManager({super.key, required this.trains});

  @override
  ConsumerState<FitnessCertificateManager> createState() =>
      _FitnessCertificateManagerState();
}

class _FitnessCertificateManagerState
    extends ConsumerState<FitnessCertificateManager> {
  String? _selectedTrain;
  CertificateType? _selectedCertificate;
  DateTime? _newValidityDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Certificate Validity',
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
            DropdownButtonFormField<CertificateType>(
              value: _selectedCertificate,
              decoration: const InputDecoration(
                labelText: 'Certificate Type',
                prefixIcon: Icon(Icons.verified),
              ),
              items: CertificateType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_getCertificateTypeName(type)),
                );
              }).toList(),
              onChanged: (value) =>
                  setState(() => _selectedCertificate = value),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('New Validity Date'),
              subtitle: Text(
                _newValidityDate?.toLocal().toString().split(' ')[0] ??
                    'Select date',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate:
                      _newValidityDate ??
                      DateTime.now().add(const Duration(days: 30)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _newValidityDate = date);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _selectedTrain != null &&
                        _selectedCertificate != null &&
                        _newValidityDate != null
                    ? _updateCertificate
                    : null,
                child: const Text('Update Certificate'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Current Certificate Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...widget.trains.map((train) => _buildCertificateCard(train)),
          ],
        ),
      ),
    );
  }

  String _getCertificateTypeName(CertificateType type) {
    switch (type) {
      case CertificateType.rollingStock:
        return 'Rolling Stock';
      case CertificateType.signalling:
        return 'Signalling';
      case CertificateType.telecom:
        return 'Telecom';
    }
  }

  void _updateCertificate() {
    if (_selectedTrain != null &&
        _selectedCertificate != null &&
        _newValidityDate != null) {
      // Update logic would go here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Certificate updated for $_selectedTrain'),
          backgroundColor: Colors.green,
        ),
      );

      // Reset form
      setState(() {
        _selectedTrain = null;
        _selectedCertificate = null;
        _newValidityDate = null;
      });
    }
  }

  Widget _buildCertificateCard(Train train) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              train.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...train.certificateValidity.entries.map((entry) {
              final daysUntilExpiry = entry.value
                  .difference(DateTime.now())
                  .inDays;
              final isExpiringSoon = daysUntilExpiry <= 30;

              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isExpiringSoon
                      ? Colors.orange.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isExpiringSoon ? Colors.orange : Colors.green,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_getCertificateTypeName(entry.key)),
                    Text(
                      '${daysUntilExpiry} days',
                      style: TextStyle(
                        color: isExpiringSoon ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
