import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/train_model.dart';
import '../data/mock_data.dart';

// User role provider
final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.occ);

enum UserRole { occ, supervisor, maintenance }

// Trains provider
final trainsProvider = StateNotifierProvider<TrainsNotifier, List<Train>>((
  ref,
) {
  return TrainsNotifier();
});

class TrainsNotifier extends StateNotifier<List<Train>> {
  TrainsNotifier() : super(MockData.getMockTrains());

  void updateTrain(Train updatedTrain) {
    state = state
        .map((train) => train.name == updatedTrain.name ? updatedTrain : train)
        .toList();
  }

  void updateTrainStatus(String trainName, TrainStatus status) {
    state = state.map((train) {
      if (train.name == trainName) {
        return train.copyWith(status: status);
      }
      return train;
    }).toList();
  }

  void updateJobCardStatus(String trainName, JobCardStatus status) {
    state = state.map((train) {
      if (train.name == trainName) {
        return train.copyWith(jobCardStatus: status);
      }
      return train;
    }).toList();
  }

  void updateCleaningStatus(String trainName, bool isCleaned) {
    state = state.map((train) {
      if (train.name == trainName) {
        return train.copyWith(isCleaned: isCleaned);
      }
      return train;
    }).toList();
  }

  void updateRepairStatus(String trainName, bool hasIssues, String? notes) {
    state = state.map((train) {
      if (train.name == trainName) {
        return train.copyWith(hasRepairIssues: hasIssues, repairNotes: notes);
      }
      return train;
    }).toList();
  }

  List<Train> getBestFitTrainsForBranding(int requiredHours) {
    // Get all trains and sort by suitability for branding
    final allTrains = List<Train>.from(state);

    // Sort by priority: branding available > service status > cleaned > no repair issues
    allTrains.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;

      // Branding availability (highest priority)
      if (a.isBrandingAvailable) scoreA += 100;
      if (b.isBrandingAvailable) scoreB += 100;

      // Service status
      if (a.status == TrainStatus.service) scoreA += 50;
      if (b.status == TrainStatus.service) scoreB += 50;

      // Cleaned status
      if (a.isCleaned) scoreA += 25;
      if (b.isCleaned) scoreB += 25;

      // No repair issues
      if (!a.hasRepairIssues) scoreA += 10;
      if (!b.hasRepairIssues) scoreB += 10;

      // Lower mileage is better (more available for longer campaigns)
      scoreA += (20000 - a.mileage) ~/ 100;
      scoreB += (20000 - b.mileage) ~/ 100;

      return scoreB.compareTo(scoreA);
    });

    // Return top 5-8 trains, prioritizing those that meet more criteria
    return allTrains.take(8).toList();
  }
}

// Branding rules provider
final brandingRulesProvider =
    StateNotifierProvider<BrandingRulesNotifier, List<BrandingRule>>((ref) {
      return BrandingRulesNotifier();
    });

class BrandingRulesNotifier extends StateNotifier<List<BrandingRule>> {
  BrandingRulesNotifier() : super(MockData.getMockBrandingRules());

  void addBrandingRule(BrandingRule rule) {
    state = [...state, rule];
  }
}

// Maintenance updates provider
final maintenanceUpdatesProvider =
    StateNotifierProvider<MaintenanceUpdatesNotifier, List<MaintenanceUpdate>>((
      ref,
    ) {
      return MaintenanceUpdatesNotifier();
    });

class MaintenanceUpdatesNotifier
    extends StateNotifier<List<MaintenanceUpdate>> {
  MaintenanceUpdatesNotifier() : super(MockData.getMockMaintenanceUpdates());

  void addMaintenanceUpdate(MaintenanceUpdate update) {
    state = [...state, update];
  }

  void approveMaintenanceUpdate(String id, String comments) {
    state = state.map((update) {
      if (update.id == id) {
        return MaintenanceUpdate(
          id: update.id,
          trainName: update.trainName,
          type: update.type,
          description: update.description,
          timestamp: update.timestamp,
          isApproved: true,
          supervisorComments: comments,
        );
      }
      return update;
    }).toList();
  }

  void rejectMaintenanceUpdate(String id, String comments) {
    state = state.map((update) {
      if (update.id == id) {
        return MaintenanceUpdate(
          id: update.id,
          trainName: update.trainName,
          type: update.type,
          description: update.description,
          timestamp: update.timestamp,
          isApproved: false,
          supervisorComments: comments,
        );
      }
      return update;
    }).toList();
  }
}

// Spare parts provider
final sparePartsProvider =
    StateNotifierProvider<SparePartsNotifier, List<SparePartRequest>>((ref) {
      return SparePartsNotifier();
    });

class SparePartsNotifier extends StateNotifier<List<SparePartRequest>> {
  SparePartsNotifier() : super(MockData.getMockSparePartRequests());

  void addSparePartRequest(SparePartRequest request) {
    state = [...state, request];
  }

  void approveSparePartRequest(String id) {
    state = state.map((request) {
      if (request.id == id) {
        return SparePartRequest(
          id: request.id,
          partName: request.partName,
          quantity: request.quantity,
          priority: request.priority,
          requestedDate: request.requestedDate,
          isApproved: true,
        );
      }
      return request;
    }).toList();
  }
}

// Final induction list provider
final finalInductionListProvider = Provider<List<Train>>((ref) {
  final trains = ref.watch(trainsProvider);
  // Return all trains so the FinalInductionList widget can categorize them properly
  return trains;
});
