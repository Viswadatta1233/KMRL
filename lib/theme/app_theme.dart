import 'package:flutter/material.dart';
import '../models/train_model.dart';

class AppTheme {
  static const Color kmrlPrimary = Color(0xFF09afaa);
  static const Color kmrlSecondary = Color(0xFF0a8a85);
  static const Color kmrlAccent = Color(0xFF4dd0e1);

  static const Color serviceGreen = Color(0xFF4caf50);
  static const Color standbyBlue = Color(0xFF2196f3);
  static const Color cleaningYellow = Color(0xFFff9800);
  static const Color repairRed = Color(0xFFf44336);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kmrlPrimary,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kmrlPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kmrlPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kmrlPrimary, width: 2),
        ),
      ),
    );
  }

  static Color getStatusColor(TrainStatus status) {
    switch (status) {
      case TrainStatus.service:
        return serviceGreen;
      case TrainStatus.standby:
        return standbyBlue;
      case TrainStatus.cleaning:
        return cleaningYellow;
      case TrainStatus.repair:
        return repairRed;
    }
  }

  static String getStatusText(TrainStatus status) {
    switch (status) {
      case TrainStatus.service:
        return 'Service';
      case TrainStatus.standby:
        return 'Standby';
      case TrainStatus.cleaning:
        return 'Cleaning';
      case TrainStatus.repair:
        return 'Repair';
    }
  }

  static Color getJobCardStatusColor(JobCardStatus status) {
    switch (status) {
      case JobCardStatus.pending:
        return Colors.orange;
      case JobCardStatus.inProgress:
        return Colors.blue;
      case JobCardStatus.completed:
        return Colors.green;
      case JobCardStatus.failed:
        return Colors.red;
    }
  }

  static String getJobCardStatusText(JobCardStatus status) {
    switch (status) {
      case JobCardStatus.pending:
        return 'Pending';
      case JobCardStatus.inProgress:
        return 'In Progress';
      case JobCardStatus.completed:
        return 'Completed';
      case JobCardStatus.failed:
        return 'Failed';
    }
  }
}
