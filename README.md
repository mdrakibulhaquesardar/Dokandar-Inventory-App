# Dokandar App Inventory

<p align="center">
  <img src="assets/icon_bg_remove_with_name.png" alt="Dokandar App Logo" width="200"/>
</p>

## Application Screenshots 
<p align="center">
  <img src="assets\promo_images\1.jpg" alt="Splash Screen" width="200"/>
  <img src="assets\promo_images\2.jpg" alt="Login Screen" width="200"/>
  <img src="assets\promo_images\3.jpg" alt="Home Screen" width="200"/>
  <img src="assets\promo_images\4.jpg" alt="Add Product Screen" width="200"/>
</p>

## Overview

Dokandar App Inventory is a modern Flutter-based inventory management system designed for small to medium-sized businesses. It provides an intuitive interface for managing products, tracking stock levels, and handling basic business operations efficiently.

## Features

- 📦 **Inventory Management**
  - Real-time stock tracking
  - Product categorization
  - Stock alerts and notifications

- 💼 **Business Operations**
  - Sales tracking
  - Purchase management
  - Supplier management

- 📊 **Reporting**
  - Sales reports
  - Inventory reports
  - Financial summaries

- 👥 **User Management**
  - Role-based access control
  - User authentication
  - Profile management

## Technology Stack

- **Frontend**: Flutter
- **Database**: Isar (Local Database)
- **State Management**: GetX
- **Authentication**: Local Auth

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/dokandar_app_inventory.git
   ```

2. Navigate to project directory
   ```bash
   cd dokandar_app_inventory
   ```

3. Install dependencies
   ```bash
   flutter pub get
   ```

4. **Configure the App (IMPORTANT for CodeCanyon Users)**
   
   Open `lib/app/config/app_config.dart` and customize the following:
   
   - **App Information**: Update `appName`, `appVersion`, `appDescription`, etc.
   - **Developer/Company Info**: Change `developerName`, `supportEmail`, `website` to your own information
   - **Subscription Plans**: Modify `subscriptionPlans` map with your pricing and plans
   - **Feature Flags**: Enable/disable features like `enableSubscription`, `enableDarkMode`, etc.
   - **Limits**: Adjust `freePlanProductLimit`, `freePlanCustomerLimit`, `lowStockThreshold`
   - **Theme Colors**: Customize `themeColors` map for your brand colors
   - **Currency**: Update `currencySymbol`, `decimalPlaces`, etc. for your region
   
   **All app configurations are centralized in this single file!**

5. Run the app
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── app/
│   ├── config/      # App configuration files (app_config.dart - MAIN CONFIG FILE)
│   ├── controllers/ # GetX controllers
│   ├── data/        # Data models and repositories
│   ├── modules/     # Feature modules
│   ├── routes/      # App routes
│   ├── utils/       # Utility functions
│   ├── views/       # UI screens
│   └── widgets/     # Reusable widgets
└── main.dart        # Entry point
```

## Configuration Guide

### For CodeCanyon Buyers

This app is designed to be easily customizable through a single configuration file: `lib/app/config/app_config.dart`

**Key Configuration Areas:**

1. **App Branding**
   - App name, version, description
   - Developer/company information
   - Support email and website

2. **Features**
   - Enable/disable subscription system
   - Toggle dark mode, notifications, backup, analytics
   - Multi-language support

3. **Subscription System**
   - Configure subscription plans (monthly, quarterly, half-yearly)
   - Set free plan limits (products, customers)
   - Trial period duration

4. **Business Rules**
   - Low stock threshold
   - Currency settings
   - Date/time formats

5. **Theme & UI**
   - Primary/secondary colors
   - Background/surface colors
   - Text colors

**All changes made in `app_config.dart` are automatically reflected throughout the entire app!**

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you have any questions or need help, please open an issue in the repository.

---

Developed with ❤️ by [Your Name/Organization]
