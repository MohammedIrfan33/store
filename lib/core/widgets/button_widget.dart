import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';




class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kprimaryColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r), 
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: AppColors.kWhite,fontWeight: FontWeight.w600,fontSize: 16.sp),
      ),
    );
  }
}
