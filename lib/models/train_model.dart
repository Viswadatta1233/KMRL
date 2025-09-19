enum TrainStatus { service, standby, cleaning, repair }

enum JobCardStatus { pending, inProgress, completed, failed }

enum CertificateType { rollingStock, signalling, telecom }

class Train {
  final String name;
  final int mileage;
  final TrainStatus status;
  final JobCardStatus jobCardStatus;
  final Map<CertificateType, DateTime> certificateValidity;
  final bool isCleaned;
  final bool hasRepairIssues;
  final bool isBrandingAvailable;
  final double temperature;
  final String lastMaintenanceDate;
  final String? repairNotes;
  // Additional sensor data for AI predictions
  final double vibrationLevel;
  final double brakeWearPercentage;
  final double hvacEfficiency;
  final int doorCycleCount;
  final double wheelWear;

  Train({
    required this.name,
    required this.mileage,
    required this.status,
    required this.jobCardStatus,
    required this.certificateValidity,
    required this.isCleaned,
    required this.hasRepairIssues,
    required this.isBrandingAvailable,
    required this.temperature,
    required this.lastMaintenanceDate,
    this.repairNotes,
    required this.vibrationLevel,
    required this.brakeWearPercentage,
    required this.hvacEfficiency,
    required this.doorCycleCount,
    required this.wheelWear,
  });

  Train copyWith({
    String? name,
    int? mileage,
    TrainStatus? status,
    JobCardStatus? jobCardStatus,
    Map<CertificateType, DateTime>? certificateValidity,
    bool? isCleaned,
    bool? hasRepairIssues,
    bool? isBrandingAvailable,
    double? temperature,
    String? lastMaintenanceDate,
    String? repairNotes,
    double? vibrationLevel,
    double? brakeWearPercentage,
    double? hvacEfficiency,
    int? doorCycleCount,
    double? wheelWear,
  }) {
    return Train(
      name: name ?? this.name,
      mileage: mileage ?? this.mileage,
      status: status ?? this.status,
      jobCardStatus: jobCardStatus ?? this.jobCardStatus,
      certificateValidity: certificateValidity ?? this.certificateValidity,
      isCleaned: isCleaned ?? this.isCleaned,
      hasRepairIssues: hasRepairIssues ?? this.hasRepairIssues,
      isBrandingAvailable: isBrandingAvailable ?? this.isBrandingAvailable,
      temperature: temperature ?? this.temperature,
      lastMaintenanceDate: lastMaintenanceDate ?? this.lastMaintenanceDate,
      repairNotes: repairNotes ?? this.repairNotes,
      vibrationLevel: vibrationLevel ?? this.vibrationLevel,
      brakeWearPercentage: brakeWearPercentage ?? this.brakeWearPercentage,
      hvacEfficiency: hvacEfficiency ?? this.hvacEfficiency,
      doorCycleCount: doorCycleCount ?? this.doorCycleCount,
      wheelWear: wheelWear ?? this.wheelWear,
    );
  }
}

class BrandingRule {
  final String id;
  final String campaignName;
  final int requiredHours;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> bestFitTrains;

  BrandingRule({
    required this.id,
    required this.campaignName,
    required this.requiredHours,
    required this.startDate,
    required this.endDate,
    required this.bestFitTrains,
  });
}

class MaintenanceUpdate {
  final String id;
  final String trainName;
  final String type; // 'cleaning' or 'repair'
  final String description;
  final DateTime timestamp;
  final bool isApproved;
  final String? supervisorComments;

  MaintenanceUpdate({
    required this.id,
    required this.trainName,
    required this.type,
    required this.description,
    required this.timestamp,
    this.isApproved = false,
    this.supervisorComments,
  });
}

class SparePartRequest {
  final String id;
  final String partName;
  final int quantity;
  final String priority;
  final DateTime requestedDate;
  final bool isApproved;

  SparePartRequest({
    required this.id,
    required this.partName,
    required this.quantity,
    required this.priority,
    required this.requestedDate,
    this.isApproved = false,
  });
}
