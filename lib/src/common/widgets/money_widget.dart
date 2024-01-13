import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_moolah/src/common/app_colors.dart';
import 'package:mega_moolah/src/common/app_images.dart';

class MoneyWidget extends StatelessWidget {
  const MoneyWidget({
    super.key,
    required this.money,
    this.isClosed = false,
  });

  final int money;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 127.w,
      height: 38.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38.r),
        color: isClosed ? Colors.grey.shade800 : AppColors.mainColor,
        border: Border.all(
          color: Colors.black,
          width: 2.w,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.money,
            width: 33.w,
            height: 32.h,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 13.w),
          Text(
            '$money',
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
