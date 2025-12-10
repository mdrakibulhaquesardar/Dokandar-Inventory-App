// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'দোকানদার';

  @override
  String get appDescription => 'ইনভেন্টরি ম্যানেজমেন্ট সিস্টেম';

  @override
  String get settings => 'সেটিংস';

  @override
  String get aboutApp => 'অ্যাপ সম্পর্কে';

  @override
  String get subscription => 'সাবস্ক্রিপশন';

  @override
  String get products => 'পণ্য';

  @override
  String get customers => 'গ্রাহক';

  @override
  String get sales => 'বিক্রয়';

  @override
  String get inventory => 'ইনভেন্টরি';

  @override
  String get addProduct => 'পণ্য যোগ করুন';

  @override
  String get addCustomer => 'গ্রাহক যোগ করুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'ডিলিট করুন';

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
  String get developer => 'Developer';

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
  String get buyNow => 'এখনি কিনুন';

  @override
  String get trialPeriod => 'ট্রায়াল পিরিয়ড';

  @override
  String days(int count) {
    return '$count দিন';
  }

  @override
  String productsLimit(int count) {
    return 'আপনি $countটি পর্যন্ত পণ্য যোগ করতে পারবেন';
  }

  @override
  String customersLimit(int count) {
    return 'আপনি $countটি পর্যন্ত গ্রাহক যোগ করতে পারবেন';
  }

  @override
  String get limitReached => 'সীমা পৌঁছেছে';

  @override
  String get pleaseUpgrade => 'আরও যোগ করতে দয়া করে আপগ্রেড করুন';

  @override
  String get home => 'হোম';

  @override
  String get summaryInfo => 'সারাংশিক তথ্য';

  @override
  String get summaryInfoDescription =>
      'সারাংশিক তথ্য সম্পর্কিত বিবরণ শো করুন সম্পর্কিত বিবরণ শো করুন';

  @override
  String get totalProducts => 'মোট পণ্য';

  @override
  String get totalSales => 'মোট বিক্রয়';

  @override
  String get categories => 'ক্যাটাগরি';

  @override
  String get todaysOrders => 'আজকের অর্ডার';

  @override
  String get totalProfit => 'মোট মুনাফা';

  @override
  String get recentSales => 'সাম্প্রতিক বিক্রয়';

  @override
  String get recentSalesDescription =>
      'সাম্প্রতিক বিক্রয় তালিকা শো করুন সম্প্রতিক বিক্রয় তালিকা শো করুন';

  @override
  String get stockAlert => 'স্টক অ্যালার্ট';

  @override
  String get stockAlertDescription =>
      'স্টক শেষ হতে ৩ দিন আগে কয়েকটি পণ্যের স্টক শেষ হচ্ছে';

  @override
  String get noRecentSales => 'কোনো সাম্প্রতিক বিক্রয় নেই';

  @override
  String get addToStock => 'স্টকে যোগ করুন';

  @override
  String get searchProducts => 'পণ্য অনুসন্ধান করুন';

  @override
  String get totalPrice => 'মোট মূল্য';

  @override
  String get quickAccess => 'দ্রুত অ্যাক্সেস';

  @override
  String get quickAccessDescription =>
      'আপনার ইনভেন্টরির জন্য দ্রুত অ্যাক্সেস পেতে নিচের অপশনগুলো ব্যবহার করুন।';

  @override
  String get allProducts => 'সকল পণ্য';

  @override
  String get salesHistory => 'বিক্রয় ইতিহাস';

  @override
  String get allCustomers => 'সকল কাস্টমার';

  @override
  String get allSuppliers => 'সকল সাপ্লায়ার';

  @override
  String get storeExpenses => 'দোকান খরচ';

  @override
  String get allEmployees => 'সকল কর্মচারী';

  @override
  String get otherFunctions => 'অন্যান্য ফাংশন';

  @override
  String get otherFunctionsDescription =>
      'আপনার ইনভেন্টরির জন্য অন্যান্য ফাংশনগুলো ব্যবহার করুন।';

  @override
  String get duePayment => 'বাকি প্রতিশোধ';

  @override
  String get productCategories => 'পণ্যের ক্যাটাগরি';

  @override
  String get transactionHistory => 'ট্রানজেকশন ইতিহাস';

  @override
  String get supplierManagement => 'সাপ্লায়ার ম্যানেজমেন্ট';

  @override
  String get generateReport => 'রিপোর্ট জেনারেট';

  @override
  String get viewDetails => 'বিস্তারিত দেখুন';

  @override
  String get newLabel => 'নতুন';

  @override
  String get sellCounter => 'বিক্রয় কাউন্টার';

  @override
  String get searchProduct => 'পণ্য খুঁজুন...';

  @override
  String totalProductsCount(int count) {
    return 'মোট পণ্য: $count';
  }

  @override
  String get completeSale => 'বিক্রয় সম্পন্ন করুন';

  @override
  String get noProductsAdded => 'কোন পণ্য যোগ করা হয়নি';

  @override
  String get salesCounter => 'বিক্রয় কাউন্টার';

  @override
  String get yourProducts => 'আপনার পণ্যসমূহ';

  @override
  String get stockOut => 'স্টক আউট';

  @override
  String get recentProducts => 'সাম্রতিক পণ্যসমূহ';

  @override
  String get editProduct => 'পণ্য সম্পাদনা করুন';

  @override
  String get productName => 'পণ্যের নাম';

  @override
  String get stockQuantity => 'স্টক পরিমাণ';

  @override
  String get sellingPrice => 'বিক্রয় মূল্য';

  @override
  String get buyingPrice => 'ক্রয় মূল্য';

  @override
  String get profit => 'মুনাফা';

  @override
  String get unitProfit => 'একক মুনাফা';

  @override
  String get createdAt => 'তৈরি হয়েছে';

  @override
  String get deleteProduct => 'পণ্য মুছে ফেলুন';

  @override
  String get confirmDeleteProduct =>
      'আপনি কি নিশ্চিত যে আপনি এই পণ্যটি মুছে ফেলতে চান?';

  @override
  String get no => 'না';

  @override
  String get yesDelete => 'হ্যাঁ, মুছে ফেলুন';

  @override
  String get addNewProduct => 'নতুন পণ্য যোগ করুন';

  @override
  String get category => 'ক্যাটাগরি';

  @override
  String get customerList => 'গ্রাহক তালিকা';

  @override
  String get totalCustomers => 'মোট গ্রাহক';

  @override
  String get newCustomers => 'নতুন গ্রাহক';

  @override
  String get totalDue => 'মোট বাকি টাকা';

  @override
  String get customerName => 'গ্রাহকের নাম';

  @override
  String get customerPhone => 'গ্রাহকের ফোন';

  @override
  String get customerAddress => 'গ্রাহকের ঠিকানা';

  @override
  String get totalPurchases => 'মোট ক্রয়';

  @override
  String get due => 'বাকি';

  @override
  String get customer => 'গ্রাহক';

  @override
  String get salesList => 'বিক্রয় তালিকা';

  @override
  String get totalTransactions => 'মোট লেনদেন';

  @override
  String get noSales => 'কোন বিক্রয় নেই';

  @override
  String get invoiceNumber => 'ইনভয়েস নং';

  @override
  String get date => 'তারিখ';

  @override
  String get paid => 'প্রদত্ত';

  @override
  String get saleDetails => 'বিক্রয় বিবরণ';

  @override
  String get productList => 'পণ্য তালিকা';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get dueCustomersList => 'বাকিদার তালিকা';

  @override
  String get totalDueCustomers => 'মোট বাকিদার';

  @override
  String get noDueCustomers => 'কোন বাকিদার নেই';

  @override
  String get people => 'জন';

  @override
  String get payDue => 'বাকি পরিশোধ';

  @override
  String get enterAmount => 'টাকার পরিমাণ লিখুন';

  @override
  String get pay => 'পরিশোধ করুন';

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
  String get userSetup => 'ব্যবহারকারী সেটআপ';

  @override
  String get step1of2 => 'ধাপ 1/2';

  @override
  String get step2of2 => 'ধাপ 2/2';

  @override
  String get step3of3 => 'ধাপ ৩/৩';

  @override
  String get completeYourProfile => 'আপনার প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get provideRequiredInfo =>
      'আপনার ব্যবসা পরিচালনার জন্য প্রয়োজনীয় তথ্য দিন';

  @override
  String get userInformation => 'ব্যবহারকারীর তথ্য';

  @override
  String get setupProfileAndProvideInfo =>
      'আপনার প্রোফাইল সেটআপ করুন এবং ব্যবসার জন্য প্রয়োজনীয় তথ্য দিন';

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
  String get completeProfile => 'আপনার প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get completeProfileDescription =>
      'আপনার ব্যবসা পরিচালনার জন্য প্রয়োজনীয় তথ্য দিন';

  @override
  String get userInfo => 'ব্যবহারকারীর তথ্য';

  @override
  String get userInfoDescription =>
      'আপনার প্রোফাইল সেটআপ করুন এবং ব্যবসার জন্য প্রয়োজনীয় তথ্য দিন';

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
  String get pinCodeSetup => 'আপনি চাইলে পরবর্তী পিন কোডটি সেটআপ করতে পারে';

  @override
  String get storeSetup => 'দোকান সেটআপ';

  @override
  String get addStoreLogo => 'দোকানের লোগো যোগ করুন';

  @override
  String get storeInfo => 'দোকানের তথ্য';

  @override
  String get storeInfoDescription => 'আপনার দোকানের তথ্য দিন';

  @override
  String get storeName => 'দোকানের নাম';

  @override
  String get storeNameRequired => 'দোকানের নাম দিন';

  @override
  String get addressRequired => 'ঠিকানা দিন';

  @override
  String get phoneNumber => 'ফোন নম্বর';

  @override
  String get phoneNumberRequired => 'ফোন নম্বর দিন';

  @override
  String get emailRequired => 'ইমেইল দিন';

  @override
  String get validEmailRequired => 'সঠিক ইমেইল দিন';

  @override
  String get businessType => 'ব্যবসার ধরন';

  @override
  String get businessTypeRequired => 'ব্যবসার ধরন দিন';

  @override
  String get retailer => 'খুচরা বিক্রেতা';

  @override
  String get wholesaler => 'পাইকারি বিক্রেতা';

  @override
  String get restaurant => 'রেস্তোরাঁ';

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
      'আপনার দোকানের তথ্য সঠিকভাবে দিন। এই তথ্য আপনার ব্যবসার জন্য গুরুত্বপূর্ণ।';

  @override
  String get previous => 'পূর্ববর্তী';

  @override
  String get next => 'পরবর্তী';

  @override
  String get improveStoreManagement => 'আপনার দোকান ব্যবস্থাপনার উন্নতি করুন';

  @override
  String get startWithPowerfulTool =>
      'আমাদের শক্তিশালী দোকান ব্যবস্থাপনা টুল দিয়ে আপনার দোকান পরিচালনা শুরু করুন।';

  @override
  String get trackAllActivities => 'আপনার দোকানের সকল কার্যক্রম ট্র্যাক করুন';

  @override
  String get trackActivitiesDescription =>
      'একটি সুবিধাজনক স্থানে ইনভেন্টরি, বিক্রয় এবং লেনদেন পরিচালনা করুন।';

  @override
  String get smartBusinessInsights => 'স্মার্ট ব্যবসায়িক অন্তর্দৃষ্টি';

  @override
  String get smartInsightsDescription =>
      'সঠিক সিদ্ধান্ত নেওয়ার জন্য বিস্তারিত রিপোর্ট এবং বিশ্লেষণ পান।';

  @override
  String get secureAndPrivate => 'নিরাপদ এবং গোপনীয়';

  @override
  String get secureDescription =>
      'আপনার দোকানের তথ্য সুরক্ষিত এবং শুধুমাত্র আপনার জন্য অ্যাক্সেসযোগ্য।';

  @override
  String get startManagingStore => 'আপনার দোকান পরিচালনা শুরু করুন';

  @override
  String get startWithTool =>
      'আমাদের শক্তিশালী দোকান ব্যবস্থাপনা টুল দিয়ে শুরু করুন';

  @override
  String get start => 'শুরু করুন';

  @override
  String get customizeAppSettings => 'আপনার অ্যাপ সেটিংস কাস্টমাইজ করুন';

  @override
  String get appSettings => 'অ্যাপ সেটিংস';

  @override
  String get appTheme => 'অ্যাপ থিম';

  @override
  String get language => 'ভাষা';

  @override
  String get dataManagement => 'ডাটা ম্যানেজমেন্ট';

  @override
  String get dataBackup => 'ডাটা ব্যাকআপ';

  @override
  String get dataRestore => 'ডাটা রিস্টোর';

  @override
  String get storeSettings => 'দোকান সেটিংস';

  @override
  String get dokandarSubscription => 'দোকানদার সাবস্ক্রিপশন';

  @override
  String get supportAndHelp => 'সাপোর্ট এবং সহায়তা';

  @override
  String get supportCenter => 'সাপোর্ট সেন্টার';

  @override
  String get feedback => 'ফিডব্যাক';

  @override
  String get store => 'স্টোর';

  @override
  String get joinDate => 'যোগদান';

  @override
  String get mobile => 'মোবাইল';

  @override
  String get noMobileNumber => 'মোবাইল নাম্বার নেই';

  @override
  String get dataNotFound => 'তথ্য খুজে পাওয়া যায়নি';

  @override
  String get dateNotFound => 'তারিখ খুজে পাওয়া যায়নি';

  @override
  String get defaultName => 'রাকিব';

  @override
  String get joined => 'যোগদান';

  @override
  String get premiumSubscription => 'প্রিমিয়াম সাবস্ক্রিপশন নিন!';

  @override
  String get premiumSubtitle =>
      'আপনার প্রয়োজন অনুযায়ী সাবস্ক্রিপশন প্যাকেজ বেছে নিয়ে বড় সুবিধা পান';

  @override
  String get freePlanFeatures => 'ফ্রি প্ল্যানের সুবিধাসমূহ';

  @override
  String get subscriptionPackages => 'সাবস্ক্রিপশন প্যাকেজসমূহ';

  @override
  String get productsUpTo => 'টি পর্যন্ত পণ্য যোগ করতে পারবেন';

  @override
  String get customersUpTo => 'টি পর্যন্ত গ্রাহক যোগ করতে পারবেন';

  @override
  String get trialPeriodDays => 'দিনের ট্রায়াল পিরিয়ড';

  @override
  String get subscriptionAdditionalInfo =>
      'আপনার সাবস্ক্রিপশন প্যাকেজ বেছে নিয়ে আরও সুবিধা নিন। আমাদের প্রিমিয়াম প্ল্যানের মাধ্যমে আপনি আরও বেশি সুবিধা পাবেন।';

  @override
  String subscriptionExpiryNote(String startDate) {
    return 'আপনার বর্তমান অফার শেষ হলে $startDate থেকে নিয়মিত প্লাস রেট প্রযোজ্য হবে।';
  }

  @override
  String get free => 'ফ্রি';

  @override
  String get basicReports => 'বেসিক রিপোর্ট দেখতে পারবেন';

  @override
  String get completeOrder => 'অর্ডার চূড়ান্ত করুন';

  @override
  String get orderSummary => 'অর্ডার সারাংশ';

  @override
  String get newOrder => 'নতুন অর্ডার';

  @override
  String get customerInfo => 'গ্রাহক তথ্য';

  @override
  String get optional => 'অবশ্যই নয়';

  @override
  String get unknown => 'অজ্ঞাতপরিচয়';

  @override
  String get discountAmount => 'ডিসকাউন্ক (৳)';

  @override
  String get dueAmountField => 'বাকি টাকা (৳)';

  @override
  String get orderNote => 'অর্ডার নোট (যদি থাকে)';

  @override
  String get invoice => 'ইনভয়েস';

  @override
  String get generating => 'তৈরি হছে...';

  @override
  String get confirmOrder => 'অর্ডার নিশ্চিত করুন';

  @override
  String get localBackup => 'স্থানীয় ব্যাকআপ';

  @override
  String get backupToLocalStorage => 'স্থানীয় স্টোরেজে ব্যাকআপ';

  @override
  String get backupToLocalDescription =>
      'আপনার ফোনের মেমরি বা ইউএসবি ফ্ল্যাশ ড্রাইভে ফাইল ব্যাকআপ করুন।';

  @override
  String get restoreFromLocal => 'স্থানীয় স্টোরেজ থেকে পুনরুদ্ধার';

  @override
  String get restoreFromLocalDescription =>
      'মেমরি থেকে ব্যাকআপ ফাইল পুনরুদ্ধার করতে পারেন';

  @override
  String get lastBackup => 'সর্বশেষ ব্যাকআপ';

  @override
  String get noBackup => 'কোন ব্যাকআপ নেই';

  @override
  String get backupPrevention =>
      'ডেটা লস প্রতিরোধের জন্য আপনার পিসি বা ইউএসবি ফ্ল্যাশ ড্রাইভে ফাইল ব্যাকআপ করার পরামর্শ দেওয়া হয়।';

  @override
  String get backupStorage =>
      'আপনি যদি ফোনের মেমরিতে ফাইল ব্যাকআপ করেন, ব্যাকআপ ফাইলগুলি অভ্যন্তরীণ স্টোরেজ/ব্যাকআপে সংরক্ষিত হবে।';

  @override
  String get sharedDevice =>
      'আপনি যদি একটি শেয়ার করা ডিভাইসে ডেটা পাঠান, ব্যাকআপ ফাইলগুলি এমন একটি ডিভাইসে সংরক্ষিত হবে যা এটি ডিক্রিপ্ট করতে পারে না।';

  @override
  String get createBackup => 'ব্যাকআপ তৈরি করুন';

  @override
  String backupInstructions(String folderName) {
    return 'ব্যাকআপ তৈরি করতে, আপনার ফোনের মেমরিতে পর্যাপ্ত স্থান থাকতে হবে এবং ব্যাকআপ ফাইলগুলি আপনার $folderName ফোনের মেমরিতে এ সংরক্ষিত হবে।';
  }

  @override
  String get dokandarFolder => 'দোকানদার নাম ফোল্ডার';

  @override
  String get backupStorageLocation => 'ফোনের মেমরিতে এ সংরক্ষিত হবে।';

  @override
  String get backingUp => 'ব্যাকআপ করা হচ্ছে...';

  @override
  String get createNewBackup => 'নতুন ব্যাকআপ তৈরি করুন';

  @override
  String get selectBackupFile => 'ব্যাকআপ ফাইল নির্বাচন করুন';

  @override
  String get selectBackupDescription =>
      'আপনার ফোনের মেমরি থেকে ব্যাকআপ ফাইল নির্বাচন করুন।';

  @override
  String get restoreData => 'ডেটা পুনরুদ্ধার করুন';

  @override
  String get restoreDataDescription =>
      'নির্বাচিত ব্যাকআপ ফাইল থেকে ডেটা পুনরুদ্ধার করুন';

  @override
  String get importantInfo => 'গুরুত্বপূর্ণ তথ্য';

  @override
  String get backupBeforeRestore =>
      'পুনরুদ্ধার করার আগে, আপনার বর্তমান ডেটা ব্যাকআপ করার পরামর্শ দেওয়া হয়।';

  @override
  String get restoreWarning =>
      'পুনরুদ্ধার করার সময়, বর্তমান ডেটা মুছে যাবে এবং ব্যাকআপ ফাইলের ডেটা দিয়ে প্রতিস্থাপিত হবে।';

  @override
  String get validBackupOnly =>
      'শুধুমাত্র বৈধ ব্যাকআপ ফাইল থেকে ডেটা পুনরুদ্ধার করা যাবে।';

  @override
  String get restoring => 'পুনরুদ্ধার করা হচ্ছে...';

  @override
  String get restoreDataButton => 'ডেটা পুনরুদ্ধার করুন';

  @override
  String get currentVersion => 'বর্তমান সংস্করণ';

  @override
  String get updateDate => 'আপডেট তারিখ';

  @override
  String get changelogDescription => 'সর্বশেষ আপডেটে কি কি পরিবর্তন হয়েছে';

  @override
  String get developerInfoDescription => 'অ্যাপটি কে তৈরি করেছেন';

  @override
  String get legalInfo => 'আইনি তথ্য';

  @override
  String get legalInfoDescription => 'গোপনীয়তা নীতি এবং শর্তাবলী';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get termsAndConditions => 'শর্তাবলী';

  @override
  String get supportAndHelpTitle => 'সাপোর্ট এন্ড হেল্প';

  @override
  String get howToUseApp => 'অ্যাপটি কিভাবে ব্যবহার করবেন';

  @override
  String get gettingStarted => 'শুরু করার জন্য';

  @override
  String get gettingStartedDescription =>
      'আমাদের ইনভেন্টরি ম্যানেজমেন্ট সিস্টেমের বেসিক শিখুন';

  @override
  String get productManagement => 'পণ্য ব্যবস্থাপনা';

  @override
  String get productManagementDescription =>
      'পণ্য যোগ করুন, সম্পাদনা করুন এবং ট্র্যাক করুন';

  @override
  String get salesAndReports => 'বিক্রয় ও রিপোর্ট';

  @override
  String get salesAndReportsDescription =>
      'বিক্রয় ট্র্যাক করুন এবং বিস্তারিত রিপোর্ট তৈরি করুন';

  @override
  String get availableModules => 'উপলব্ধ মডিউলসমূহ';

  @override
  String get availableModulesDescription => 'আপনার ব্যবসার জন্য উপযোগী';

  @override
  String get inventoryManagement => 'ইনভেন্টরি ম্যানেজমেন্ট';

  @override
  String get inventoryManagementDescription =>
      'স্টক লেভেল ট্র্যাক এবং ম্যানেজ করুন';

  @override
  String get salesTracking => 'বিক্রয় ট্র্যাকিং';

  @override
  String get salesTrackingDescription => 'বিক্রয় এবং আয় মনিটর করুন';

  @override
  String get customerManagement => 'গ্রাহক ব্যবস্থাপনা';

  @override
  String get customerManagementDescription =>
      'গ্রাহকের তথ্য এবং অর্ডার ম্যানেজ করুন';

  @override
  String get reportsAndAnalytics => 'রিপোর্ট ও অ্যানালিটিক্স';

  @override
  String get reportsAndAnalyticsDescription =>
      'বিস্তারিত ব্যবসায়িক ইনসাইট তৈরি করুন';

  @override
  String get videoTutorials => 'ভিডিও টিউটোরিয়াল';

  @override
  String get videoTutorialsDescription => 'শিখুন এবং দক্ষতা অর্জন করুন';

  @override
  String get gettingStartedGuide => 'শুরু করার গাইড';

  @override
  String get someTipsToGetStarted => 'শুরু করার জন্য কিছু টিপস';

  @override
  String get learnBasicIn5Minutes => '৫ মিনিটে বেসিক শিখুন';

  @override
  String get advancedFeatures => 'এডভান্সড ফিচার';

  @override
  String get masterAdvancedFeatures => 'এডভান্সড ফিচারগুলো আয়ত্ত করুন';

  @override
  String get giveFeedback => 'আপনার মতামত দিন';

  @override
  String get feedbackDescription => 'আমাদের উন্নতির জন্য আপনার মূল্যবান মতামত';

  @override
  String get feedbackCategories => 'ফিডব্যাক ক্যাটাগরি';

  @override
  String get feedbackCategoriesDescription =>
      'আপনি কোন ধরনের ফিডব্যাক দিতে চান?';

  @override
  String get bugReport => 'বাগ রিপোর্ট';

  @override
  String get bugReportDescription => 'অ্যাপে কোন সমস্যা খুঁজে পেয়েছেন?';

  @override
  String get featureRequest => 'ফিচার রিকোয়েস্ট';

  @override
  String get featureRequestDescription => 'নতুন কোন ফিচার চান?';

  @override
  String get generalFeedback => 'সাধারণ ফিডব্যাক';

  @override
  String get generalFeedbackDescription => 'আপনার অভিজ্ঞতা শেয়ার করুন';

  @override
  String get recentFeedback => 'সাম্প্রতিক ফিডব্যাক';

  @override
  String get recentFeedbackDescription => 'অন্যান্য ব্যবহারকারীদের মতামত';

  @override
  String get appIsGreat => 'অ্যাপটি খুব ভালো';

  @override
  String get appIsGreatDescription =>
      'এই অ্যাপটি ব্যবহার করে আমার ব্যবসার অনেক উন্নতি হয়েছে';

  @override
  String get someIssues => 'কিছু সমস্যা আছে';

  @override
  String get someIssuesDescription => 'কখনও কখনও অ্যাপটি ধীর হয়ে যায়';

  @override
  String get veryHelpful => 'অত্যন্ত সহায়ক';

  @override
  String get veryHelpfulDescription => 'সাপোর্ট টিম খুব দ্রুত সাড়া দেয়';

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
  String get needToAddNewFeatures => 'অ্যাপে কিছু নতুন ফিচার যুক্ত করা দরকার';

  @override
  String get customerHasDue => 'গ্রাহক বাকি আছে';

  @override
  String get customerNoDue => 'গ্রাহক বাকি নেই';

  @override
  String get lastPurchase => 'সর্বশেষ ক্রয়';

  @override
  String get deleteCustomer => 'গ্রাহক মুছে ফেলুন';

  @override
  String get confirmDeleteCustomer =>
      'আপনি কি নিশ্চিত যে আপনি এই গ্রাহককে মুছে ফেলতে চান?';

  @override
  String get nameRequired => 'নাম অবশ্যই পূরণ করতে হবে';

  @override
  String get phoneRequired => 'ফোন নম্বর অবশ্যই পূরণ করতে হবে';

  @override
  String get add => 'যোগ করুন';

  @override
  String stockInPieces(String quantity) {
    return 'স্টকে $quantity পিস';
  }

  @override
  String get stock => 'স্টক';

  @override
  String get pieces => 'পিস';

  @override
  String serviceInitFailed(String error) {
    return 'সেবা শুরু করতে ব্যর্থ: $error';
  }

  @override
  String get backupSuccess => 'ব্যাকআপ সফল হয়েছে!';

  @override
  String backupFailed(String error) {
    return 'ব্যাকআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get restoreSuccess => 'পুনরুদ্ধার সফল হয়েছে!';

  @override
  String restoreFailed(String error) {
    return 'পুনরুদ্ধার ব্যর্থ হয়েছে: $error';
  }

  @override
  String get failedToLoadDueCustomers =>
      'বাকিদার তালিকা লোড করতে ব্যর্থ হয়েছে';

  @override
  String get paymentUpdated => 'পেমেন্ট আপডেট করা হয়েছে';

  @override
  String get failedToUpdatePayment => 'পেমেন্ট আপডেট করতে ব্যর্থ হয়েছে';

  @override
  String lastBackupDate(String date) {
    return 'সর্বশেষ ব্যাকআপ $date';
  }

  @override
  String get notifications => 'নোটিফিকেশন';

  @override
  String get enableNotifications => 'নোটিফিকেশন সক্রিয় করুন';

  @override
  String get autoBackup => 'স্বয়ংক্রিয় ব্যাকআপ';

  @override
  String get enableAutoBackup => 'স্বয়ংক্রিয় ব্যাকআপ সক্রিয় করুন';

  @override
  String get soundSettings => 'সাউন্ড সেটিংস';

  @override
  String get enableSound => 'সাউন্ড সক্রিয় করুন';

  @override
  String get vibration => 'ভাইব্রেশন';

  @override
  String get enableVibration => 'ভাইব্রেশন সক্রিয় করুন';

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
}
