# KMRL Train Induction Planning System

A comprehensive Flutter prototype application for Kochi Metro's Train Induction Planning System. This application simulates the complete workflow for train induction planning with role-based access control and real-time status updates.

## 🚀 Features

### Role-Based Dashboards
- **OCC (Operations Control Center)**: System monitoring, job card management, CBCT sensor feeds, and branding rule assignment
- **Supervisor**: Fitness certificate management, repair validation, maintenance confirmation, and spare parts planning
- **Maintenance Staff**: Final dispatch checks, cleaning updates, repair reporting, and daily induction list

### Key Functionality
- **System Monitor Board**: Real-time grid view of all 25 trains with color-coded status indicators
- **Job Card Management**: Complete lifecycle tracking from pending to completion
- **CBCT Sensor Monitoring**: Temperature monitoring with alert system
- **Branding Rule Assignment**: Intelligent train selection based on availability and requirements
- **Fitness Certificate Management**: Track and update rolling stock, signalling, and telecom certificates
- **Maintenance Workflow**: Complete cleaning and repair update system with supervisor approval
- **Spare Parts Planning**: Request and track spare parts with priority management
- **Final Induction List**: Live-updating categorized list of trains ready for service

## 🎨 Design

- **Material 3 Design**: Modern, accessible UI following Material Design principles
- **KMRL Branding**: Custom color scheme using KMRL's signature color (#09afaa)
- **Responsive Layout**: Optimized for various screen sizes
- **Intuitive Navigation**: Tab-based navigation with role-specific dashboards

## 🛠 Technical Stack

- **Flutter**: Cross-platform mobile development framework
- **Riverpod**: State management and dependency injection
- **Material 3**: Modern UI components and theming
- **Mock Data**: Complete simulation without backend dependencies

## 📱 Screens

### 1. Login Screen
- Role selection (OCC/Supervisor/Maintenance)
- Email and password authentication
- KMRL logo integration
- Animated role selection cards

### 2. OCC Dashboard
- **System Monitor**: Grid view of all trains with status indicators
- **Job Cards**: DataTable with status management and updates
- **CBCT Sensors**: Temperature monitoring with alert system
- **Branding Rules**: Campaign creation and best-fit train selection

### 3. Supervisor Dashboard
- **Fitness Certificates**: Certificate validity management
- **Repair Validation**: Approve/reject repair requests
- **Maintenance Confirmation**: Review and approve maintenance updates
- **Spare Parts**: Request and approve spare parts
- **Final Induction**: View categorized induction list

### 4. Maintenance Dashboard
- **Dispatch Check**: One-tap readiness toggle for trains
- **Cleaning Updates**: Mark trains as cleaned/not cleaned
- **Repair Updates**: Report repair issues and completion
- **Induction List**: View daily induction status

## 🚂 Train Data

The application includes 25 trains with realistic mock data:
- Krishna, Tapti, Nila, Sarayu, Aruth, Vaigai, Jhanavi, Dhwanil, Bhavani, Padma
- Mandakini, Yamuna, Periyar, Kabani, Vaayu, Kaveri, Shiriya, Pampa, Narmada, Mahe
- Maarut, Sabarmati, Godhavari, Ganga, Pavan

Each train includes:
- Current status (Service/Standby/Cleaning/Repair)
- Mileage information
- Job card status
- Certificate validity dates
- Cleaning and repair status
- Temperature readings
- Maintenance history

## 🎯 Status Color Coding

- **Green**: Service (Ready for passenger service)
- **Blue**: Standby (Available for service)
- **Yellow**: Cleaning (Under maintenance cleaning)
- **Red**: Repair (Requires repair work)

## 🔧 Installation & Setup

1. **Prerequisites**
   - Flutter SDK (3.9.0 or higher)
   - Dart SDK
   - Android Studio / VS Code with Flutter extensions

2. **Installation**
   ```bash
   cd kmrl
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

## 📋 Usage

1. **Login**: Select your role and enter credentials
2. **Navigate**: Use tab navigation to access different features
3. **Update Status**: Click on trains or use forms to update status
4. **Monitor**: View real-time updates across all dashboards
5. **Approve**: Supervisors can approve/reject maintenance requests

## 🎨 Customization

The application uses a centralized theme system in `lib/theme/app_theme.dart`:
- Primary color: #09afaa (KMRL signature color)
- Status colors for different train states
- Material 3 components with custom styling

## 📁 Project Structure

```
lib/
├── data/
│   └── mock_data.dart          # Mock data for 25 trains
├── models/
│   └── train_model.dart        # Data models and enums
├── providers/
│   └── app_providers.dart      # Riverpod state management
├── screens/
│   ├── login_screen.dart       # Login and role selection
│   ├── dashboard_screen.dart   # Main dashboard router
│   ├── occ_dashboard.dart      # OCC-specific dashboard
│   ├── supervisor_dashboard.dart # Supervisor dashboard
│   └── maintenance_dashboard.dart # Maintenance dashboard
├── theme/
│   └── app_theme.dart          # App theming and colors
├── widgets/
│   ├── train_status_grid.dart  # Train status grid component
│   ├── job_card_table.dart     # Job card management
│   ├── cbct_sensor_feed.dart   # Sensor monitoring
│   ├── branding_rule_form.dart # Branding rule creation
│   ├── fitness_certificate_manager.dart # Certificate management
│   ├── repair_status_validator.dart # Repair validation
│   ├── maintenance_confirmation.dart # Maintenance approval
│   ├── spare_parts_planner.dart # Spare parts management
│   ├── final_dispatch_check.dart # Dispatch readiness
│   ├── cleaning_update_form.dart # Cleaning updates
│   ├── repair_update_form.dart # Repair updates
│   ├── final_induction_list.dart # Induction list
│   └── role_selection_card.dart # Role selection UI
└── main.dart                   # App entry point
```

## 🚀 Future Enhancements

- Real-time data synchronization
- Push notifications for critical updates
- Offline mode support
- Advanced reporting and analytics
- Integration with actual KMRL systems
- Multi-language support
- Advanced user management

## 📄 License

This project is developed as a prototype for Kochi Metro Rail Limited (KMRL) and is intended for demonstration purposes only.

## 🤝 Contributing

This is a prototype application. For production use, please contact KMRL for proper integration and deployment guidelines.

---

**Note**: This application uses mock data and simulated workflows. It is designed for demonstration and training purposes only.