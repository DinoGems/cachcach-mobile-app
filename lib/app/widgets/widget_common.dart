import 'package:cachcach/core/theme/colors.dart';
import 'package:cachcach/core/theme/icons.dart';
import 'package:cachcach/core/theme/images.dart';
import 'package:cachcach/core/theme/text_styles.dart';
import 'package:cachcach/core/utils/my_size_extensions.dart';
import 'package:cachcach/core/values/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget space({double? w, double? h}) {
  return SizedBox(
    width: w,
    height: h,
  );
}

Widget moreWidget() => const Text('・\n・\n・\n', textAlign: TextAlign.center);

Widget divider({
  double height = 1,
  double? thickness,
  Color? color = AppColors.divider,
  double? indent,
  double? endIndent,
  EdgeInsetsGeometry? margin,
}) {
  var divider = Divider(
    height: height,
    thickness: thickness ?? height,
    color: color,
    indent: indent,
    endIndent: endIndent ?? indent,
  );

  if (margin == null) return divider;

  return Padding(padding: margin, child: divider);
}

Widget buildTopBar({VoidCallback? onBack, String? title}) {
  return Stack(
    children: [
      Image.asset(
        AppImages.bgTopBar,
        fit: BoxFit.fill,
        width: Get.width,
        height: 95.h,
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.icArrowLeft,
                  width: 32.w,
                  height: 32.h,
                  color: AppColors.white,
                ),
                onPressed: onBack ??
                    () {
                      Get.back();
                    },
              ),
              space(w: 10.w),
              title != null
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.textStyleCommon.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              space(w: 42.w),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget contentWithBackgroundPattern({required Widget child}) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          AppImages.bgBottom,
          width: Get.width,
          height: 80.h,
          fit: BoxFit.fill,
        ),
      ),
      child,
    ],
  );
}

Widget gradientButton({
  double? width,
  double? height,
  double? borderRadius,
  Gradient? gradient,
  VoidCallback? onTap,
  BoxBorder? border,
  required Widget child,
}) {
  return Container(
    width: width ?? double.infinity,
    height: height ?? 50.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 14.r),
        gradient: gradient ??
            const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                AppColors.sunshade,
                AppColors.coral,
              ],
            ),
        border: border),
    child: Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: child,
      ),
    ),
  );
}

Widget normalButton({
  double? width,
  double? height,
  double? borderRadius,
  VoidCallback? onTap,
  Color? backgroundColor,
  required Widget child,
}) {
  return Container(
    width: width ?? double.infinity,
    height: height ?? 50.h,
    decoration: BoxDecoration(
      color: backgroundColor ?? AppColors.portage,
      borderRadius: BorderRadius.circular(borderRadius ?? 14.r),
    ),
    child: Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: child,
      ),
    ),
  );
}

Widget outlineButton({
  double? width,
  double? height,
  double? borderRadius,
  VoidCallback? onTap,
  BoxBorder? border,
  required Widget child,
}) {
  return Container(
    width: width ?? double.infinity,
    height: height ?? 50.h,
    decoration: BoxDecoration(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? 14.r),
      border: border ?? Border.all(color: AppColors.grey),
    ),
    child: Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: child,
      ),
    ),
  );
}

Widget popupEndGame({Function? onBack, Function? onConfirm}) {
  return popupWidget(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          space(h: 20.h),
          Text(
            "Bạn có muốn thoát?",
            style: AppTextStyle.textStyleCommon.copyWith(
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          space(h: 20.h),
          normalButton(
            onTap: () {
              Get.back();
              onBack?.call();
            },
            height: 42.h,
            backgroundColor: AppColors.orange,
            child: Center(
              child: Text(
                "Thoát mà không lưu",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          space(h: 12.h),
          gradientButton(
            onTap: () {
              onConfirm?.call();
            },
            height: 42.h,
            child: Center(
              child: Text(
                "Lưu lịch sử",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          space(h: 30.h),
        ],
      ),
    ),
  );
}

Widget popupWidget({required Widget child}) {
  return Center(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        color: AppColors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Image.asset(
                    AppImages.imgTopBarPopup,
                    width: Get.width,
                    height: 138.h,
                    fit: BoxFit.fill,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.imgLogo2,
                      width: 120.ic,
                      height: 120.ic,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.w),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          width: 28.ic,
                          height: 28.ic,
                          child: Icon(
                            Icons.close,
                            size: 24.ic,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              child
            ],
          ),
        ),
      ),
    ),
  );
}

void showRulesTruthOrDare() {
  dialogRolesGame(rules: listRulesTruthOrDare, title: "Truth or Dare");
}

void showRulesFlipCard() {
  dialogRolesGame(rules: listRulesFlipCard, title: "Lật thẻ bài");
}

void showRulesChooseRightPrice() {
  dialogRolesGame(rules: listRulesChooseRightPrice, title: "Hãy chọn giá đúng");
}

void showRulesPopIt() {
  dialogRolesGame(rules: listRulesPopIt, title: "Pop It");
}

void dialogRolesGame({required List<String> rules, required String title}) {
  Get.dialog(
    popupWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            space(h: 12.h),
            Center(
              child: Text(
                title,
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            space(h: 12.h),
            ...rules.map((String rule) {
              return componentItemRuleGame(rule);
            }).toList(),
            space(h: 40),
          ],
        ),
      ),
    ),
  );
}

Widget componentItemRuleGame(String string) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "-",
        style: AppTextStyle.textStyleCommon.copyWith(
          fontSize: 13.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      space(w: 4),
      Expanded(
        child: Text(
          string,
          style: AppTextStyle.textStyleCommon.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ),
    ],
  );
}
