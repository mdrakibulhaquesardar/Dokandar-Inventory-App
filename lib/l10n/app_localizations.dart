import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'Dokandar'**
  String get appName;

  /// Application description
  ///
  /// In en, this message translates to:
  /// **'Inventory Management System'**
  String get appDescription;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// About app screen title
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// Subscription screen title
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// Products label
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Customers label
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// Sales label
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// Inventory label
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// Add product button text
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// Add customer button text
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomer;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Price field label
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// Quantity field label
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// Phone field label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Address field label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Total label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Subtotal label
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Discount label
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// Due amount label
  ///
  /// In en, this message translates to:
  /// **'Due Amount'**
  String get dueAmount;

  /// Paid amount label
  ///
  /// In en, this message translates to:
  /// **'Paid Amount'**
  String get paidAmount;

  /// Low stock warning
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get lowStock;

  /// Out of stock warning
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// Success message
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No data message
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// Developer information section title
  ///
  /// In en, this message translates to:
  /// **'Developer Information'**
  String get developerInfo;

  /// App information section title
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInfo;

  /// No description provided for @currentVersionAndDescription.
  ///
  /// In en, this message translates to:
  /// **'Current version and description'**
  String get currentVersionAndDescription;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// Changelog section title
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get changelog;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Last update label
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get lastUpdate;

  /// App size label
  ///
  /// In en, this message translates to:
  /// **'App Size'**
  String get appSize;

  /// Free plan label
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlan;

  /// Current plan label
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// Upgrade button text
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// Buy now button text
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// Trial period label
  ///
  /// In en, this message translates to:
  /// **'Trial Period'**
  String get trialPeriod;

  /// Days count
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String days(int count);

  /// Products limit message
  ///
  /// In en, this message translates to:
  /// **'You can add up to {count} products'**
  String productsLimit(int count);

  /// Customers limit message
  ///
  /// In en, this message translates to:
  /// **'You can add up to {count} customers'**
  String customersLimit(int count);

  /// Limit reached message
  ///
  /// In en, this message translates to:
  /// **'Limit Reached'**
  String get limitReached;

  /// Please upgrade message
  ///
  /// In en, this message translates to:
  /// **'Please upgrade to add more'**
  String get pleaseUpgrade;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @summaryInfo.
  ///
  /// In en, this message translates to:
  /// **'Summary Information'**
  String get summaryInfo;

  /// No description provided for @summaryInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'View summary information and related details'**
  String get summaryInfoDescription;

  /// No description provided for @totalProducts.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get totalProducts;

  /// No description provided for @totalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get totalSales;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @todaysOrders.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Orders'**
  String get todaysOrders;

  /// No description provided for @totalProfit.
  ///
  /// In en, this message translates to:
  /// **'Total Profit'**
  String get totalProfit;

  /// No description provided for @recentSales.
  ///
  /// In en, this message translates to:
  /// **'Recent Sales'**
  String get recentSales;

  /// No description provided for @recentSalesDescription.
  ///
  /// In en, this message translates to:
  /// **'View recent sales list and transactions'**
  String get recentSalesDescription;

  /// No description provided for @stockAlert.
  ///
  /// In en, this message translates to:
  /// **'Stock Alert'**
  String get stockAlert;

  /// No description provided for @stockAlertDescription.
  ///
  /// In en, this message translates to:
  /// **'Some products are running low on stock, 3 days before stock runs out'**
  String get stockAlertDescription;

  /// No description provided for @noRecentSales.
  ///
  /// In en, this message translates to:
  /// **'No recent sales'**
  String get noRecentSales;

  /// No description provided for @addToStock.
  ///
  /// In en, this message translates to:
  /// **'Add to Stock'**
  String get addToStock;

  /// No description provided for @searchProducts.
  ///
  /// In en, this message translates to:
  /// **'Search Products'**
  String get searchProducts;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @quickAccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Use the options below to quickly access your inventory'**
  String get quickAccessDescription;

  /// No description provided for @allProducts.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get allProducts;

  /// No description provided for @salesHistory.
  ///
  /// In en, this message translates to:
  /// **'Sales History'**
  String get salesHistory;

  /// No description provided for @allCustomers.
  ///
  /// In en, this message translates to:
  /// **'All Customers'**
  String get allCustomers;

  /// No description provided for @allSuppliers.
  ///
  /// In en, this message translates to:
  /// **'All Suppliers'**
  String get allSuppliers;

  /// No description provided for @storeExpenses.
  ///
  /// In en, this message translates to:
  /// **'Store Expenses'**
  String get storeExpenses;

  /// No description provided for @allEmployees.
  ///
  /// In en, this message translates to:
  /// **'All Employees'**
  String get allEmployees;

  /// No description provided for @otherFunctions.
  ///
  /// In en, this message translates to:
  /// **'Other Functions'**
  String get otherFunctions;

  /// No description provided for @otherFunctionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Use other functions for your inventory'**
  String get otherFunctionsDescription;

  /// No description provided for @duePayment.
  ///
  /// In en, this message translates to:
  /// **'Due Payment'**
  String get duePayment;

  /// No description provided for @productCategories.
  ///
  /// In en, this message translates to:
  /// **'Product Categories'**
  String get productCategories;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @supplierManagement.
  ///
  /// In en, this message translates to:
  /// **'Supplier Management'**
  String get supplierManagement;

  /// No description provided for @generateReport.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get generateReport;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @sellCounter.
  ///
  /// In en, this message translates to:
  /// **'Sales Counter'**
  String get sellCounter;

  /// No description provided for @searchProduct.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProduct;

  /// Total products count
  ///
  /// In en, this message translates to:
  /// **'Total Products: {count}'**
  String totalProductsCount(int count);

  /// No description provided for @completeSale.
  ///
  /// In en, this message translates to:
  /// **'Complete Sale'**
  String get completeSale;

  /// No description provided for @noProductsAdded.
  ///
  /// In en, this message translates to:
  /// **'No products added'**
  String get noProductsAdded;

  /// No description provided for @salesCounter.
  ///
  /// In en, this message translates to:
  /// **'Sales Counter'**
  String get salesCounter;

  /// No description provided for @yourProducts.
  ///
  /// In en, this message translates to:
  /// **'Your Products'**
  String get yourProducts;

  /// No description provided for @stockOut.
  ///
  /// In en, this message translates to:
  /// **'Stock Out'**
  String get stockOut;

  /// No description provided for @recentProducts.
  ///
  /// In en, this message translates to:
  /// **'Recent Products'**
  String get recentProducts;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @stockQuantity.
  ///
  /// In en, this message translates to:
  /// **'Stock Quantity'**
  String get stockQuantity;

  /// No description provided for @sellingPrice.
  ///
  /// In en, this message translates to:
  /// **'Selling Price'**
  String get sellingPrice;

  /// No description provided for @buyingPrice.
  ///
  /// In en, this message translates to:
  /// **'Buying Price'**
  String get buyingPrice;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @unitProfit.
  ///
  /// In en, this message translates to:
  /// **'Unit Profit'**
  String get unitProfit;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// No description provided for @confirmDeleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product?'**
  String get confirmDeleteProduct;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get yesDelete;

  /// No description provided for @addNewProduct.
  ///
  /// In en, this message translates to:
  /// **'Add New Product'**
  String get addNewProduct;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @customerList.
  ///
  /// In en, this message translates to:
  /// **'Customer List'**
  String get customerList;

  /// No description provided for @totalCustomers.
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get totalCustomers;

  /// No description provided for @newCustomers.
  ///
  /// In en, this message translates to:
  /// **'New Customers'**
  String get newCustomers;

  /// No description provided for @totalDue.
  ///
  /// In en, this message translates to:
  /// **'Total Due'**
  String get totalDue;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @customerPhone.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone'**
  String get customerPhone;

  /// No description provided for @customerAddress.
  ///
  /// In en, this message translates to:
  /// **'Customer Address'**
  String get customerAddress;

  /// No description provided for @totalPurchases.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases'**
  String get totalPurchases;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @salesList.
  ///
  /// In en, this message translates to:
  /// **'Sales List'**
  String get salesList;

  /// No description provided for @totalTransactions.
  ///
  /// In en, this message translates to:
  /// **'Total Transactions'**
  String get totalTransactions;

  /// No description provided for @noSales.
  ///
  /// In en, this message translates to:
  /// **'No Sales'**
  String get noSales;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get invoiceNumber;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @saleDetails.
  ///
  /// In en, this message translates to:
  /// **'Sale Details'**
  String get saleDetails;

  /// No description provided for @productList.
  ///
  /// In en, this message translates to:
  /// **'Product List'**
  String get productList;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @dueCustomersList.
  ///
  /// In en, this message translates to:
  /// **'Due Customers List'**
  String get dueCustomersList;

  /// No description provided for @totalDueCustomers.
  ///
  /// In en, this message translates to:
  /// **'Total Due Customers'**
  String get totalDueCustomers;

  /// No description provided for @noDueCustomers.
  ///
  /// In en, this message translates to:
  /// **'No Due Customers'**
  String get noDueCustomers;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'people'**
  String get people;

  /// No description provided for @payDue.
  ///
  /// In en, this message translates to:
  /// **'Pay Due'**
  String get payDue;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @yourCategories.
  ///
  /// In en, this message translates to:
  /// **'Your Categories'**
  String get yourCategories;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @userSetup.
  ///
  /// In en, this message translates to:
  /// **'User Setup'**
  String get userSetup;

  /// No description provided for @step1of2.
  ///
  /// In en, this message translates to:
  /// **'Step 1/2'**
  String get step1of2;

  /// No description provided for @step2of2.
  ///
  /// In en, this message translates to:
  /// **'Step 2/2'**
  String get step2of2;

  /// No description provided for @step3of3.
  ///
  /// In en, this message translates to:
  /// **'Step 3/3'**
  String get step3of3;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @provideRequiredInfo.
  ///
  /// In en, this message translates to:
  /// **'Provide the necessary information to manage your business'**
  String get provideRequiredInfo;

  /// No description provided for @userInformation.
  ///
  /// In en, this message translates to:
  /// **'User Information'**
  String get userInformation;

  /// No description provided for @setupProfileAndProvideInfo.
  ///
  /// In en, this message translates to:
  /// **'Set up your profile and provide necessary information for your business'**
  String get setupProfileAndProvideInfo;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmail;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @enterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enterYourAddress;

  /// No description provided for @goToNextStep.
  ///
  /// In en, this message translates to:
  /// **'Go to Next Step'**
  String get goToNextStep;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeProfile;

  /// No description provided for @completeProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Provide necessary information to manage your business'**
  String get completeProfileDescription;

  /// No description provided for @userInfo.
  ///
  /// In en, this message translates to:
  /// **'User Information'**
  String get userInfo;

  /// No description provided for @userInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Set up your profile and provide information for your business'**
  String get userInfoDescription;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailAddress;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get mobileNumber;

  /// No description provided for @yourAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get yourAddress;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Go to Next Step'**
  String get nextStep;

  /// No description provided for @pinCodeSetup.
  ///
  /// In en, this message translates to:
  /// **'You can optionally set up the PIN code next'**
  String get pinCodeSetup;

  /// No description provided for @storeSetup.
  ///
  /// In en, this message translates to:
  /// **'Store Setup'**
  String get storeSetup;

  /// No description provided for @addStoreLogo.
  ///
  /// In en, this message translates to:
  /// **'Add Store Logo'**
  String get addStoreLogo;

  /// No description provided for @storeInfo.
  ///
  /// In en, this message translates to:
  /// **'Store Information'**
  String get storeInfo;

  /// No description provided for @storeInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your store information'**
  String get storeInfoDescription;

  /// No description provided for @storeName.
  ///
  /// In en, this message translates to:
  /// **'Store Name'**
  String get storeName;

  /// No description provided for @storeNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter store name'**
  String get storeNameRequired;

  /// No description provided for @addressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter address'**
  String get addressRequired;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get phoneNumberRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get emailRequired;

  /// No description provided for @validEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get validEmailRequired;

  /// No description provided for @businessType.
  ///
  /// In en, this message translates to:
  /// **'Business Type'**
  String get businessType;

  /// No description provided for @businessTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter business type'**
  String get businessTypeRequired;

  /// No description provided for @retailer.
  ///
  /// In en, this message translates to:
  /// **'Retailer'**
  String get retailer;

  /// No description provided for @wholesaler.
  ///
  /// In en, this message translates to:
  /// **'Wholesaler'**
  String get wholesaler;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @pharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get pharmacy;

  /// No description provided for @fashionStore.
  ///
  /// In en, this message translates to:
  /// **'Fashion Store'**
  String get fashionStore;

  /// No description provided for @electronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @storeInfoNote.
  ///
  /// In en, this message translates to:
  /// **'Please enter your store information correctly. This information is important for your business.'**
  String get storeInfoNote;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @improveStoreManagement.
  ///
  /// In en, this message translates to:
  /// **'Improve Your Store Management'**
  String get improveStoreManagement;

  /// No description provided for @startWithPowerfulTool.
  ///
  /// In en, this message translates to:
  /// **'Start managing your store with our powerful store management tool.'**
  String get startWithPowerfulTool;

  /// No description provided for @trackAllActivities.
  ///
  /// In en, this message translates to:
  /// **'Track All Your Store Activities'**
  String get trackAllActivities;

  /// No description provided for @trackActivitiesDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage inventory, sales, and transactions in one convenient place.'**
  String get trackActivitiesDescription;

  /// No description provided for @smartBusinessInsights.
  ///
  /// In en, this message translates to:
  /// **'Smart Business Insights'**
  String get smartBusinessInsights;

  /// No description provided for @smartInsightsDescription.
  ///
  /// In en, this message translates to:
  /// **'Get detailed reports and analytics to make informed decisions.'**
  String get smartInsightsDescription;

  /// No description provided for @secureAndPrivate.
  ///
  /// In en, this message translates to:
  /// **'Secure and Private'**
  String get secureAndPrivate;

  /// No description provided for @secureDescription.
  ///
  /// In en, this message translates to:
  /// **'Your store information is secure and accessible only to you.'**
  String get secureDescription;

  /// No description provided for @startManagingStore.
  ///
  /// In en, this message translates to:
  /// **'Start Managing Your Store'**
  String get startManagingStore;

  /// No description provided for @startWithTool.
  ///
  /// In en, this message translates to:
  /// **'Start with our powerful store management tool'**
  String get startWithTool;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @customizeAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Customize your app settings'**
  String get customizeAppSettings;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @dataBackup.
  ///
  /// In en, this message translates to:
  /// **'Data Backup'**
  String get dataBackup;

  /// No description provided for @dataRestore.
  ///
  /// In en, this message translates to:
  /// **'Data Restore'**
  String get dataRestore;

  /// No description provided for @storeSettings.
  ///
  /// In en, this message translates to:
  /// **'Store Settings'**
  String get storeSettings;

  /// No description provided for @dokandarSubscription.
  ///
  /// In en, this message translates to:
  /// **'Dokandar Subscription'**
  String get dokandarSubscription;

  /// No description provided for @supportAndHelp.
  ///
  /// In en, this message translates to:
  /// **'Support and Help'**
  String get supportAndHelp;

  /// No description provided for @supportCenter.
  ///
  /// In en, this message translates to:
  /// **'Support Center'**
  String get supportCenter;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @joinDate.
  ///
  /// In en, this message translates to:
  /// **'Join Date'**
  String get joinDate;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @noMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'No mobile number'**
  String get noMobileNumber;

  /// No description provided for @dataNotFound.
  ///
  /// In en, this message translates to:
  /// **'Data not found'**
  String get dataNotFound;

  /// No description provided for @dateNotFound.
  ///
  /// In en, this message translates to:
  /// **'Date not found'**
  String get dateNotFound;

  /// No description provided for @defaultName.
  ///
  /// In en, this message translates to:
  /// **'Rakib'**
  String get defaultName;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @premiumSubscription.
  ///
  /// In en, this message translates to:
  /// **'Get Premium Subscription!'**
  String get premiumSubscription;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose subscription packages according to your needs and get great benefits'**
  String get premiumSubtitle;

  /// No description provided for @freePlanFeatures.
  ///
  /// In en, this message translates to:
  /// **'Free Plan Features'**
  String get freePlanFeatures;

  /// No description provided for @subscriptionPackages.
  ///
  /// In en, this message translates to:
  /// **'Subscription Packages'**
  String get subscriptionPackages;

  /// No description provided for @productsUpTo.
  ///
  /// In en, this message translates to:
  /// **' products up to'**
  String get productsUpTo;

  /// No description provided for @customersUpTo.
  ///
  /// In en, this message translates to:
  /// **' customers up to'**
  String get customersUpTo;

  /// No description provided for @trialPeriodDays.
  ///
  /// In en, this message translates to:
  /// **' days trial period'**
  String get trialPeriodDays;

  /// No description provided for @subscriptionAdditionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Choose your subscription package and get more benefits. With our premium plan, you will get even more benefits.'**
  String get subscriptionAdditionalInfo;

  /// No description provided for @subscriptionExpiryNote.
  ///
  /// In en, this message translates to:
  /// **'Regular plus rate will apply from {startDate} when your current offer ends.'**
  String subscriptionExpiryNote(String startDate);

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @basicReports.
  ///
  /// In en, this message translates to:
  /// **'You can view basic reports'**
  String get basicReports;

  /// No description provided for @completeOrder.
  ///
  /// In en, this message translates to:
  /// **'Complete Order'**
  String get completeOrder;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New Order'**
  String get newOrder;

  /// No description provided for @customerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInfo;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @discountAmount.
  ///
  /// In en, this message translates to:
  /// **'Discount (৳)'**
  String get discountAmount;

  /// No description provided for @dueAmountField.
  ///
  /// In en, this message translates to:
  /// **'Due Amount (৳)'**
  String get dueAmountField;

  /// No description provided for @orderNote.
  ///
  /// In en, this message translates to:
  /// **'Order Note (if any)'**
  String get orderNote;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @localBackup.
  ///
  /// In en, this message translates to:
  /// **'Local Backup'**
  String get localBackup;

  /// No description provided for @backupToLocalStorage.
  ///
  /// In en, this message translates to:
  /// **'Backup to Local Storage'**
  String get backupToLocalStorage;

  /// No description provided for @backupToLocalDescription.
  ///
  /// In en, this message translates to:
  /// **'Backup files to your phone memory or USB flash drive.'**
  String get backupToLocalDescription;

  /// No description provided for @restoreFromLocal.
  ///
  /// In en, this message translates to:
  /// **'Restore from Local Storage'**
  String get restoreFromLocal;

  /// No description provided for @restoreFromLocalDescription.
  ///
  /// In en, this message translates to:
  /// **'You can restore backup files from memory'**
  String get restoreFromLocalDescription;

  /// No description provided for @lastBackup.
  ///
  /// In en, this message translates to:
  /// **'Last Backup'**
  String get lastBackup;

  /// No description provided for @noBackup.
  ///
  /// In en, this message translates to:
  /// **'No Backup'**
  String get noBackup;

  /// No description provided for @backupPrevention.
  ///
  /// In en, this message translates to:
  /// **'It is recommended to backup files to your PC or USB flash drive to prevent data loss.'**
  String get backupPrevention;

  /// No description provided for @backupStorage.
  ///
  /// In en, this message translates to:
  /// **'If you backup files to phone memory, backup files will be saved in internal storage/backup.'**
  String get backupStorage;

  /// No description provided for @sharedDevice.
  ///
  /// In en, this message translates to:
  /// **'If you send data to a shared device, backup files will be saved on a device that cannot decrypt it.'**
  String get sharedDevice;

  /// No description provided for @createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create Backup'**
  String get createBackup;

  /// Backup instructions
  ///
  /// In en, this message translates to:
  /// **'To create a backup, you must have sufficient space on your phone memory and backup files will be saved in your {folderName} folder in phone memory.'**
  String backupInstructions(String folderName);

  /// No description provided for @dokandarFolder.
  ///
  /// In en, this message translates to:
  /// **'Dokandar folder'**
  String get dokandarFolder;

  /// No description provided for @backupStorageLocation.
  ///
  /// In en, this message translates to:
  /// **'in phone memory.'**
  String get backupStorageLocation;

  /// No description provided for @backingUp.
  ///
  /// In en, this message translates to:
  /// **'Backing up...'**
  String get backingUp;

  /// No description provided for @createNewBackup.
  ///
  /// In en, this message translates to:
  /// **'Create New Backup'**
  String get createNewBackup;

  /// No description provided for @selectBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Select Backup File'**
  String get selectBackupFile;

  /// No description provided for @selectBackupDescription.
  ///
  /// In en, this message translates to:
  /// **'Select backup file from your phone memory.'**
  String get selectBackupDescription;

  /// No description provided for @restoreData.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreData;

  /// No description provided for @restoreDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Restore data from selected backup file'**
  String get restoreDataDescription;

  /// No description provided for @importantInfo.
  ///
  /// In en, this message translates to:
  /// **'Important Information'**
  String get importantInfo;

  /// No description provided for @backupBeforeRestore.
  ///
  /// In en, this message translates to:
  /// **'Before restoring, it is recommended to backup your current data.'**
  String get backupBeforeRestore;

  /// No description provided for @restoreWarning.
  ///
  /// In en, this message translates to:
  /// **'When restoring, current data will be deleted and replaced with backup file data.'**
  String get restoreWarning;

  /// No description provided for @validBackupOnly.
  ///
  /// In en, this message translates to:
  /// **'Data can only be restored from valid backup files.'**
  String get validBackupOnly;

  /// No description provided for @restoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring...'**
  String get restoring;

  /// No description provided for @restoreDataButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreDataButton;

  /// No description provided for @currentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current Version'**
  String get currentVersion;

  /// No description provided for @updateDate.
  ///
  /// In en, this message translates to:
  /// **'Update Date'**
  String get updateDate;

  /// No description provided for @changelogDescription.
  ///
  /// In en, this message translates to:
  /// **'What changes have been made in the latest update'**
  String get changelogDescription;

  /// No description provided for @developerInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Who created the app'**
  String get developerInfoDescription;

  /// No description provided for @legalInfo.
  ///
  /// In en, this message translates to:
  /// **'Legal Information'**
  String get legalInfo;

  /// No description provided for @legalInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy and Terms & Conditions'**
  String get legalInfoDescription;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @supportAndHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Support and Help'**
  String get supportAndHelpTitle;

  /// No description provided for @howToUseApp.
  ///
  /// In en, this message translates to:
  /// **'How to Use the App'**
  String get howToUseApp;

  /// No description provided for @gettingStarted.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get gettingStarted;

  /// No description provided for @gettingStartedDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn the basics of our inventory management system'**
  String get gettingStartedDescription;

  /// No description provided for @productManagement.
  ///
  /// In en, this message translates to:
  /// **'Product Management'**
  String get productManagement;

  /// No description provided for @productManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Add, edit and track products'**
  String get productManagementDescription;

  /// No description provided for @salesAndReports.
  ///
  /// In en, this message translates to:
  /// **'Sales and Reports'**
  String get salesAndReports;

  /// No description provided for @salesAndReportsDescription.
  ///
  /// In en, this message translates to:
  /// **'Track sales and create detailed reports'**
  String get salesAndReportsDescription;

  /// No description provided for @availableModules.
  ///
  /// In en, this message translates to:
  /// **'Available Modules'**
  String get availableModules;

  /// No description provided for @availableModulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Suitable for your business'**
  String get availableModulesDescription;

  /// No description provided for @inventoryManagement.
  ///
  /// In en, this message translates to:
  /// **'Inventory Management'**
  String get inventoryManagement;

  /// No description provided for @inventoryManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Track and manage stock levels'**
  String get inventoryManagementDescription;

  /// No description provided for @salesTracking.
  ///
  /// In en, this message translates to:
  /// **'Sales Tracking'**
  String get salesTracking;

  /// No description provided for @salesTrackingDescription.
  ///
  /// In en, this message translates to:
  /// **'Monitor sales and revenue'**
  String get salesTrackingDescription;

  /// No description provided for @customerManagement.
  ///
  /// In en, this message translates to:
  /// **'Customer Management'**
  String get customerManagement;

  /// No description provided for @customerManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage customer information and orders'**
  String get customerManagementDescription;

  /// No description provided for @reportsAndAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Reports and Analytics'**
  String get reportsAndAnalytics;

  /// No description provided for @reportsAndAnalyticsDescription.
  ///
  /// In en, this message translates to:
  /// **'Create detailed business insights'**
  String get reportsAndAnalyticsDescription;

  /// No description provided for @videoTutorials.
  ///
  /// In en, this message translates to:
  /// **'Video Tutorials'**
  String get videoTutorials;

  /// No description provided for @videoTutorialsDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn and gain expertise'**
  String get videoTutorialsDescription;

  /// No description provided for @gettingStartedGuide.
  ///
  /// In en, this message translates to:
  /// **'Getting Started Guide'**
  String get gettingStartedGuide;

  /// No description provided for @someTipsToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Some tips to get started'**
  String get someTipsToGetStarted;

  /// No description provided for @learnBasicIn5Minutes.
  ///
  /// In en, this message translates to:
  /// **'Learn basic in 5 minutes'**
  String get learnBasicIn5Minutes;

  /// No description provided for @advancedFeatures.
  ///
  /// In en, this message translates to:
  /// **'Advanced Features'**
  String get advancedFeatures;

  /// No description provided for @masterAdvancedFeatures.
  ///
  /// In en, this message translates to:
  /// **'Master advanced features'**
  String get masterAdvancedFeatures;

  /// No description provided for @giveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Give Your Feedback'**
  String get giveFeedback;

  /// No description provided for @feedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'Your valuable feedback for our improvement'**
  String get feedbackDescription;

  /// No description provided for @feedbackCategories.
  ///
  /// In en, this message translates to:
  /// **'Feedback Categories'**
  String get feedbackCategories;

  /// No description provided for @feedbackCategoriesDescription.
  ///
  /// In en, this message translates to:
  /// **'What type of feedback would you like to give?'**
  String get feedbackCategoriesDescription;

  /// No description provided for @bugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReport;

  /// No description provided for @bugReportDescription.
  ///
  /// In en, this message translates to:
  /// **'Found any issues in the app?'**
  String get bugReportDescription;

  /// No description provided for @featureRequest.
  ///
  /// In en, this message translates to:
  /// **'Feature Request'**
  String get featureRequest;

  /// No description provided for @featureRequestDescription.
  ///
  /// In en, this message translates to:
  /// **'Want any new features?'**
  String get featureRequestDescription;

  /// No description provided for @generalFeedback.
  ///
  /// In en, this message translates to:
  /// **'General Feedback'**
  String get generalFeedback;

  /// No description provided for @generalFeedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your experience'**
  String get generalFeedbackDescription;

  /// No description provided for @recentFeedback.
  ///
  /// In en, this message translates to:
  /// **'Recent Feedback'**
  String get recentFeedback;

  /// No description provided for @recentFeedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'Feedback from other users'**
  String get recentFeedbackDescription;

  /// No description provided for @appIsGreat.
  ///
  /// In en, this message translates to:
  /// **'App is great'**
  String get appIsGreat;

  /// No description provided for @appIsGreatDescription.
  ///
  /// In en, this message translates to:
  /// **'My business has improved a lot using this app'**
  String get appIsGreatDescription;

  /// No description provided for @someIssues.
  ///
  /// In en, this message translates to:
  /// **'Some issues'**
  String get someIssues;

  /// No description provided for @someIssuesDescription.
  ///
  /// In en, this message translates to:
  /// **'Sometimes the app becomes slow'**
  String get someIssuesDescription;

  /// No description provided for @veryHelpful.
  ///
  /// In en, this message translates to:
  /// **'Very helpful'**
  String get veryHelpful;

  /// No description provided for @veryHelpfulDescription.
  ///
  /// In en, this message translates to:
  /// **'Support team responds very quickly'**
  String get veryHelpfulDescription;

  /// No description provided for @writeYourFeedback.
  ///
  /// In en, this message translates to:
  /// **'Write Your Feedback'**
  String get writeYourFeedback;

  /// No description provided for @writeYourValuableFeedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Write your valuable feedback...'**
  String get writeYourValuableFeedbackHint;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating:'**
  String get rating;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @sampleUserName1.
  ///
  /// In en, this message translates to:
  /// **'Rahim Ali'**
  String get sampleUserName1;

  /// No description provided for @sampleUserName2.
  ///
  /// In en, this message translates to:
  /// **'Karim Ahmed'**
  String get sampleUserName2;

  /// No description provided for @sampleUserName3.
  ///
  /// In en, this message translates to:
  /// **'Fatema Begum'**
  String get sampleUserName3;

  /// No description provided for @sampleUserName4.
  ///
  /// In en, this message translates to:
  /// **'Zahid Hasan'**
  String get sampleUserName4;

  /// No description provided for @newFeaturesNeeded.
  ///
  /// In en, this message translates to:
  /// **'New Features Needed'**
  String get newFeaturesNeeded;

  /// No description provided for @needToAddNewFeatures.
  ///
  /// In en, this message translates to:
  /// **'Need to add some new features to the app'**
  String get needToAddNewFeatures;

  /// No description provided for @customerHasDue.
  ///
  /// In en, this message translates to:
  /// **'Customer has due'**
  String get customerHasDue;

  /// No description provided for @customerNoDue.
  ///
  /// In en, this message translates to:
  /// **'Customer has no due'**
  String get customerNoDue;

  /// No description provided for @lastPurchase.
  ///
  /// In en, this message translates to:
  /// **'Last Purchase'**
  String get lastPurchase;

  /// No description provided for @deleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'Delete Customer'**
  String get deleteCustomer;

  /// No description provided for @confirmDeleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this customer?'**
  String get confirmDeleteCustomer;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get nameRequired;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Stock quantity in pieces
  ///
  /// In en, this message translates to:
  /// **'Stock: {quantity} pieces'**
  String stockInPieces(String quantity);

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @pieces.
  ///
  /// In en, this message translates to:
  /// **'pieces'**
  String get pieces;

  /// Service initialization failed
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize service: {error}'**
  String serviceInitFailed(String error);

  /// No description provided for @backupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup successful!'**
  String get backupSuccess;

  /// Backup failed
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String backupFailed(String error);

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restore successful!'**
  String get restoreSuccess;

  /// Restore failed
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String restoreFailed(String error);

  /// No description provided for @failedToLoadDueCustomers.
  ///
  /// In en, this message translates to:
  /// **'Failed to load due customers list'**
  String get failedToLoadDueCustomers;

  /// No description provided for @paymentUpdated.
  ///
  /// In en, this message translates to:
  /// **'Payment updated'**
  String get paymentUpdated;

  /// No description provided for @failedToUpdatePayment.
  ///
  /// In en, this message translates to:
  /// **'Failed to update payment'**
  String get failedToUpdatePayment;

  /// Last backup date
  ///
  /// In en, this message translates to:
  /// **'Last backup {date}'**
  String lastBackupDate(String date);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @autoBackup.
  ///
  /// In en, this message translates to:
  /// **'Auto Backup'**
  String get autoBackup;

  /// No description provided for @enableAutoBackup.
  ///
  /// In en, this message translates to:
  /// **'Enable Auto Backup'**
  String get enableAutoBackup;

  /// No description provided for @soundSettings.
  ///
  /// In en, this message translates to:
  /// **'Sound Settings'**
  String get soundSettings;

  /// No description provided for @enableSound.
  ///
  /// In en, this message translates to:
  /// **'Enable Sound'**
  String get enableSound;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @enableVibration.
  ///
  /// In en, this message translates to:
  /// **'Enable Vibration'**
  String get enableVibration;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @selectFontSize.
  ///
  /// In en, this message translates to:
  /// **'Select Font Size'**
  String get selectFontSize;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormat;

  /// No description provided for @selectDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Select Date Format'**
  String get selectDateFormat;

  /// No description provided for @timeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time Format'**
  String get timeFormat;

  /// No description provided for @selectTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Select Time Format'**
  String get selectTimeFormat;

  /// No description provided for @pageSize.
  ///
  /// In en, this message translates to:
  /// **'Page Size'**
  String get pageSize;

  /// No description provided for @selectPageSize.
  ///
  /// In en, this message translates to:
  /// **'Select Page Size'**
  String get selectPageSize;

  /// No description provided for @cacheDuration.
  ///
  /// In en, this message translates to:
  /// **'Cache Duration'**
  String get cacheDuration;

  /// No description provided for @selectCacheDuration.
  ///
  /// In en, this message translates to:
  /// **'Select Cache Duration'**
  String get selectCacheDuration;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// No description provided for @clearCacheDescription.
  ///
  /// In en, this message translates to:
  /// **'Clear all cached data'**
  String get clearCacheDescription;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cacheCleared;

  /// No description provided for @resetSettings.
  ///
  /// In en, this message translates to:
  /// **'Reset Settings'**
  String get resetSettings;

  /// No description provided for @resetSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings to default'**
  String get resetSettingsDescription;

  /// No description provided for @resetSettingsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all settings to default?'**
  String get resetSettingsConfirm;

  /// No description provided for @settingsReset.
  ///
  /// In en, this message translates to:
  /// **'Settings reset successfully'**
  String get settingsReset;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @extraLarge.
  ///
  /// In en, this message translates to:
  /// **'Extra Large'**
  String get extraLarge;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hour(s)'**
  String get hours;

  /// No description provided for @itemsPerPage.
  ///
  /// In en, this message translates to:
  /// **'items per page'**
  String get itemsPerPage;

  /// No description provided for @appLockTitle.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get appLockTitle;

  /// No description provided for @appLockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set PIN lock'**
  String get appLockSubtitle;

  /// No description provided for @enterPinToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN to continue'**
  String get enterPinToContinue;

  /// No description provided for @invalidPinMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid PIN, please try again'**
  String get invalidPinMessage;

  /// No description provided for @appLockEnabled.
  ///
  /// In en, this message translates to:
  /// **'App lock is enabled'**
  String get appLockEnabled;

  /// No description provided for @appLockDisabled.
  ///
  /// In en, this message translates to:
  /// **'Protect your app with a PIN'**
  String get appLockDisabled;

  /// No description provided for @setPin.
  ///
  /// In en, this message translates to:
  /// **'Set PIN'**
  String get setPin;

  /// No description provided for @changePin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changePin;

  /// No description provided for @currentPin.
  ///
  /// In en, this message translates to:
  /// **'Current PIN'**
  String get currentPin;

  /// No description provided for @newPin.
  ///
  /// In en, this message translates to:
  /// **'New PIN'**
  String get newPin;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @enableAppLockButton.
  ///
  /// In en, this message translates to:
  /// **'Enable App Lock'**
  String get enableAppLockButton;

  /// No description provided for @updatePinButton.
  ///
  /// In en, this message translates to:
  /// **'Update PIN'**
  String get updatePinButton;

  /// No description provided for @disableAppLockButton.
  ///
  /// In en, this message translates to:
  /// **'Disable App Lock'**
  String get disableAppLockButton;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get genericError;

  /// No description provided for @pinEnabledSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN enabled successfully'**
  String get pinEnabledSuccess;

  /// No description provided for @pinUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN updated successfully'**
  String get pinUpdatedSuccess;

  /// No description provided for @pinDisabledSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN lock disabled'**
  String get pinDisabledSuccess;

  /// No description provided for @oldPinIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current PIN is incorrect'**
  String get oldPinIncorrect;

  /// No description provided for @pinLengthError.
  ///
  /// In en, this message translates to:
  /// **'PIN must be between {min} and {max} digits'**
  String pinLengthError(int min, int max);

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PIN and confirmation do not match'**
  String get pinMismatch;

  /// No description provided for @addNewEmployee.
  ///
  /// In en, this message translates to:
  /// **'Add New Employee'**
  String get addNewEmployee;

  /// No description provided for @editEmployee.
  ///
  /// In en, this message translates to:
  /// **'Edit Employee Information'**
  String get editEmployee;

  /// No description provided for @employeeDetails.
  ///
  /// In en, this message translates to:
  /// **'Employee Details'**
  String get employeeDetails;

  /// No description provided for @employeeId.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get employeeId;

  /// No description provided for @rolePosition.
  ///
  /// In en, this message translates to:
  /// **'Role / Position'**
  String get rolePosition;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @joiningDate.
  ///
  /// In en, this message translates to:
  /// **'Joining Date'**
  String get joiningDate;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile Image'**
  String get profileImage;

  /// No description provided for @deleteEmployee.
  ///
  /// In en, this message translates to:
  /// **'Delete Employee'**
  String get deleteEmployee;

  /// No description provided for @confirmDeleteEmployee.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this employee? This action cannot be undone.'**
  String get confirmDeleteEmployee;

  /// No description provided for @totalEmployees.
  ///
  /// In en, this message translates to:
  /// **'Total Employees'**
  String get totalEmployees;

  /// No description provided for @activeEmployees.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeEmployees;

  /// No description provided for @inactiveEmployees.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactiveEmployees;

  /// No description provided for @monthlyPayroll.
  ///
  /// In en, this message translates to:
  /// **'Monthly Payroll'**
  String get monthlyPayroll;

  /// No description provided for @roleRequired.
  ///
  /// In en, this message translates to:
  /// **'Role is required'**
  String get roleRequired;

  /// No description provided for @salaryRequired.
  ///
  /// In en, this message translates to:
  /// **'Salary is required'**
  String get salaryRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
