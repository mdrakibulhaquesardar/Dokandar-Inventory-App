// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'BizDash';

  @override
  String get appDescription => 'বিজনেস অ্যাডমিন UI কিট';

  @override
  String get settings => 'সেটিংস';

  @override
  String get aboutApp => 'অ্যাপ সম্পর্কে';

  @override
  String get subscription => 'সাবস্ক্রিপশন';

  @override
  String get products => 'আইটেম';

  @override
  String get customers => 'কনট্যাক্ট';

  @override
  String get sales => 'কার্যকলাপ';

  @override
  String get inventory => 'রেকর্ড';

  @override
  String get addProduct => 'আইটেম যোগ করুন';

  @override
  String get addCustomer => 'কনট্যাক্ট যোগ করুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'মুছুন';

  @override
  String get edit => 'সম্পাদনা';

  @override
  String get search => 'খুঁজুন';

  @override
  String get name => 'নাম';

  @override
  String get price => 'মূল্য';

  @override
  String get quantity => 'পরিমাণ';

  @override
  String get phone => 'ফোন';

  @override
  String get email => 'ইমেইল';

  @override
  String get address => 'ঠিকানা';

  @override
  String get total => 'মোট';

  @override
  String get subtotal => 'উপমোট';

  @override
  String get discount => 'ছাড়';

  @override
  String get dueAmount => 'বাকি পরিমাণ';

  @override
  String get paidAmount => 'পরিশোধিত পরিমাণ';

  @override
  String get lowStock => 'স্টক কম';

  @override
  String get outOfStock => 'স্টক নেই';

  @override
  String get success => 'সফল';

  @override
  String get error => 'ত্রুটি';

  @override
  String get loading => 'লোড হচ্ছে...';

  @override
  String get noData => 'কোন তথ্য নেই';

  @override
  String get developerInfo => 'ডেভেলপার তথ্য';

  @override
  String get appInfo => 'অ্যাপ তথ্য';

  @override
  String get currentVersionAndDescription => 'বর্তমান সংস্করণ এবং বিবরণ';

  @override
  String get developer => 'ডেভেলপার';

  @override
  String get changelog => 'পরিবর্তনসমূহ';

  @override
  String get version => 'সংস্করণ';

  @override
  String get lastUpdate => 'আপডেট তারিখ';

  @override
  String get appSize => 'অ্যাপ সাইজ';

  @override
  String get freePlan => 'ফ্রি প্ল্যান';

  @override
  String get currentPlan => 'বর্তমান প্ল্যান';

  @override
  String get upgrade => 'আপগ্রেড';

  @override
  String get buyNow => 'এখনই কিনুন';

  @override
  String get trialPeriod => 'ট্রায়াল পিরিয়ড';

  @override
  String days(int count) {
    return '$count দিন';
  }

  @override
  String productsLimit(int count) {
    return 'আপনি $countটি পর্যন্ত আইটেম যোগ করতে পারবেন';
  }

  @override
  String customersLimit(int count) {
    return 'আপনি $countটি পর্যন্ত কনট্যাক্ট যোগ করতে পারবেন';
  }

  @override
  String get limitReached => 'সীমা পৌঁছেছে';

  @override
  String get pleaseUpgrade => 'আরও যোগ করতে দয়া করে আপগ্রেড করুন';

  @override
  String get home => 'হোম';

  @override
  String get summaryInfo => 'সারাংশ তথ্য';

  @override
  String get summaryInfoDescription => 'সারাংশ তথ্য এবং সম্পর্কিত বিবরণ দেখুন';

  @override
  String get totalProducts => 'মোট আইটেম';

  @override
  String get totalSales => 'মোট কার্যকলাপ';

  @override
  String get categories => 'ক্যাটাগরি';

  @override
  String get todaysOrders => 'আজকের রেকর্ড';

  @override
  String get totalProfit => 'মোট মার্জিন';

  @override
  String get recentSales => 'সাম্প্রতিক কার্যকলাপ';

  @override
  String get recentSalesDescription => 'সাম্প্রতিক কার্যকলাপের তালিকা দেখুন';

  @override
  String get stockAlert => 'স্টক অ্যালার্ট';

  @override
  String get stockAlertDescription => 'কিছু আইটেমের স্টক কমে যাচ্ছে';

  @override
  String get noRecentSales => 'কোনো সাম্প্রতিক কার্যকলাপ নেই';

  @override
  String get addToStock => 'স্টকে যোগ করুন';

  @override
  String get searchProducts => 'আইটেম অনুসন্ধান করুন';

  @override
  String get totalPrice => 'মোট মান';

  @override
  String get quickAccess => 'দ্রুত অ্যাক্সেস';

  @override
  String get quickAccessDescription =>
      'আপনার রেকর্ডে দ্রুত যেতে নিচের অপশনগুলো ব্যবহার করুন।';

  @override
  String get allProducts => 'সব আইটেম';

  @override
  String get salesHistory => 'কার্যকলাপ ইতিহাস';

  @override
  String get allCustomers => 'সব কনট্যাক্ট';

  @override
  String get allSuppliers => 'সব পার্টনার';

  @override
  String get storeExpenses => 'খরচ';

  @override
  String get allEmployees => 'সব টিম মেম্বার';

  @override
  String get otherFunctions => 'অন্যান্য সেকশন';

  @override
  String get otherFunctionsDescription =>
      'অ্যাডমিন UI এর অন্যান্য সেকশন ব্যবহার করুন।';

  @override
  String get duePayment => 'বকেয়া মান';

  @override
  String get productCategories => 'আইটেম ক্যাটাগরি';

  @override
  String get transactionHistory => 'অ্যাকটিভিটি লগ';

  @override
  String get supplierManagement => 'পার্টনার ম্যানেজমেন্ট';

  @override
  String get generateReport => 'রিপোর্ট তৈরি করুন';

  @override
  String get viewDetails => 'বিস্তারিত দেখুন';

  @override
  String get newLabel => 'নতুন';

  @override
  String get sellCounter => 'কার্যকলাপ কাউন্টার';

  @override
  String get searchProduct => 'আইটেম খুঁজুন...';

  @override
  String totalProductsCount(int count) {
    return 'মোট আইটেম: $count';
  }

  @override
  String get completeSale => 'অ্যাকশন সম্পন্ন করুন';

  @override
  String get noProductsAdded => 'কোন আইটেম যোগ করা হয়নি';

  @override
  String get salesCounter => 'কার্যকলাপ কাউন্টার';

  @override
  String get yourProducts => 'আপনার আইটেমসমূহ';

  @override
  String get stockOut => 'স্টক কম';

  @override
  String get recentProducts => 'সাম্প্রতিক আইটেম';

  @override
  String get editProduct => 'আইটেম সম্পাদনা করুন';

  @override
  String get productName => 'আইটেমের নাম';

  @override
  String get stockQuantity => 'স্টকের পরিমাণ';

  @override
  String get sellingPrice => 'ইউনিট মূল্য';

  @override
  String get buyingPrice => 'বেস মূল্য';

  @override
  String get profit => 'মার্জিন';

  @override
  String get unitProfit => 'প্রতি ইউনিট মার্জিন';

  @override
  String get createdAt => 'তৈরি হয়েছে';

  @override
  String get deleteProduct => 'আইটেম মুছে ফেলুন';

  @override
  String get confirmDeleteProduct =>
      'আপনি কি নিশ্চিত যে আপনি এই আইটেমটি মুছে ফেলতে চান?';

  @override
  String get no => 'না';

  @override
  String get yesDelete => 'হ্যাঁ, মুছুন';

  @override
  String get addNewProduct => 'নতুন আইটেম যোগ করুন';

  @override
  String get category => 'ক্যাটাগরি';

  @override
  String get customerList => 'কনট্যাক্ট তালিকা';

  @override
  String get totalCustomers => 'মোট কনট্যাক্ট';

  @override
  String get newCustomers => 'নতুন কনট্যাক্ট';

  @override
  String get totalDue => 'মোট বকেয়া মান';

  @override
  String get customerName => 'কনট্যাক্টের নাম';

  @override
  String get customerPhone => 'কনট্যাক্টের ফোন';

  @override
  String get customerAddress => 'কনট্যাক্টের ঠিকানা';

  @override
  String get totalPurchases => 'মোট মান';

  @override
  String get due => 'বকি';

  @override
  String get customer => 'কনট্যাক্ট';

  @override
  String get salesList => 'কার্যকলাপ তালিকা';

  @override
  String get totalTransactions => 'মোট কার্যকলাপ';

  @override
  String get noSales => 'কোন কার্যকলাপ নেই';

  @override
  String get invoiceNumber => 'রেকর্ড আইডি';

  @override
  String get date => 'তারিখ';

  @override
  String get paid => 'পরিশোধিত';

  @override
  String get saleDetails => 'কার্যকলাপ বিবরণ';

  @override
  String get productList => 'আইটেম তালিকা';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get dueCustomersList => 'বকেয়া কনট্যাক্ট তালিকা';

  @override
  String get totalDueCustomers => 'মোট বকেয়া কনট্যাক্ট';

  @override
  String get noDueCustomers => 'কোন বকেয়া নেই';

  @override
  String get people => 'জন';

  @override
  String get payDue => 'বকেয়া স্যাটেল করুন';

  @override
  String get enterAmount => 'টাকার পরিমাণ লিখুন';

  @override
  String get pay => 'প্রয়োগ করুন';

  @override
  String get yourCategories => 'আপনার ক্যাটাগরি';

  @override
  String get addCategory => 'ক্যাটাগরি যোগ করুন';

  @override
  String get categoryName => 'ক্যাটাগরির নাম';

  @override
  String get description => 'বিবরণ';

  @override
  String get editCategory => 'ক্যাটাগরি সম্পাদনা করুন';

  @override
  String get update => 'হালনাগাদ করুন';

  @override
  String get userSetup => 'ইউজার সেটআপ';

  @override
  String get step1of2 => 'ধাপ ১/২';

  @override
  String get step2of2 => 'ধাপ ২/২';

  @override
  String get step3of3 => 'ধাপ ৩/৩';

  @override
  String get completeYourProfile => 'আপনার প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get provideRequiredInfo =>
      'এই UI কিট ব্যবহার করার জন্য প্রয়োজনীয় ডেমো তথ্য দিন';

  @override
  String get userInformation => 'ইউজার তথ্য';

  @override
  String get setupProfileAndProvideInfo => 'ডেমো প্রোফাইল সেটআপ করুন';

  @override
  String get enterYourFullName => 'আপনার পূর্ণ নাম লিখুন';

  @override
  String get enterYourEmail => 'আপনার ইমেইল ঠিকানা লিখুন';

  @override
  String get enterYourPhoneNumber => 'আপনার মোবাইল নম্বর লিখুন';

  @override
  String get enterYourAddress => 'আপনার ঠিকানা লিখুন';

  @override
  String get goToNextStep => 'পরবর্তী ধাপে যান';

  @override
  String get step => 'ধাপ';

  @override
  String get completeProfile => 'প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get completeProfileDescription => 'ডেমো উদ্দেশ্যে তথ্য দিন';

  @override
  String get userInfo => 'ইউজার তথ্য';

  @override
  String get userInfoDescription => 'আপনার প্রোফাইল তথ্য সেট করুন';

  @override
  String get fullName => 'আপনার পূর্ণ নাম লিখুন';

  @override
  String get emailAddress => 'আপনার ইমেইল ঠিকানা লিখুন';

  @override
  String get mobileNumber => 'আপনার মোবাইল নম্বর লিখুন';

  @override
  String get yourAddress => 'আপনার ঠিকানা লিখুন';

  @override
  String get nextStep => 'পরবর্তী ধাপে যান';

  @override
  String get pinCodeSetup => 'আপনি চাইলে পরবর্তী ধাপে পিন সেটআপ করতে পারেন';

  @override
  String get storeSetup => 'ওয়ার্কস্পেস সেটআপ';

  @override
  String get addStoreLogo => 'লোগো যোগ করুন';

  @override
  String get storeInfo => 'ওয়ার্কস্পেস তথ্য';

  @override
  String get storeInfoDescription => 'আপনার ওয়ার্কস্পেসের তথ্য দিন';

  @override
  String get storeName => 'ওয়ার্কস্পেসের নাম';

  @override
  String get storeNameRequired => 'ওয়ার্কস্পেসের নাম দিন';

  @override
  String get addressRequired => 'ঠিকানা দিন';

  @override
  String get phoneNumber => 'ফোন নম্বর';

  @override
  String get phoneNumberRequired => 'ফোন নম্বর দিন';

  @override
  String get emailRequired => 'ইমেইল প্রয়োজন';

  @override
  String get validEmailRequired => 'সঠিক ইমেইল দিন';

  @override
  String get businessType => 'ব্যবসার ধরন';

  @override
  String get businessTypeRequired => 'ব্যবসার ধরন দিন';

  @override
  String get retailer => 'রিটেইল';

  @override
  String get wholesaler => 'হোলসেল';

  @override
  String get restaurant => 'রেস্টুরেন্ট';

  @override
  String get pharmacy => 'ফার্মেসি';

  @override
  String get fashionStore => 'ফ্যাশন স্টোর';

  @override
  String get electronics => 'ইলেকট্রনিক্স';

  @override
  String get other => 'অন্যান্য';

  @override
  String get storeInfoNote =>
      'এটি শুধুমাত্র UI ডেমো, কোন বাস্তব ডেটা সংরক্ষণ হয় না।';

  @override
  String get previous => 'পূর্ববর্তী';

  @override
  String get next => 'পরবর্তী';

  @override
  String get improveStoreManagement => 'আপনার অ্যাডমিন অভিজ্ঞতা উন্নত করুন';

  @override
  String get startWithPowerfulTool =>
      'এই বিজনেস অ্যাডমিন UI কিট দিয়ে শুরু করুন।';

  @override
  String get trackAllActivities => 'সকল কার্যক্রম ট্র্যাক করুন';

  @override
  String get trackActivitiesDescription =>
      'এক জায়গায় রেকর্ড, কার্যকলাপ এবং রিপোর্ট দেখুন।';

  @override
  String get smartBusinessInsights => 'স্মার্ট ইনসাইট';

  @override
  String get smartInsightsDescription =>
      'অ্যানালিটিক্স UI দিয়ে গুরুত্বপূর্ণ মেট্রিক দেখান।';

  @override
  String get secureAndPrivate => 'শুধু UI';

  @override
  String get secureDescription =>
      'এই কিট কোন বাস্তব ডেটা সংরক্ষণ বা সিঙ্ক করে না।';

  @override
  String get startManagingStore => 'ড্যাশবোর্ড খুলুন';

  @override
  String get startWithTool => 'এই UI কিট দিয়ে শুরু করুন';

  @override
  String get start => 'শুরু করুন';

  @override
  String get customizeAppSettings => 'আপনার UI পছন্দ কাস্টমাইজ করুন';

  @override
  String get appSettings => 'অ্যাপ সেটিংস';

  @override
  String get appTheme => 'অ্যাপ থিম';

  @override
  String get language => 'ভাষা';

  @override
  String get dataManagement => 'ডাটা (শুধু UI)';

  @override
  String get dataBackup => 'ব্যাকআপ (শুধু UI)';

  @override
  String get dataRestore => 'রিস্টোর (শুধু UI)';

  @override
  String get storeSettings => 'ওয়ার্কস্পেস সেটিংস';

  @override
  String get dokandarSubscription => 'সাবস্ক্রিপশন (শুধু UI)';

  @override
  String get supportAndHelp => 'সাপোর্ট এবং সহায়তা';

  @override
  String get supportCenter => 'সাপোর্ট সেন্টার';

  @override
  String get feedback => 'ফিডব্যাক';

  @override
  String get store => 'ওয়ার্কস্পেস';

  @override
  String get joinDate => 'যোগদান তারিখ';

  @override
  String get mobile => 'মোবাইল';

  @override
  String get noMobileNumber => 'মোবাইল নম্বর নেই';

  @override
  String get dataNotFound => 'তথ্য পাওয়া যায়নি';

  @override
  String get dateNotFound => 'তারিখ পাওয়া যায়নি';

  @override
  String get defaultName => 'ডেমো ইউজার';

  @override
  String get joined => 'যোগদান';

  @override
  String get premiumSubscription => 'প্রিমিয়াম সাবস্ক্রিপশন কার্ড';

  @override
  String get premiumSubtitle =>
      'নিজের সাবস্ক্রিপশন প্ল্যানের জন্য এই UI ব্যবহার করুন';

  @override
  String get freePlanFeatures => 'ফ্রি প্ল্যানের সুবিধা';

  @override
  String get subscriptionPackages => 'সাবস্ক্রিপশন প্যাকেজ';

  @override
  String get productsUpTo => 'টি পর্যন্ত আইটেম যোগ করতে পারবেন';

  @override
  String get customersUpTo => 'টি পর্যন্ত কনট্যাক্ট যোগ করতে পারবেন';

  @override
  String get trialPeriodDays => 'দিনের ট্রায়াল পিরিয়ড';

  @override
  String get subscriptionAdditionalInfo =>
      'নিজের সাবস্ক্রিপশন তথ্য এখানে দেখাতে পারবেন।';

  @override
  String subscriptionExpiryNote(String startDate) {
    return 'আপনার বর্তমান অফার শেষ হলে $startDate থেকে নিয়মিত রেট প্রযোজ্য হবে।';
  }

  @override
  String get free => 'ফ্রি';

  @override
  String get basicReports => 'বেসিক ডেমো রিপোর্ট দেখতে পারবেন';

  @override
  String get completeOrder => 'রিভিউ সম্পন্ন করুন';

  @override
  String get orderSummary => 'সারাংশ';

  @override
  String get newOrder => 'নতুন রেকর্ড';

  @override
  String get customerInfo => 'কনট্যাক্ট তথ্য';

  @override
  String get optional => 'ঐচ্ছিক';

  @override
  String get unknown => 'অজানা';

  @override
  String get discountAmount => 'ডিসকাউন্ট (৳)';

  @override
  String get dueAmountField => 'বাকি টাকা (৳)';

  @override
  String get orderNote => 'নোট (যদি থাকে)';

  @override
  String get invoice => 'রিপোর্ট';

  @override
  String get generating => 'তৈরি হচ্ছে...';

  @override
  String get confirmOrder => 'নিশ্চিত করুন';

  @override
  String get localBackup => 'লোকাল ব্যাকআপ';

  @override
  String get backupToLocalStorage => 'লোকাল স্টোরেজে ব্যাকআপ';

  @override
  String get backupToLocalDescription =>
      'রিয়েল অ্যাপে ব্যাকআপ কীভাবে কাজ করবে তার উদাহরণ টেক্সট।';

  @override
  String get restoreFromLocal => 'লোকাল স্টোরেজ থেকে রিস্টোর';

  @override
  String get restoreFromLocalDescription =>
      'রিয়েল অ্যাপে রিস্টোর করার উদাহরণ টেক্সট।';

  @override
  String get lastBackup => 'সর্বশেষ ব্যাকআপ';

  @override
  String get noBackup => 'কোন ব্যাকআপ নেই';

  @override
  String get backupPrevention =>
      'ডাটা লস প্রতিরোধের জন্য পিসি বা ইউএসবি-তে ব্যাকআপ করার উদাহরণ টেক্সট।';

  @override
  String get backupStorage => 'ব্যাকআপ কোথায় সংরক্ষিত হবে তার উদাহরণ টেক্সট।';

  @override
  String get sharedDevice => 'শেয়ারড ডিভাইসে ব্যাকআপ নিয়ে উদাহরণ টেক্সট।';

  @override
  String get createBackup => 'ব্যাকআপ তৈরি করুন';

  @override
  String backupInstructions(String folderName) {
    return 'রিয়েল অ্যাপে ব্যাকআপ কিভাবে কাজ করবে তার বর্ণনা এখানে দেখাতে পারেন।';
  }

  @override
  String get dokandarFolder => 'BizDash ফোল্ডার';

  @override
  String get backupStorageLocation => 'ফোনের মেমরিতে।';

  @override
  String get backingUp => 'ব্যাকআপ করা হচ্ছে...';

  @override
  String get createNewBackup => 'নতুন ব্যাকআপ তৈরি করুন';

  @override
  String get selectBackupFile => 'ব্যাকআপ ফাইল নির্বাচন করুন';

  @override
  String get selectBackupDescription =>
      'আপনার ফোনের মেমরি থেকে ব্যাকআপ ফাইল নির্বাচন করুন (ডেমো মাত্র)।';

  @override
  String get restoreData => 'ডাটা রিস্টোর করুন';

  @override
  String get restoreDataDescription => 'ব্যাকআপ থেকে ডাটা রিস্টোরের উদাহরণ UI।';

  @override
  String get importantInfo => 'গুরুত্বপূর্ণ তথ্য';

  @override
  String get backupBeforeRestore =>
      'রিয়েল অ্যাপে রিস্টোরের আগে ব্যাকআপ নেওয়া উচিত।';

  @override
  String get restoreWarning =>
      'রিয়েল অ্যাপে রিস্টোর করলে বর্তমান ডাটা প্রতিস্থাপিত হবে।';

  @override
  String get validBackupOnly => 'শুধু বৈধ ব্যাকআপ ফাইল থেকে রিস্টোর করা যাবে।';

  @override
  String get restoring => 'রিস্টোর করা হচ্ছে...';

  @override
  String get restoreDataButton => 'ডাটা রিস্টোর করুন';

  @override
  String get currentVersion => 'বর্তমান সংস্করণ';

  @override
  String get updateDate => 'আপডেট তারিখ';

  @override
  String get changelogDescription => 'সর্বশেষ UI আপডেটে কি কি পরিবর্তন হয়েছে';

  @override
  String get developerInfoDescription => 'এই UI কিট কে তৈরি করেছে';

  @override
  String get legalInfo => 'আইনি তথ্য';

  @override
  String get legalInfoDescription => 'প্রাইভেসি পলিসি ও শর্তাবলী';

  @override
  String get privacyPolicy => 'প্রাইভেসি পলিসি';

  @override
  String get termsAndConditions => 'শর্তাবলী';

  @override
  String get supportAndHelpTitle => 'সাপোর্ট এন্ড হেল্প';

  @override
  String get howToUseApp => 'এই UI কিট কিভাবে ব্যবহার করবেন';

  @override
  String get gettingStarted => 'শুরু করার জন্য';

  @override
  String get gettingStartedDescription => 'এই অ্যাডমিন UI কিটের বেসিক শিখুন';

  @override
  String get productManagement => 'আইটেম ম্যানেজমেন্ট';

  @override
  String get productManagementDescription => 'আইটেম যোগ, সম্পাদনা ও দেখুন';

  @override
  String get salesAndReports => 'কার্যকলাপ ও রিপোর্ট';

  @override
  String get salesAndReportsDescription =>
      'কার্যকলাপ ট্র্যাক করুন এবং রিপোর্ট দেখান';

  @override
  String get availableModules => 'উপলব্ধ মডিউলসমূহ';

  @override
  String get availableModulesDescription =>
      'আপনার বিজনেস অ্যাডমিনের জন্য উপযোগী';

  @override
  String get inventoryManagement => 'রেকর্ড ম্যানেজমেন্ট';

  @override
  String get inventoryManagementDescription =>
      'স্টক ও রেকর্ড ট্র্যাক ও ম্যানেজ করুন';

  @override
  String get salesTracking => 'কার্যকলাপ ট্র্যাকিং';

  @override
  String get salesTrackingDescription => 'কার্যকলাপ ও মেট্রিক মনিটর করুন';

  @override
  String get customerManagement => 'কনট্যাক্ট ম্যানেজমেন্ট';

  @override
  String get customerManagementDescription => 'কনট্যাক্ট তথ্য ম্যানেজ করুন';

  @override
  String get reportsAndAnalytics => 'রিপোর্ট ও অ্যানালিটিক্স';

  @override
  String get reportsAndAnalyticsDescription => 'বিজনেস ইনসাইট তৈরি করুন';

  @override
  String get videoTutorials => 'ভিডিও টিউটোরিয়াল';

  @override
  String get videoTutorialsDescription => 'শিখুন এবং দক্ষতা বাড়ান';

  @override
  String get gettingStartedGuide => 'শুরু করার গাইড';

  @override
  String get someTipsToGetStarted => 'শুরু করার জন্য কিছু টিপস';

  @override
  String get learnBasicIn5Minutes => '৫ মিনিটে বেসিক শিখুন';

  @override
  String get advancedFeatures => 'অ্যাডভান্সড ফিচার';

  @override
  String get masterAdvancedFeatures => 'অ্যাডভান্সড ফিচার আয়ত্ত করুন';

  @override
  String get giveFeedback => 'আপনার মতামত দিন';

  @override
  String get feedbackDescription => 'এই কিট উন্নত করতে আপনার মতামত দিন';

  @override
  String get feedbackCategories => 'ফিডব্যাক ক্যাটাগরি';

  @override
  String get feedbackCategoriesDescription =>
      'আপনি কোন ধরনের ফিডব্যাক দিতে চান?';

  @override
  String get bugReport => 'বাগ রিপোর্ট';

  @override
  String get bugReportDescription => 'UI তে কোন সমস্যা পেয়েছেন?';

  @override
  String get featureRequest => 'ফিচার রিকোয়েস্ট';

  @override
  String get featureRequestDescription => 'নতুন কোন কম্পোনেন্ট চান?';

  @override
  String get generalFeedback => 'সাধারণ ফিডব্যাক';

  @override
  String get generalFeedbackDescription => 'আপনার অভিজ্ঞতা শেয়ার করুন';

  @override
  String get recentFeedback => 'সাম্প্রতিক ফিডব্যাক';

  @override
  String get recentFeedbackDescription => 'অন্যান্য ইউজারের মতামত';

  @override
  String get appIsGreat => 'UI খুব ভালো';

  @override
  String get appIsGreatDescription => 'প্রোটোটাইপের জন্য এই UI কিট খুব সহায়ক';

  @override
  String get someIssues => 'কিছু সমস্যা আছে';

  @override
  String get someIssuesDescription => 'কখনও কখনও কিছু ডিভাইসে স্লো হতে পারে';

  @override
  String get veryHelpful => 'অত্যন্ত সহায়ক';

  @override
  String get veryHelpfulDescription => 'স্ট্রাকচার কাস্টমাইজ করা সহজ';

  @override
  String get writeYourFeedback => 'আপনার ফিডব্যাক লিখুন';

  @override
  String get writeYourValuableFeedbackHint => 'আপনার মূল্যবান মতামত লিখুন...';

  @override
  String get rating => 'রেটিং:';

  @override
  String get submit => 'সাবমিট করুন';

  @override
  String get sampleUserName1 => 'রহিম আলী';

  @override
  String get sampleUserName2 => 'করিম আহমেদ';

  @override
  String get sampleUserName3 => 'ফাতেমা বেগম';

  @override
  String get sampleUserName4 => 'জাহিদ হাসান';

  @override
  String get newFeaturesNeeded => 'নতুন ফিচার দরকার';

  @override
  String get needToAddNewFeatures => 'UI কিটে কিছু নতুন ফিচার দরকার';

  @override
  String get customerHasDue => 'কনট্যাক্ট এর বকেয়া আছে';

  @override
  String get customerNoDue => 'কনট্যাক্ট এর বকেয়া নেই';

  @override
  String get lastPurchase => 'সর্বশেষ কার্যকলাপ';

  @override
  String get deleteCustomer => 'কনট্যাক্ট মুছে ফেলুন';

  @override
  String get confirmDeleteCustomer =>
      'আপনি কি নিশ্চিত যে আপনি এই কনট্যাক্টকে মুছে ফেলতে চান?';

  @override
  String get nameRequired => 'নাম প্রয়োজন';

  @override
  String get phoneRequired => 'ফোন প্রয়োজন';

  @override
  String get add => 'যোগ করুন';

  @override
  String stockInPieces(String quantity) {
    return 'স্টকে $quantity ইউনিট';
  }

  @override
  String get stock => 'স্টক';

  @override
  String get pieces => 'ইউনিট';

  @override
  String serviceInitFailed(String error) {
    return 'সার্ভিস শুরু করতে ব্যর্থ: $error';
  }

  @override
  String get backupSuccess => 'ব্যাকআপ সফল হয়েছে!';

  @override
  String backupFailed(String error) {
    return 'ব্যাকআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get restoreSuccess => 'রিস্টোর সফল হয়েছে!';

  @override
  String restoreFailed(String error) {
    return 'রিস্টোর ব্যর্থ হয়েছে: $error';
  }

  @override
  String get failedToLoadDueCustomers => 'তালিকা লোড করতে ব্যর্থ হয়েছে';

  @override
  String get paymentUpdated => 'পেমেন্ট আপডেট হয়েছে';

  @override
  String get failedToUpdatePayment => 'পেমেন্ট আপডেট করতে ব্যর্থ হয়েছে';

  @override
  String lastBackupDate(String date) {
    return 'সর্বশেষ ব্যাকআপ $date';
  }

  @override
  String get notifications => 'নোটিফিকেশন';

  @override
  String get enableNotifications => 'নোটিফিকেশন চালু করুন';

  @override
  String get autoBackup => 'অটো ব্যাকআপ';

  @override
  String get enableAutoBackup => 'অটো ব্যাকআপ চালু করুন';

  @override
  String get soundSettings => 'সাউন্ড সেটিংস';

  @override
  String get enableSound => 'সাউন্ড চালু করুন';

  @override
  String get vibration => 'ভাইব্রেশন';

  @override
  String get enableVibration => 'ভাইব্রেশন চালু করুন';

  @override
  String get fontSize => 'ফন্ট সাইজ';

  @override
  String get selectFontSize => 'ফন্ট সাইজ নির্বাচন করুন';

  @override
  String get currency => 'মুদ্রা';

  @override
  String get selectCurrency => 'মুদ্রা নির্বাচন করুন';

  @override
  String get dateFormat => 'তারিখ ফরম্যাট';

  @override
  String get selectDateFormat => 'তারিখ ফরম্যাট নির্বাচন করুন';

  @override
  String get timeFormat => 'সময় ফরম্যাট';

  @override
  String get selectTimeFormat => 'সময় ফরম্যাট নির্বাচন করুন';

  @override
  String get pageSize => 'পেজ সাইজ';

  @override
  String get selectPageSize => 'পেজ সাইজ নির্বাচন করুন';

  @override
  String get cacheDuration => 'ক্যাশে সময়কাল';

  @override
  String get selectCacheDuration => 'ক্যাশে সময়কাল নির্বাচন করুন';

  @override
  String get clearCache => 'ক্যাশে পরিষ্কার করুন';

  @override
  String get clearCacheDescription => 'সমস্ত ক্যাশে করা ডেটা পরিষ্কার করুন';

  @override
  String get cacheCleared => 'ক্যাশে সফলভাবে পরিষ্কার করা হয়েছে';

  @override
  String get resetSettings => 'সেটিংস রিসেট করুন';

  @override
  String get resetSettingsDescription => 'সমস্ত সেটিংস ডিফল্টে ফিরিয়ে দিন';

  @override
  String get resetSettingsConfirm =>
      'আপনি কি নিশ্চিত যে আপনি সমস্ত সেটিংস ডিফল্টে ফিরিয়ে দিতে চান?';

  @override
  String get settingsReset => 'সেটিংস সফলভাবে রিসেট করা হয়েছে';

  @override
  String get small => 'ছোট';

  @override
  String get medium => 'মাঝারি';

  @override
  String get large => 'বড়';

  @override
  String get extraLarge => 'অতিরিক্ত বড়';

  @override
  String get minutes => 'মিনিট';

  @override
  String get hours => 'ঘন্টা';

  @override
  String get itemsPerPage => 'প্রতি পেজে আইটেম';

  @override
  String get appLockTitle => 'অ্যাপ লক';

  @override
  String get appLockSubtitle => 'পিন লক সেট করুন';

  @override
  String get enterPinToContinue => 'চালিয়ে যেতে আপনার পিন দিন';

  @override
  String get invalidPinMessage => 'ভুল পিন, আবার চেষ্টা করুন';

  @override
  String get appLockEnabled => 'অ্যাপ লক চালু আছে';

  @override
  String get appLockDisabled => 'অ্যাপকে পিন দিয়ে সুরক্ষিত করুন';

  @override
  String get setPin => 'পিন সেট করুন';

  @override
  String get changePin => 'পিন পরিবর্তন করুন';

  @override
  String get currentPin => 'বর্তমান পিন';

  @override
  String get newPin => 'নতুন পিন';

  @override
  String get confirmPin => 'পিন নিশ্চিত করুন';

  @override
  String get saving => 'সংরক্ষণ হচ্ছে...';

  @override
  String get enableAppLockButton => 'অ্যাপ লক চালু করুন';

  @override
  String get updatePinButton => 'পিন আপডেট করুন';

  @override
  String get disableAppLockButton => 'অ্যাপ লক বন্ধ করুন';

  @override
  String get genericError => 'কিছু ভুল হয়েছে';

  @override
  String get pinEnabledSuccess => 'পিন সফলভাবে চালু হয়েছে';

  @override
  String get pinUpdatedSuccess => 'পিন সফলভাবে আপডেট হয়েছে';

  @override
  String get pinDisabledSuccess => 'পিন লক বন্ধ করা হয়েছে';

  @override
  String get oldPinIncorrect => 'বর্তমান পিন সঠিক নয়';

  @override
  String pinLengthError(int min, int max) {
    return 'পিন $min থেকে $max সংখ্যার হতে হবে';
  }

  @override
  String get pinMismatch => 'পিন এবং কনফার্মেশন মেলে না';

  @override
  String get fileManagement => 'ফাইল ম্যানেজমেন্ট';

  @override
  String get analytics => 'এনালিটিক্স';

  @override
  String get searchFiles => 'ফাইল খুঁজুন...';

  @override
  String get noFilesFound => 'কোন ফাইল পাওয়া যায়নি';

  @override
  String get uploadFile => 'ফাইল আপলোড করুন';

  @override
  String get chartsReports => 'চার্ট ও রিপোর্ট';

  @override
  String get all => 'সব';

  @override
  String get unread => 'অপঠিত';

  @override
  String get noNotifications => 'কোন নোটিফিকেশন নেই';

  @override
  String get allCaughtUp => 'আপনি সব দেখে ফেলেছেন!';

  @override
  String get notificationDetails => 'নোটিফিকেশন বিস্তারিত';

  @override
  String get message => 'বার্তা';

  @override
  String get takeAction => 'কার্যক্রম নিন';

  @override
  String get users => 'ব্যবহারকারী';

  @override
  String get searchUsers => 'ব্যবহারকারী খুঁজুন...';

  @override
  String get noUsersFound => 'কোন ব্যবহারকারী পাওয়া যায়নি';

  @override
  String get active => 'সক্রিয়';

  @override
  String get inactive => 'নিষ্ক্রিয়';

  @override
  String get suspended => 'স্থগিত';

  @override
  String get filters => 'ফিল্টার';

  @override
  String get role => 'ভূমিকা';

  @override
  String get allRoles => 'সব ভূমিকা';

  @override
  String get status => 'অবস্থা';

  @override
  String get allStatus => 'সব অবস্থা';

  @override
  String get clearFilters => 'ফিল্টার সাফ করুন';

  @override
  String get rolesPermissions => 'ভূমিকা ও অনুমতি';

  @override
  String get noRolesFound => 'কোন ভূমিকা পাওয়া যায়নি';

  @override
  String get permissions => 'অনুমতি';

  @override
  String get editRole => 'ভূমিকা সম্পাদনা';

  @override
  String get addRole => 'ভূমিকা যোগ করুন';

  @override
  String get roleName => 'ভূমিকার নাম';

  @override
  String get updateRole => 'ভূমিকা আপডেট করুন';

  @override
  String get open => 'খুলুন';

  @override
  String get filePreviewDemo => 'ফাইল প্রিভিউ এখানে খুলবে';

  @override
  String get fileUploadDemo =>
      'ফাইল আপলোড কার্যকারিতা এখানে বাস্তবায়ন করা হবে';

  @override
  String get fileUploadUIOnly => 'ফাইল আপলোড শুধু UI';

  @override
  String get chartPreview => 'চার্ট প্রিভিউ';

  @override
  String dataPoints(int count) {
    return '$count ডেটা পয়েন্ট';
  }

  @override
  String get justNow => 'এখনই';

  @override
  String get yesterday => 'গতকাল';

  @override
  String minutesAgo(int minutes) {
    return '$minutes মিনিট আগে';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours ঘণ্টা আগে';
  }

  @override
  String daysAgo(int days) {
    return '$days দিন আগে';
  }

  @override
  String get department => 'বিভাগ';

  @override
  String get editUser => 'ব্যবহারকারী সম্পাদনা';

  @override
  String get addUser => 'ব্যবহারকারী যোগ করুন';

  @override
  String get updateUser => 'ব্যবহারকারী আপডেট করুন';

  @override
  String get departmentRequired => 'বিভাগ প্রয়োজন';

  @override
  String get roleRequired => 'ভূমিকা প্রয়োজন';

  @override
  String get permissionsLabel => 'অনুমতি';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get dashboard => 'ড্যাশবোর্ড';

  @override
  String get records => 'রেকর্ড';

  @override
  String get reports => 'রিপোর্ট';

  @override
  String get userManagement => 'ব্যবহারকারী ব্যবস্থাপনা';
}
