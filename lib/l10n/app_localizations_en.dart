// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Dokandar';

  @override
  String get appDescription => 'Inventory Management System';

  @override
  String get settings => 'Settings';

  @override
  String get aboutApp => 'About App';

  @override
  String get subscription => 'Subscription';

  @override
  String get products => 'Products';

  @override
  String get customers => 'Customers';

  @override
  String get sales => 'Sales';

  @override
  String get inventory => 'Inventory';

  @override
  String get addProduct => 'Add Product';

  @override
  String get addCustomer => 'Add Customer';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get search => 'Search';

  @override
  String get name => 'Name';

  @override
  String get price => 'Price';

  @override
  String get quantity => 'Quantity';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get address => 'Address';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get discount => 'Discount';

  @override
  String get dueAmount => 'Due Amount';

  @override
  String get paidAmount => 'Paid Amount';

  @override
  String get lowStock => 'Low Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get noData => 'No data available';

  @override
  String get developerInfo => 'Developer Information';

  @override
  String get appInfo => 'App Information';

  @override
  String get currentVersionAndDescription => 'Current version and description';

  @override
  String get developer => 'Developer';

  @override
  String get changelog => 'Changelog';

  @override
  String get version => 'Version';

  @override
  String get lastUpdate => 'Last Update';

  @override
  String get appSize => 'App Size';

  @override
  String get freePlan => 'Free Plan';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get buyNow => 'Buy Now';

  @override
  String get trialPeriod => 'Trial Period';

  @override
  String days(int count) {
    return '$count days';
  }

  @override
  String productsLimit(int count) {
    return 'You can add up to $count products';
  }

  @override
  String customersLimit(int count) {
    return 'You can add up to $count customers';
  }

  @override
  String get limitReached => 'Limit Reached';

  @override
  String get pleaseUpgrade => 'Please upgrade to add more';

  @override
  String get home => 'Home';

  @override
  String get summaryInfo => 'Summary Information';

  @override
  String get summaryInfoDescription =>
      'View summary information and related details';

  @override
  String get totalProducts => 'Total Products';

  @override
  String get totalSales => 'Total Sales';

  @override
  String get categories => 'Categories';

  @override
  String get todaysOrders => 'Today\'s Orders';

  @override
  String get totalProfit => 'Total Profit';

  @override
  String get recentSales => 'Recent Sales';

  @override
  String get recentSalesDescription =>
      'View recent sales list and transactions';

  @override
  String get stockAlert => 'Stock Alert';

  @override
  String get stockAlertDescription =>
      'Some products are running low on stock, 3 days before stock runs out';

  @override
  String get noRecentSales => 'No recent sales';

  @override
  String get addToStock => 'Add to Stock';

  @override
  String get searchProducts => 'Search Products';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get quickAccessDescription =>
      'Use the options below to quickly access your inventory';

  @override
  String get allProducts => 'All Products';

  @override
  String get salesHistory => 'Sales History';

  @override
  String get allCustomers => 'All Customers';

  @override
  String get allSuppliers => 'All Suppliers';

  @override
  String get storeExpenses => 'Store Expenses';

  @override
  String get allEmployees => 'All Employees';

  @override
  String get otherFunctions => 'Other Functions';

  @override
  String get otherFunctionsDescription =>
      'Use other functions for your inventory';

  @override
  String get duePayment => 'Due Payment';

  @override
  String get productCategories => 'Product Categories';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get supplierManagement => 'Supplier Management';

  @override
  String get generateReport => 'Generate Report';

  @override
  String get viewDetails => 'View Details';

  @override
  String get newLabel => 'New';

  @override
  String get sellCounter => 'Sales Counter';

  @override
  String get searchProduct => 'Search products...';

  @override
  String totalProductsCount(int count) {
    return 'Total Products: $count';
  }

  @override
  String get completeSale => 'Complete Sale';

  @override
  String get noProductsAdded => 'No products added';

  @override
  String get salesCounter => 'Sales Counter';

  @override
  String get yourProducts => 'Your Products';

  @override
  String get stockOut => 'Stock Out';

  @override
  String get recentProducts => 'Recent Products';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get productName => 'Product Name';

  @override
  String get stockQuantity => 'Stock Quantity';

  @override
  String get sellingPrice => 'Selling Price';

  @override
  String get buyingPrice => 'Buying Price';

  @override
  String get profit => 'Profit';

  @override
  String get unitProfit => 'Unit Profit';

  @override
  String get createdAt => 'Created At';

  @override
  String get deleteProduct => 'Delete Product';

  @override
  String get confirmDeleteProduct =>
      'Are you sure you want to delete this product?';

  @override
  String get no => 'No';

  @override
  String get yesDelete => 'Yes, Delete';

  @override
  String get addNewProduct => 'Add New Product';

  @override
  String get category => 'Category';

  @override
  String get customerList => 'Customer List';

  @override
  String get totalCustomers => 'Total Customers';

  @override
  String get newCustomers => 'New Customers';

  @override
  String get totalDue => 'Total Due';

  @override
  String get customerName => 'Customer Name';

  @override
  String get customerPhone => 'Customer Phone';

  @override
  String get customerAddress => 'Customer Address';

  @override
  String get totalPurchases => 'Total Purchases';

  @override
  String get due => 'Due';

  @override
  String get customer => 'Customer';

  @override
  String get salesList => 'Sales List';

  @override
  String get totalTransactions => 'Total Transactions';

  @override
  String get noSales => 'No Sales';

  @override
  String get invoiceNumber => 'Invoice Number';

  @override
  String get date => 'Date';

  @override
  String get paid => 'Paid';

  @override
  String get saleDetails => 'Sale Details';

  @override
  String get productList => 'Product List';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get dueCustomersList => 'Due Customers List';

  @override
  String get totalDueCustomers => 'Total Due Customers';

  @override
  String get noDueCustomers => 'No Due Customers';

  @override
  String get people => 'people';

  @override
  String get payDue => 'Pay Due';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get pay => 'Pay';

  @override
  String get yourCategories => 'Your Categories';

  @override
  String get addCategory => 'Add Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get description => 'Description';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get update => 'Update';

  @override
  String get userSetup => 'User Setup';

  @override
  String get step1of2 => 'Step 1/2';

  @override
  String get step2of2 => 'Step 2/2';

  @override
  String get step3of3 => 'Step 3/3';

  @override
  String get completeYourProfile => 'Complete Your Profile';

  @override
  String get provideRequiredInfo =>
      'Provide the necessary information to manage your business';

  @override
  String get userInformation => 'User Information';

  @override
  String get setupProfileAndProvideInfo =>
      'Set up your profile and provide necessary information for your business';

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get enterYourEmail => 'Enter your email address';

  @override
  String get enterYourPhoneNumber => 'Enter your phone number';

  @override
  String get enterYourAddress => 'Enter your address';

  @override
  String get goToNextStep => 'Go to Next Step';

  @override
  String get step => 'Step';

  @override
  String get completeProfile => 'Complete Your Profile';

  @override
  String get completeProfileDescription =>
      'Provide necessary information to manage your business';

  @override
  String get userInfo => 'User Information';

  @override
  String get userInfoDescription =>
      'Set up your profile and provide information for your business';

  @override
  String get fullName => 'Enter your full name';

  @override
  String get emailAddress => 'Enter your email address';

  @override
  String get mobileNumber => 'Enter your mobile number';

  @override
  String get yourAddress => 'Enter your address';

  @override
  String get nextStep => 'Go to Next Step';

  @override
  String get pinCodeSetup => 'You can optionally set up the PIN code next';

  @override
  String get storeSetup => 'Store Setup';

  @override
  String get addStoreLogo => 'Add Store Logo';

  @override
  String get storeInfo => 'Store Information';

  @override
  String get storeInfoDescription => 'Enter your store information';

  @override
  String get storeName => 'Store Name';

  @override
  String get storeNameRequired => 'Please enter store name';

  @override
  String get addressRequired => 'Please enter address';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberRequired => 'Please enter phone number';

  @override
  String get emailRequired => 'Please enter email';

  @override
  String get validEmailRequired => 'Please enter valid email';

  @override
  String get businessType => 'Business Type';

  @override
  String get businessTypeRequired => 'Please enter business type';

  @override
  String get retailer => 'Retailer';

  @override
  String get wholesaler => 'Wholesaler';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get pharmacy => 'Pharmacy';

  @override
  String get fashionStore => 'Fashion Store';

  @override
  String get electronics => 'Electronics';

  @override
  String get other => 'Other';

  @override
  String get storeInfoNote =>
      'Please enter your store information correctly. This information is important for your business.';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get improveStoreManagement => 'Improve Your Store Management';

  @override
  String get startWithPowerfulTool =>
      'Start managing your store with our powerful store management tool.';

  @override
  String get trackAllActivities => 'Track All Your Store Activities';

  @override
  String get trackActivitiesDescription =>
      'Manage inventory, sales, and transactions in one convenient place.';

  @override
  String get smartBusinessInsights => 'Smart Business Insights';

  @override
  String get smartInsightsDescription =>
      'Get detailed reports and analytics to make informed decisions.';

  @override
  String get secureAndPrivate => 'Secure and Private';

  @override
  String get secureDescription =>
      'Your store information is secure and accessible only to you.';

  @override
  String get startManagingStore => 'Start Managing Your Store';

  @override
  String get startWithTool => 'Start with our powerful store management tool';

  @override
  String get start => 'Start';

  @override
  String get customizeAppSettings => 'Customize your app settings';

  @override
  String get appSettings => 'App Settings';

  @override
  String get appTheme => 'App Theme';

  @override
  String get language => 'Language';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get dataBackup => 'Data Backup';

  @override
  String get dataRestore => 'Data Restore';

  @override
  String get storeSettings => 'Store Settings';

  @override
  String get dokandarSubscription => 'Dokandar Subscription';

  @override
  String get supportAndHelp => 'Support and Help';

  @override
  String get supportCenter => 'Support Center';

  @override
  String get feedback => 'Feedback';

  @override
  String get store => 'Store';

  @override
  String get joinDate => 'Join Date';

  @override
  String get mobile => 'Mobile';

  @override
  String get noMobileNumber => 'No mobile number';

  @override
  String get dataNotFound => 'Data not found';

  @override
  String get dateNotFound => 'Date not found';

  @override
  String get defaultName => 'Rakib';

  @override
  String get joined => 'Joined';

  @override
  String get premiumSubscription => 'Get Premium Subscription!';

  @override
  String get premiumSubtitle =>
      'Choose subscription packages according to your needs and get great benefits';

  @override
  String get freePlanFeatures => 'Free Plan Features';

  @override
  String get subscriptionPackages => 'Subscription Packages';

  @override
  String get productsUpTo => ' products up to';

  @override
  String get customersUpTo => ' customers up to';

  @override
  String get trialPeriodDays => ' days trial period';

  @override
  String get subscriptionAdditionalInfo =>
      'Choose your subscription package and get more benefits. With our premium plan, you will get even more benefits.';

  @override
  String subscriptionExpiryNote(String startDate) {
    return 'Regular plus rate will apply from $startDate when your current offer ends.';
  }

  @override
  String get free => 'Free';

  @override
  String get basicReports => 'You can view basic reports';

  @override
  String get completeOrder => 'Complete Order';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get newOrder => 'New Order';

  @override
  String get customerInfo => 'Customer Information';

  @override
  String get optional => 'Optional';

  @override
  String get unknown => 'Unknown';

  @override
  String get discountAmount => 'Discount (৳)';

  @override
  String get dueAmountField => 'Due Amount (৳)';

  @override
  String get orderNote => 'Order Note (if any)';

  @override
  String get invoice => 'Invoice';

  @override
  String get generating => 'Generating...';

  @override
  String get confirmOrder => 'Confirm Order';

  @override
  String get localBackup => 'Local Backup';

  @override
  String get backupToLocalStorage => 'Backup to Local Storage';

  @override
  String get backupToLocalDescription =>
      'Backup files to your phone memory or USB flash drive.';

  @override
  String get restoreFromLocal => 'Restore from Local Storage';

  @override
  String get restoreFromLocalDescription =>
      'You can restore backup files from memory';

  @override
  String get lastBackup => 'Last Backup';

  @override
  String get noBackup => 'No Backup';

  @override
  String get backupPrevention =>
      'It is recommended to backup files to your PC or USB flash drive to prevent data loss.';

  @override
  String get backupStorage =>
      'If you backup files to phone memory, backup files will be saved in internal storage/backup.';

  @override
  String get sharedDevice =>
      'If you send data to a shared device, backup files will be saved on a device that cannot decrypt it.';

  @override
  String get createBackup => 'Create Backup';

  @override
  String backupInstructions(String folderName) {
    return 'To create a backup, you must have sufficient space on your phone memory and backup files will be saved in your $folderName folder in phone memory.';
  }

  @override
  String get dokandarFolder => 'Dokandar folder';

  @override
  String get backupStorageLocation => 'in phone memory.';

  @override
  String get backingUp => 'Backing up...';

  @override
  String get createNewBackup => 'Create New Backup';

  @override
  String get selectBackupFile => 'Select Backup File';

  @override
  String get selectBackupDescription =>
      'Select backup file from your phone memory.';

  @override
  String get restoreData => 'Restore Data';

  @override
  String get restoreDataDescription => 'Restore data from selected backup file';

  @override
  String get importantInfo => 'Important Information';

  @override
  String get backupBeforeRestore =>
      'Before restoring, it is recommended to backup your current data.';

  @override
  String get restoreWarning =>
      'When restoring, current data will be deleted and replaced with backup file data.';

  @override
  String get validBackupOnly =>
      'Data can only be restored from valid backup files.';

  @override
  String get restoring => 'Restoring...';

  @override
  String get restoreDataButton => 'Restore Data';

  @override
  String get currentVersion => 'Current Version';

  @override
  String get updateDate => 'Update Date';

  @override
  String get changelogDescription =>
      'What changes have been made in the latest update';

  @override
  String get developerInfoDescription => 'Who created the app';

  @override
  String get legalInfo => 'Legal Information';

  @override
  String get legalInfoDescription => 'Privacy Policy and Terms & Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get supportAndHelpTitle => 'Support and Help';

  @override
  String get howToUseApp => 'How to Use the App';

  @override
  String get gettingStarted => 'Getting Started';

  @override
  String get gettingStartedDescription =>
      'Learn the basics of our inventory management system';

  @override
  String get productManagement => 'Product Management';

  @override
  String get productManagementDescription => 'Add, edit and track products';

  @override
  String get salesAndReports => 'Sales and Reports';

  @override
  String get salesAndReportsDescription =>
      'Track sales and create detailed reports';

  @override
  String get availableModules => 'Available Modules';

  @override
  String get availableModulesDescription => 'Suitable for your business';

  @override
  String get inventoryManagement => 'Inventory Management';

  @override
  String get inventoryManagementDescription => 'Track and manage stock levels';

  @override
  String get salesTracking => 'Sales Tracking';

  @override
  String get salesTrackingDescription => 'Monitor sales and revenue';

  @override
  String get customerManagement => 'Customer Management';

  @override
  String get customerManagementDescription =>
      'Manage customer information and orders';

  @override
  String get reportsAndAnalytics => 'Reports and Analytics';

  @override
  String get reportsAndAnalyticsDescription =>
      'Create detailed business insights';

  @override
  String get videoTutorials => 'Video Tutorials';

  @override
  String get videoTutorialsDescription => 'Learn and gain expertise';

  @override
  String get gettingStartedGuide => 'Getting Started Guide';

  @override
  String get someTipsToGetStarted => 'Some tips to get started';

  @override
  String get learnBasicIn5Minutes => 'Learn basic in 5 minutes';

  @override
  String get advancedFeatures => 'Advanced Features';

  @override
  String get masterAdvancedFeatures => 'Master advanced features';

  @override
  String get giveFeedback => 'Give Your Feedback';

  @override
  String get feedbackDescription =>
      'Your valuable feedback for our improvement';

  @override
  String get feedbackCategories => 'Feedback Categories';

  @override
  String get feedbackCategoriesDescription =>
      'What type of feedback would you like to give?';

  @override
  String get bugReport => 'Bug Report';

  @override
  String get bugReportDescription => 'Found any issues in the app?';

  @override
  String get featureRequest => 'Feature Request';

  @override
  String get featureRequestDescription => 'Want any new features?';

  @override
  String get generalFeedback => 'General Feedback';

  @override
  String get generalFeedbackDescription => 'Share your experience';

  @override
  String get recentFeedback => 'Recent Feedback';

  @override
  String get recentFeedbackDescription => 'Feedback from other users';

  @override
  String get appIsGreat => 'App is great';

  @override
  String get appIsGreatDescription =>
      'My business has improved a lot using this app';

  @override
  String get someIssues => 'Some issues';

  @override
  String get someIssuesDescription => 'Sometimes the app becomes slow';

  @override
  String get veryHelpful => 'Very helpful';

  @override
  String get veryHelpfulDescription => 'Support team responds very quickly';

  @override
  String get writeYourFeedback => 'Write Your Feedback';

  @override
  String get writeYourValuableFeedbackHint => 'Write your valuable feedback...';

  @override
  String get rating => 'Rating:';

  @override
  String get submit => 'Submit';

  @override
  String get sampleUserName1 => 'Rahim Ali';

  @override
  String get sampleUserName2 => 'Karim Ahmed';

  @override
  String get sampleUserName3 => 'Fatema Begum';

  @override
  String get sampleUserName4 => 'Zahid Hasan';

  @override
  String get newFeaturesNeeded => 'New Features Needed';

  @override
  String get needToAddNewFeatures => 'Need to add some new features to the app';

  @override
  String get customerHasDue => 'Customer has due';

  @override
  String get customerNoDue => 'Customer has no due';

  @override
  String get lastPurchase => 'Last Purchase';

  @override
  String get deleteCustomer => 'Delete Customer';

  @override
  String get confirmDeleteCustomer =>
      'Are you sure you want to delete this customer?';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get add => 'Add';

  @override
  String stockInPieces(String quantity) {
    return 'Stock: $quantity pieces';
  }

  @override
  String get stock => 'Stock';

  @override
  String get pieces => 'pieces';

  @override
  String serviceInitFailed(String error) {
    return 'Failed to initialize service: $error';
  }

  @override
  String get backupSuccess => 'Backup successful!';

  @override
  String backupFailed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get restoreSuccess => 'Restore successful!';

  @override
  String restoreFailed(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get failedToLoadDueCustomers => 'Failed to load due customers list';

  @override
  String get paymentUpdated => 'Payment updated';

  @override
  String get failedToUpdatePayment => 'Failed to update payment';

  @override
  String lastBackupDate(String date) {
    return 'Last backup $date';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get autoBackup => 'Auto Backup';

  @override
  String get enableAutoBackup => 'Enable Auto Backup';

  @override
  String get soundSettings => 'Sound Settings';

  @override
  String get enableSound => 'Enable Sound';

  @override
  String get vibration => 'Vibration';

  @override
  String get enableVibration => 'Enable Vibration';

  @override
  String get fontSize => 'Font Size';

  @override
  String get selectFontSize => 'Select Font Size';

  @override
  String get currency => 'Currency';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get dateFormat => 'Date Format';

  @override
  String get selectDateFormat => 'Select Date Format';

  @override
  String get timeFormat => 'Time Format';

  @override
  String get selectTimeFormat => 'Select Time Format';

  @override
  String get pageSize => 'Page Size';

  @override
  String get selectPageSize => 'Select Page Size';

  @override
  String get cacheDuration => 'Cache Duration';

  @override
  String get selectCacheDuration => 'Select Cache Duration';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get clearCacheDescription => 'Clear all cached data';

  @override
  String get cacheCleared => 'Cache cleared successfully';

  @override
  String get resetSettings => 'Reset Settings';

  @override
  String get resetSettingsDescription => 'Reset all settings to default';

  @override
  String get resetSettingsConfirm =>
      'Are you sure you want to reset all settings to default?';

  @override
  String get settingsReset => 'Settings reset successfully';

  @override
  String get small => 'Small';

  @override
  String get medium => 'Medium';

  @override
  String get large => 'Large';

  @override
  String get extraLarge => 'Extra Large';

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hour(s)';

  @override
  String get itemsPerPage => 'items per page';

  @override
  String get appLockTitle => 'App Lock';

  @override
  String get appLockSubtitle => 'Set PIN lock';

  @override
  String get enterPinToContinue => 'Enter your PIN to continue';

  @override
  String get invalidPinMessage => 'Invalid PIN, please try again';

  @override
  String get appLockEnabled => 'App lock is enabled';

  @override
  String get appLockDisabled => 'Protect your app with a PIN';

  @override
  String get setPin => 'Set PIN';

  @override
  String get changePin => 'Change PIN';

  @override
  String get currentPin => 'Current PIN';

  @override
  String get newPin => 'New PIN';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get saving => 'Saving...';

  @override
  String get enableAppLockButton => 'Enable App Lock';

  @override
  String get updatePinButton => 'Update PIN';

  @override
  String get disableAppLockButton => 'Disable App Lock';

  @override
  String get genericError => 'Something went wrong';

  @override
  String get pinEnabledSuccess => 'PIN enabled successfully';

  @override
  String get pinUpdatedSuccess => 'PIN updated successfully';

  @override
  String get pinDisabledSuccess => 'PIN lock disabled';

  @override
  String get oldPinIncorrect => 'Current PIN is incorrect';

  @override
  String pinLengthError(int min, int max) {
    return 'PIN must be between $min and $max digits';
  }

  @override
  String get pinMismatch => 'PIN and confirmation do not match';

  @override
  String get addSupplier => 'Add Supplier';

  @override
  String get editSupplier => 'Edit Supplier';

  @override
  String get deleteSupplier => 'Delete Supplier';

  @override
  String get confirmDeleteSupplier =>
      'Are you sure you want to delete this supplier?';

  @override
  String get supplierInfo => 'Supplier Information';

  @override
  String get supplierAdded => 'Supplier added successfully';

  @override
  String get supplierUpdated => 'Supplier updated successfully';

  @override
  String get supplierDeleted => 'Supplier deleted successfully';

  @override
  String get noSuppliers => 'No suppliers found';

  @override
  String get company => 'Company';

  @override
  String get totalPurchase => 'Total Purchase';

  @override
  String get totalPaid => 'Total Paid';

  @override
  String get recordPayment => 'Record Payment';

  @override
  String get paymentAmount => 'Payment Amount';

  @override
  String get paymentRecorded => 'Payment recorded successfully';

  @override
  String get supplierHasDue => 'Has due amount';

  @override
  String get supplierNoDue => 'No due';

  @override
  String get searchSuppliers => 'Search suppliers...';

  @override
  String get totalSuppliers => 'Total Suppliers';

  @override
  String get supplierNameRequired => 'Supplier name is required';
}
