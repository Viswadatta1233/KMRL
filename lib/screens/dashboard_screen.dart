import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import 'occ_dashboard.dart';
import 'supervisor_dashboard.dart';
import 'maintenance_dashboard.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/kochilogo.png', height: 32, width: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'KMRL Train Induction System',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                ref.read(userRoleProvider.notifier).state = UserRole.occ;
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildDashboardContent(context, userRole),
    );
  }

  Widget _buildDashboardContent(BuildContext context, UserRole userRole) {
    switch (userRole) {
      case UserRole.occ:
        return const OCCDashboard();
      case UserRole.supervisor:
        return const SupervisorDashboard();
      case UserRole.maintenance:
        return const MaintenanceDashboard();
    }
  }
}
