import 'package:cachcach/app/modules/profile/controller/profile_controller.dart';
import 'package:cachcach/app/widgets/widget_common.dart';
import 'package:cachcach/core/theme/colors.dart';
import 'package:cachcach/core/theme/images.dart';
import 'package:cachcach/core/theme/text_styles.dart';
import 'package:cachcach/core/utils/my_size_extensions.dart';
import 'package:cachcach/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.imgTopBarPopup,
                  width: Get.width,
                  // height: 139.h,
                  fit: BoxFit.fill,
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.imgLogo2,
                      width: 190.w,
                      height: 190.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            space(h: 10.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 50.h),
                shrinkWrap: true,
                children: [
                  _buildNotification(),
                  space(h: 24.h),
                  _buildLanguage(),
                  space(h: 24.h),
                  // _buildSwitchTheme(),
                  _buildContactSupport(),
                  space(h: 24.h),
                  _buildPolicy(),
                  space(h: 12.h),
                  _buildTermOfUse(),
                  // space(h: 12.h),
                  // _buildChangePassword(),
                  // _buildDeleteAccount(),
                  // space(h: 12.h),
                  // _buildLogout(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommon(
      {required Widget child, double? height, VoidCallback? onTap}) {
    return Container(
      height: height ?? 40.h,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildLogout() {
    return _buildCommon(
        child: Row(
          children: [
            space(w: 40.w),
            Expanded(
              child: Text(
                "Đăng xuất",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () {
          showPopupLogout();
        });
  }

  void showPopupLogout() {
    Get.dialog(
      popupWidget(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              space(h: 20.h),
              Text(
                "Bạn có muốn đăng xuất?",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              space(h: 90.h),
              normalButton(
                onTap: () {
                  controller.logout();
                },
                backgroundColor: AppColors.orange,
                child: Center(
                  child: Text(
                    "Đăng xuất",
                    style: AppTextStyle.textStyleCommon.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteSmoke,
                    ),
                  ),
                ),
              ),
              space(h: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  void showPopupDeleteAccount() {
    Get.dialog(
      popupWidget(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              space(h: 20.h),
              Text(
                "Bạn có muốn xóa tài khoàn?",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              space(h: 20.h),
              Text(
                "Sau khi xóa tài khoản, hệ thống sẽ tự đăng xuất và xóa hết mọi dữ liệu!",
                textAlign: TextAlign.center,
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
              space(h: 20.h),
              normalButton(
                onTap: () {
                  Get.back();
                },
                backgroundColor: AppColors.orange,
                child: Center(
                  child: Text(
                    "Đăng xuất",
                    style: AppTextStyle.textStyleCommon.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteSmoke,
                    ),
                  ),
                ),
              ),
              space(h: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangePassword() {
    return _buildCommon(
        child: Row(
          children: [
            space(w: 40.w),
            Expanded(
              child: Text(
                "Đổi mật khẩu",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () {});
  }

  Widget _buildDeleteAccount() {
    return _buildCommon(
        child: Row(
          children: [
            space(w: 40.w),
            Expanded(
              child: Text(
                "Xóa tài khoản",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () {
          showPopupDeleteAccount();
        });
  }

  Widget _buildContactSupport() {
    return _buildCommon(
        height: 60.h,
        child: Row(
          children: [
            SizedBox(
              width: 44.w,
              child: Icon(
                Icons.contact_mail,
                size: 28.ic,
                color: AppColors.orange,
              ),
            ),
            space(w: 10.w),
            Expanded(
              child: Text(
                "Liên hệ hỗ trợ",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'info.cachcach@gmail.com',
            query: encodeQueryParameters(<String, String>{
              'subject': 'Support Cach Cach',
            }),
          );
          launchUrl(emailLaunchUri);
        });
  }

  Widget _buildPolicy() {
    return _buildCommon(
        height: 60.h,
        child: Row(
          children: [
            SizedBox(
              width: 44.w,
              child: Icon(
                Icons.policy,
                size: 28.ic,
                color: AppColors.orange,
              ),
            ),
            space(w: 10.w),
            Expanded(
              child: Text(
                "Chính sách hoạt động",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () async {
          final Uri url = Uri.parse('https://cachcach.org/policy');
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        });
  }

  Widget _buildTermOfUse() {
    return _buildCommon(
        height: 60.h,
        child: Row(
          children: [
            SizedBox(
              width: 44.w,
              child: Icon(
                Icons.policy,
                size: 28.ic,
                color: AppColors.orange,
              ),
            ),
            space(w: 10.w),
            Expanded(
              child: Text(
                "Điều khoản sử dụng",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () async {
          final Uri url = Uri.parse('https://cachcach.org/privacy');
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        });
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget _buildLanguage() {
    return _buildCommon(
        height: 60.h,
        child: Row(
          children: [
            SizedBox(
              width: 40.w,
              child: Icon(
                Icons.language,
                size: 32.ic,
                color: AppColors.orange,
              ),
            ),
            space(w: 10.w),
            // SizedBox(
            //   width: 40.w,
            //   child: Image.asset(
            //     AppImages.imgLanguage,
            //     width: 32.ic,
            //     height: 32.ic,
            //   ),
            // ),
            Expanded(
              child: Text(
                "Ngôn ngữ",
                style: AppTextStyle.textStyleCommon.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.crusta,
              size: 20.ic,
            ),
            space(w: 10.w),
          ],
        ),
        onTap: () {
          Get.toNamed(RouteName.language);
        });
  }

  Widget _buildNotification() {
    return _buildCommon(
      height: 60.h,
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            child: Icon(
              Icons.notifications_outlined,
              size: 32.ic,
              color: AppColors.orange,
            ),
          ),
          space(w: 10.w),
          Expanded(
            child: Text(
              "Bật thông báo",
              style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
            ),
          ),
          space(w: 10.w),
          Obx(
            () => CupertinoSwitch(
              value: controller.enableNotification.value,
              thumbColor: AppColors.white,
              activeColor: AppColors.orange,
              onChanged: (value) {
                controller.enableNotification.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTheme() {
    return _buildCommon(
      child: Row(
        children: [
          space(w: 40.w),
          Expanded(
            child: Text(
              "Chế độ tối",
              style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
            ),
          ),
          space(w: 10.w),
          CupertinoSwitch(
              value: false,
              thumbColor: AppColors.crusta,
              onChanged: (value) {}),
        ],
      ),
    );
  }
}
