// lib/app/modules/home/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:store/app/modules/home/controllers/home_controllers.dart';
import 'package:store/core/widgets/button_widget.dart';

import '../../../../core/constants/app_colors.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        title: Obx(
          () => Text(
            "Hello,${controller.isLoading.value ? '......' : controller.authController.user?.username} ",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {


              Get.dialog(
  AlertDialog(
    title: const Text(
      "Logout",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    content: const Text("Are you sure you want to log out?"),
    actions: controller.authController.isLoading.value
        ? []
        : [
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.kprimaryColor,
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await controller.logout();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.kprimaryColor,
              ),
              child: const Text("Logout"),
            ),
          ],
  ),
  barrierDismissible: false,
);

             
          
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {

          await controller.fetchProducts();
          
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => controller.searchProducts(value),
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        prefixIcon: const Icon(
                          Remix.search_line,
                        ), // Remix search icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.products.isEmpty) {
                  return const Center(child: Text("No products found"));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.45,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.kGreyShade),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    product.image,
                                    height: 150.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.category,
                                style: TextStyle(
                                  color: AppColors.kTextGrey.withOpacity(.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "₹${product.price}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  'Only Left ${product.count}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: double.maxFinite,
                                child: ButtonWidget(
                                  text: "View",
                                  onPressed: () {
                                    Get.toNamed(
                                      '/product-detail',
                                      arguments: {'id': product.id},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
