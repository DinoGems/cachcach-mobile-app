import 'package:cachcach/app/widgets/widget_common.dart';
import 'package:cachcach/core/theme/colors.dart';
import 'package:cachcach/core/theme/images.dart';
import 'package:cachcach/core/theme/text_styles.dart';
import 'package:cachcach/core/utils/my_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseRightPriceScreen extends StatefulWidget {
  const ChooseRightPriceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseRightPriceScreenState();
}

class _ChooseRightPriceScreenState extends State<ChooseRightPriceScreen> {
  int round = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black900,
      body: Column(
        children: [
          buildTopBar(title: "Hãy chọn giá đúng"),
          space(h: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Vòng: $round/3',
                        style: AppTextStyle.textStyleCommon.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                _buildRowRules(),
              ],
            ),
          ),
          space(h: 65.h),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent, // Màu trong suốt (bên trái)
                    AppColors.brightYellow,
                    Colors.transparent, // Màu vàng (ở giữa)
                  ],
                ),
              ),
              alignment: Alignment.center,
              width: 152,
              height: 30,
              child: const Text(
                "1",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          space(h: 24.h),
          Row(children: [
            Expanded(
              child: Image.asset(
                AppImages.imgCupAround,
                width: 178.ic,
                height: 174.ic,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Image.asset(
                AppImages.imgCupAround,
                width: 178.ic,
                height: 174.ic,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Image.asset(
                AppImages.imgCupAround,
                width: 178.ic,
                height: 174.ic,
                fit: BoxFit.fitWidth,
              ),
            ),
          ]),
          space(h: 38.h),
          _rowButtons()
        ],
      ),
    );
  }

  Widget _buildRowRules() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          showRulesChooseRightPrice();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Luật chơi",
              style: AppTextStyle.textStyleCommon.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
            space(w: 6.w),
            Icon(
              Icons.info,
              size: 18.ic,
              color: AppColors.blue,
            )
          ],
        ),
      ),
    );
  }

  Widget _rowButtons() {
    return Container(
      alignment: Alignment.center,
      // height: 255,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            normalButton(
              width: 108.w,
              height: 28.h,
              borderRadius: 50.r,
              backgroundColor: AppColors.brightYellow,
              onTap: () {},
              child: Center(
                child: Text(
                  "Bắt đầu",
                  style: AppTextStyle.textStyleCommon.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black900,
                  ),
                ),
              ),
            ),
            space(h: 60.h),
            _turnButton(turn: '1/3', title: 'Tự mình rút bài'),
            space(h: 30.h),
            _turnButton(turn: '2/3', title: 'Người bên trái rút bài'),
            space(h: 30.h),
            _turnButton(turn: '3/3', title: 'Chỉ định người rút bài'),
          ]),
        ],
      ),
    );
  }

  Widget _turnButton({required String turn, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        normalButton(
          width: 250.w,
          height: 36.h,
          borderRadius: 50.r,
          backgroundColor: AppColors.brightYellow,
          onTap: () {},
          child: Row(
            children: [
              space(w: 16.w),
              Text(
                turn,
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              space(w: 12.w),
              Text(
                title,
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
