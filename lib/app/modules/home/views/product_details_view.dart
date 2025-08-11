import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:store/app/modules/home/controllers/home_controllers.dart';
import 'package:store/core/widgets/button_widget.dart';
import '../../../../core/constants/app_colors.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    final int productId = Get.arguments['id'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductDetail(productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Obx(() {
          final title = controller.selectedProduct.value?.title ?? "Loading...";
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Remix.arrow_left_s_line, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                icon: Icon(Remix.shopping_cart_line, color: Colors.black),
                onPressed: () {},
              ),
            ],
          );
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.kprimaryColor),
          );
        }
        if (controller.selectedProduct.value == null) {
          return const Center(child: Text("Product not found"));
        }

        final product = controller.selectedProduct.value!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 30.h, bottom: 30),
                width: double.infinity,

                child: Image.network(
                  product.image,

                  fit: BoxFit.contain, // keeps aspect ratio, no stretching
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),

                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4), // shadow below the container
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text(product.rate.toString()),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(color: AppColors.kTextGrey),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹${product.price}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        ButtonWidget(onPressed: () {}, text: 'Add to cart'),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
