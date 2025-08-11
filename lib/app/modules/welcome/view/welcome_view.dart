import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:store/core/constants/app_colors.dart';

import '../../../../core/widgets/button_widget.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context); // for responsive sizes

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [

            SizedBox(height: 20,),
            
            Container(
              margin: EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  'assets/images/welcome.jpg',
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.h),

           
            Text(
              "Welcome to Store",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.h),

           
            Text(
                 "Discover amazing deals and get everything you need in one place. Your favorite products are just a tap away!",

              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.kTextGrey,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),
            SizedBox(
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                text: "Get Started",
                onPressed: () {

                  Get.offAndToNamed('/login');
                 
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
