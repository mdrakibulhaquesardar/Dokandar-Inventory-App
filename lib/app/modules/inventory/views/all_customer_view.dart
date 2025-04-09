import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AllCustomerView extends GetView {
  const AllCustomerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllCustomerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AllCustomerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
