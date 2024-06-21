import 'package:epson_app/pages/admin/Controller/admin_sigin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSignPage extends StatelessWidget {
  const AdminSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminSignViewModel adminSignViewModel =
        Get.find<AdminSignViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'create_account'.tr,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => TextField(
                  controller: adminSignViewModel.emailController.value,
                  onChanged: (value) {
                    adminSignViewModel.checkEmail(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'email'.tr,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: null,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: adminSignViewModel.passwordController.value,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password'.tr,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: adminSignViewModel.confirmPasswordController.value,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'cofirm_password'.tr,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: adminSignViewModel.addressController.value,
                decoration: InputDecoration(
                  hintText: 'address'.tr,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 회원가입 버튼 클릭 시 처리할 로직
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'sign_up'.tr,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Powered by Epson',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
