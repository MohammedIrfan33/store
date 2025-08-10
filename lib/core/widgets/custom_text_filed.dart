import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.labelText,
    this.sufficIcon,
    
    this.validator,
    this.obscureText = false, 
  });

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final String labelText;

  final Widget ? sufficIcon;

  final bool obscureText;
  final String? Function(String?)? validator;


  OutlineInputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(color: color, width: 1.0),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.kprimaryColor),
            hintText: hintText,
            suffixIcon: sufficIcon,
            hintStyle: TextStyle(color: Colors.grey),
            border: _buildInputBorder(Colors.transparent),
            focusedBorder: _buildInputBorder(AppColors.kprimaryColor),
            enabledBorder: _buildInputBorder(Colors.grey.shade300),
          ),
        ),
      ],
    );
  }
}
