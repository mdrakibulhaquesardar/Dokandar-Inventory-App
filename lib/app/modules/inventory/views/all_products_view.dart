import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_theme_config.dart';
import '../controllers/AllProductController.dart';

class AllProductsView extends GetView<AllProductController> {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Text(
                'আপনার পণ্যসমূহ',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
                onPressed: () {
                  //TODO: Implement search functionality
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: themeConfig.getSurfaceColor(isDarkMode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return _buildInfoCard(
                        context,
                        'মোট পণ্য',
                        '${controller.products.length}টি',
                        Icons.inventory_2,
                        themeConfig,
                        isDarkMode,
                      );
                    }),
                    _buildInfoCard(
                      context,
                      'স্টক আউট',
                      '0টি',
                      Icons.warning,
                      themeConfig,
                      isDarkMode,
                    ),
                    Obx(() {
                      return _buildInfoCard(
                        context,
                        'মোট মূল্য',
                        '৳${controller.products.fold(0.0, (sum, item) => sum + item.unitPrice)}',
                        Icons.attach_money,
                        themeConfig,
                        isDarkMode,
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'সাম্রতিক পণ্যসমূহ',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: themeConfig
                              .getPrimaryColor(isDarkMode)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.inventory,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        product.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'স্টক: ${product.stockQuantity} পিস',
                            style: TextStyle(
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                          Text(
                            'মূল্য: ৳${product.unitPrice}',
                            style: TextStyle(
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.85,
                                  decoration: BoxDecoration(
                                    color: themeConfig
                                        .getBackgroundColor(isDarkMode),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'পণ্য সম্পাদনা করুন',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: themeConfig
                                              .getTextPrimaryColor(isDarkMode),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller:
                                                    TextEditingController(
                                                        text: product.name),
                                                decoration: InputDecoration(
                                                  labelText: 'পণ্যের নাম',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                onChanged: (value) =>
                                                    product.name = value,
                                              ),
                                              const SizedBox(height: 16),
                                              DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'ক্যাটাগরি',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                ),
                                                items: controller.allCategories
                                                    .map((category) => DropdownMenuItem(
                                                  value: category.name,
                                                  child: Text(category.name),
                                                ))
                                                    .toList(),
                                                onChanged: (value) =>
                                                controller.newProduct['category'] = value,
                                              ),
                                              const SizedBox(height: 16),
                                              TextField(
                                                controller:
                                                    TextEditingController(
                                                        text: product
                                                            .stockQuantity
                                                            .toString()),
                                                decoration: InputDecoration(
                                                  labelText: 'স্টক পরিমাণ',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) => product
                                                        .stockQuantity =
                                                    double.tryParse(value) ?? 0,
                                              ),
                                              const SizedBox(height: 16),
                                              TextField(
                                                controller:
                                                    TextEditingController(
                                                        text: product.unitPrice
                                                            .toString()),
                                                decoration: InputDecoration(
                                                  labelText: 'বিক্রয় মূল্য',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) => product
                                                        .unitPrice =
                                                    double.tryParse(value) ?? 0,
                                              ),
                                              const SizedBox(height: 16),
                                              TextField(
                                                controller:
                                                    TextEditingController(
                                                        text: product
                                                            .buyingPrice
                                                            .toString()),
                                                decoration: InputDecoration(
                                                  labelText: 'ক্রয় মূল্য',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) => product
                                                        .buyingPrice =
                                                    double.tryParse(value) ?? 0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text(
                                              'বাতিল করুন',
                                              style: TextStyle(
                                                color: themeConfig
                                                    .getTextSecondaryColor(
                                                        isDarkMode),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              controller.updateProduct(product);
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: themeConfig
                                                  .getPrimaryColor(isDarkMode),
                                              foregroundColor: themeConfig
                                                  .getBackgroundColor(
                                                      isDarkMode),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text('সংরক্ষণ করুন'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'পণ্য মুছে ফেলুন',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    'আপনি কি নিশ্চিত যে আপনি এই পণ্যটি মুছে ফেলতে চান?',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'না',
                                        style: TextStyle(
                                          color:
                                              themeConfig.getTextSecondaryColor(
                                                  isDarkMode),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.deleteProduct(product.id);
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text('হ্যাঁ, মুছে ফেলুন'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        foregroundColor: themeConfig.getTextPrimaryColor(isDarkMode),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: themeConfig.getBackgroundColor(isDarkMode),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'নতুন পণ্য যোগ করুন',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'পণ্যের নাম',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) =>
                                controller.newProduct['name'] = value,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'ক্যাটাগরি',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: controller.allCategories
                                .map((category) => DropdownMenuItem(
                                      value: category.name,
                                      child: Text(category.name),
                                    ))
                                .toList(),
                            onChanged: (value) =>
                                controller.newProduct['category'] = value,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'স্টক পরিমাণ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                controller.newProduct['stockQuantity'] =
                                    double.tryParse(value) ?? 0,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'বিক্রয় মূল্য',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                controller.newProduct['unitPrice'] =
                                    double.tryParse(value) ?? 0,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'ক্রয় মূল্য',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                controller.newProduct['buyingPrice'] =
                                    double.tryParse(value) ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'বাতিল করুন',
                          style: TextStyle(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          controller.saveNewProduct();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              themeConfig.getPrimaryColor(isDarkMode),
                          foregroundColor:
                              themeConfig.getBackgroundColor(isDarkMode),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('সংরক্ষণ করুন'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        label: Text(
          'পণ্য যোগ করুন',
          style: TextStyle(
            color: themeConfig.getBackgroundColor(isDarkMode),
          ),
        ),
        icon: Icon(
          Icons.add,
          color: themeConfig.getBackgroundColor(isDarkMode),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String value,
      IconData icon, AppThemeConfig themeConfig, bool isDarkMode) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: themeConfig.getPrimaryColor(isDarkMode),
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }
}
