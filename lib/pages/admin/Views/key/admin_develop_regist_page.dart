import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_regist_viewmodel.dart';
import 'package:epson_app/pages/admin/Views/key/admin_regist_key_view.dart';
import 'package:epson_app/pages/admin/Views/key/admin_regist_onboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDevelopRegistPage extends StatefulWidget {
  const AdminDevelopRegistPage({super.key});

  @override
  State<AdminDevelopRegistPage> createState() => _AdminDevelopRegistPageState();
}

class _AdminDevelopRegistPageState extends State<AdminDevelopRegistPage> {
  final viewmodel = GetxManager.instance<AdminRegistViewModel>();

  @override
  Widget build(BuildContext context) {
    viewmodel.pages = [const AdminRegistOnBoardView(), AdminRegistKeyView()];
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: PageView(
                  controller: viewmodel.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: viewmodel.pages,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (viewmodel.currentPage.value != 0)
                    TextButton(
                      style: buttonStyle(),
                      onPressed: viewmodel.previousPage,
                      child: const Text(
                        '이전',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  TextButton(
                    style: buttonStyle(),
                    onPressed: viewmodel.nextPage,
                    child: Text(
                      viewmodel.currentPage.value == 1 ? '가입' : '다음',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: PageViewDotIndicator(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  currentItem: viewmodel.currentPage.value,
                  count: viewmodel.pages.length,
                  unselectedColor: Theme.of(context).primaryColor,
                  selectedColor: const Color.fromARGB(255, 17, 76, 171),
                  size: const Size(10, 10),
                  unselectedSize: const Size(7, 7),
                  duration: const Duration(milliseconds: 200),
                  boxShape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return TextButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 17, 76, 171),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 40.0,
      ),
    );
  }
}
