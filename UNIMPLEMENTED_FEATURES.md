# Unimplemented Features List

এই ফাইলটিতে অ্যাপের সেই সব features-এর তালিকা দেওয়া আছে যেগুলোর UI আছে কিন্তু functionality implement করা হয়নি।

## 1. 🔍 Barcode/QR Code Scanner (Sell Module)
**Location:** `lib/app/modules/sell/views/sell_view.dart` (Line 68-70)
- **Status:** UI আছে (QR code scanner icon button)
- **Issue:** `onPressed` handler ফাঁকা, শুধু TODO comment আছে
- **Functionality Needed:** 
  - Barcode/QR code scan করার জন্য camera access
  - Scanned code থেকে product খুঁজে বের করা
  - Product automatically cart-এ add করা

## 2. 🔔 Notifications System (Home Module)
**Location:** `lib/app/modules/home/views/home_view.dart` (Line 317-354)
- **Status:** UI আছে (notification icon with badge)
- **Issue:** `_showNotifications` function শুধু mock data দেখায়
- **Functionality Needed:**
  - Real-time notifications system
  - Stock alerts notifications
  - New order notifications
  - Notification storage (Isar database)
  - Notification read/unread status
  - Notification clearing functionality

## 3. 👥 Supplier Management Navigation (Inventory Module)
**Location:** `lib/app/modules/inventory/views/inventory_view.dart` (Line 296-298)
- **Status:** UI আছে কিন্তু navigation নেই
- **Issue:** Case 3-এ শুধু placeholder comment আছে, `Get.toNamed(Routes.ALL_SUPPLIERS)` call করা হয়নি
- **Functionality Needed:**
  - Navigation to All Suppliers screen
  - Note: All Suppliers screen already implemented, just need to add navigation

## 4. 🔍 Search Filter Functionality (Search Module)
**Location:** `lib/app/modules/home/views/search_view.dart` (Line 211-272)
- **Status:** Filter UI আছে (Filter bottom sheet)
- **Issue:** Filter options আছে কিন্তু actual filtering logic incomplete হতে পারে
- **Functionality Needed:**
  - Verify filter actually filters search results
  - Category-based filtering
  - Price range filtering
  - Stock status filtering

## 5. 📊 Report Export Options (Report Generator)
**Location:** `lib/app/modules/inventory/views/report_generator_view.dart`
- **Status:** Report generation আছে
- **Issue:** Check if export to Excel/CSV functionality exists
- **Functionality Needed:**
  - Export reports to Excel
  - Export reports to CSV
  - Email reports directly

## 6. 🔐 Backup/Restore Advanced Features (Settings)
**Location:** `lib/app/modules/setting/views/setting_view.dart`
- **Status:** Basic backup/restore আছে
- **Issue:** Check for cloud backup, scheduled backups
- **Functionality Needed:**
  - Cloud backup (Google Drive, Dropbox)
  - Scheduled automatic backups
  - Backup encryption

## Summary

### High Priority (Core Features):
1. ✅ **Supplier Management Navigation** - শুধু navigation যোগ করতে হবে
2. 🔔 **Notifications System** - Full implementation প্রয়োজন
3. 🔍 **Barcode Scanner** - Core feature for sales

### Medium Priority:
4. 🔍 **Search Filter Enhancement** - Verify and enhance filtering
5. 📊 **Report Export** - Additional export formats

### Low Priority:
6. 🔐 **Advanced Backup Features** - Cloud backup, scheduling

---

**Note:** এই তালিকাটি codebase analysis এর উপর ভিত্তি করে তৈরি করা হয়েছে। কিছু features partially implemented হতে পারে, সেগুলো verify করা প্রয়োজন।


