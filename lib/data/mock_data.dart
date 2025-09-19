import '../models/train_model.dart';

class MockData {
  static const List<String> trainNames = [
    'Krishna',
    'Tapti',
    'Nila',
    'Sarayu',
    'Aruth',
    'Vaigai',
    'Jhanavi',
    'Dhwanil',
    'Bhavani',
    'Padma',
    'Mandakini',
    'Yamuna',
    'Periyar',
    'Kabani',
    'Vaayu',
    'Kaveri',
    'Shiriya',
    'Pampa',
    'Narmada',
    'Mahe',
    'Maarut',
    'Sabarmati',
    'Godhavari',
    'Ganga',
    'Pavan',
  ];

  static List<Train> getMockTrains() {
    final now = DateTime.now();
    return trainNames.map((name) {
      final index = trainNames.indexOf(name);
      return Train(
        name: name,
        mileage: 15000 + (index * 500),
        status: _getRandomStatus(index),
        jobCardStatus: _getRandomJobCardStatus(index),
        certificateValidity: {
          CertificateType.rollingStock: now.add(
            Duration(days: 30 + (index * 2)),
          ),
          CertificateType.signalling: now.add(Duration(days: 45 + (index * 3))),
          CertificateType.telecom: now.add(Duration(days: 60 + (index * 4))),
        },
        isCleaned: index % 3 == 0,
        hasRepairIssues: index % 5 == 0,
        isBrandingAvailable: index % 4 != 0,
        temperature: 22.0 + (index * 0.5),
        lastMaintenanceDate: now
            .subtract(Duration(days: index * 2))
            .toIso8601String(),
        repairNotes: index % 5 == 0 ? 'Minor brake adjustment needed' : null,
        // Additional sensor data for AI predictions
        vibrationLevel: 2.1 + (index * 0.1),
        brakeWearPercentage: 15.0 + (index * 2.5),
        hvacEfficiency: 85.0 + (index * 1.2),
        doorCycleCount: 15000 + (index * 500),
        wheelWear: 8.0 + (index * 0.8),
      );
    }).toList();
  }

  static TrainStatus _getRandomStatus(int index) {
    // Redistribute: 14 in Service, 3 in Repair, 5 in Cleaning, 3 in Standby
    if (index < 14) return TrainStatus.service;
    if (index < 17) return TrainStatus.repair;
    if (index < 22) return TrainStatus.cleaning;
    return TrainStatus.standby;
  }

  static JobCardStatus _getRandomJobCardStatus(int index) {
    final statuses = [
      JobCardStatus.pending,
      JobCardStatus.inProgress,
      JobCardStatus.completed,
      JobCardStatus.failed,
    ];
    return statuses[index % statuses.length];
  }

  static List<BrandingRule> getMockBrandingRules() {
    final now = DateTime.now();
    return [
      BrandingRule(
        id: '1',
        campaignName: 'Summer Tourism Campaign',
        requiredHours: 48,
        startDate: now,
        endDate: now.add(Duration(days: 30)),
        bestFitTrains: ['Krishna', 'Tapti', 'Nila'],
      ),
      BrandingRule(
        id: '2',
        campaignName: 'Festival Special',
        requiredHours: 72,
        startDate: now.add(Duration(days: 5)),
        endDate: now.add(Duration(days: 15)),
        bestFitTrains: ['Sarayu', 'Aruth', 'Vaigai'],
      ),
    ];
  }

  static List<MaintenanceUpdate> getMockMaintenanceUpdates() {
    final now = DateTime.now();
    return [
      MaintenanceUpdate(
        id: '1',
        trainName: 'Krishna',
        type: 'cleaning',
        description: 'Deep cleaning completed',
        timestamp: now.subtract(Duration(hours: 2)),
      ),
      MaintenanceUpdate(
        id: '2',
        trainName: 'Tapti',
        type: 'repair',
        description: 'Brake system maintenance',
        timestamp: now.subtract(Duration(hours: 4)),
      ),
      MaintenanceUpdate(
        id: '3',
        trainName: 'Nila',
        type: 'cleaning',
        description: 'Interior sanitization',
        timestamp: now.subtract(Duration(hours: 1)),
        isApproved: true,
        supervisorComments: 'Approved - Good work',
      ),
    ];
  }

  static List<SparePartRequest> getMockSparePartRequests() {
    final now = DateTime.now();
    return [
      SparePartRequest(
        id: '1',
        partName: 'Brake Pads',
        quantity: 20,
        priority: 'High',
        requestedDate: now.subtract(Duration(days: 1)),
        isApproved: true,
      ),
      SparePartRequest(
        id: '2',
        partName: 'HVAC Filter',
        quantity: 15,
        priority: 'Medium',
        requestedDate: now.subtract(Duration(hours: 6)),
      ),
      SparePartRequest(
        id: '3',
        partName: 'Door Mechanism',
        quantity: 8,
        priority: 'Low',
        requestedDate: now.subtract(Duration(hours: 2)),
      ),
    ];
  }

  static List<String> getPredictiveSpareParts() {
    return [
      'Brake Pads - Likely needed in 2 weeks',
      'HVAC Filter - Replacement due next month',
      'Door Sensors - Preventive maintenance recommended',
      'Wheel Bearings - Check required in 3 weeks',
    ];
  }
}
