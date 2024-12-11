import 'dart:math';

import 'package:cachcach/app/modules/play/flip_the_card/controller/flip_the_card_controller.dart';
import 'package:cachcach/app/widgets/widget_common.dart';
import 'package:cachcach/core/theme/colors.dart';
import 'package:cachcach/core/theme/images.dart';
import 'package:cachcach/core/theme/text_styles.dart';
import 'package:cachcach/core/utils/my_size_extensions.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';

class FlipTheCardScreen extends StatefulWidget {
  const FlipTheCardScreen({super.key});

  @override
  State<FlipTheCardScreen> createState() => _FlipTheCardScreenState();
}

class _FlipTheCardScreenState extends State<FlipTheCardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController control;

  late Animation<double> rot;

  late Animation<double> trasl;

  FlipCardController flipCardController = FlipCardController();
  FlipTheCardController controller = Get.put(FlipTheCardController());

  @override
  void initState() {
    super.initState();

    String? categoryId = Get.arguments['category_id'];
    controller.getListQuestionCollections(categoryId);

    control = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    rot = Tween<double>(
      begin: 0,
      end: 0.2 * pi,
    ).animate(control);

    trasl = Tween<double>(
      begin: 0,
      end: Get.height,
    ).animate(control);

    control.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.canDraw = true;
        flipCardController.toggleCardWithoutAnimation();
        control.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black900,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppImages.bgBottom2,
              width: Get.width,
              height: 120.h,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              buildTopBar(title: "Lật thẻ bài"),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Stack(
                          children: [
                            _buildRowRules(),
                            _buildStackCard(
                              degree: 15,
                              compareCardLength: 3,
                            ),
                            _buildStackCard(
                              degree: 15,
                              compareCardLength: 3,
                            ),
                            _buildStackCard(
                              degree: 8,
                              compareCardLength: 2,
                            ),
                            _buildStackCard(
                              degree: 0,
                              compareCardLength: 1,
                            ),
                            _buildFlipCard(),
                          ],
                        ),
                ),
              ),
              space(h: 80),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRowRules() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: InkWell(
          onTap: () {
            showRulesFlipCard();
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
      ),
    );
  }

  Widget _buildStackCard(
      {required double degree, required int compareCardLength}) {
    return Obx(
      () {
        if (controller.listQuestionCollectionsRemaining.length <
            compareCardLength) {
          return Container();
        }
        return Align(
          alignment: Alignment.center,
          child: Transform.rotate(
            alignment: Alignment.center,
            angle: degree * pi / 180,
            child: SizedBox(
              width: 280.w,
              height: 400.h,
              child: Image.asset(
                AppImages.imgFlipCard,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFlipCard({EdgeInsets? margin}) {
    return AnimatedBuilder(
      animation: control,
      builder: (BuildContext context, Widget? child) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            margin: margin,
            child: Transform.translate(
              offset: Offset(0, trasl.value),
              child: Transform(
                transform: Matrix4.rotationZ(rot.value),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    if (flipCardController.state?.isFront == true) {
                      if (controller.canDraw) {
                        controller.canDraw = false;
                        controller.getCard();
                        flipCardController.toggleCard();
                      }
                    } else {
                      if (controller.listQuestionCollectionsRemaining.isEmpty) {
                        Get.toNamed(RouteName.endGame);
                        return;
                      }
                      control.forward();
                    }
                  },
                  child: IgnorePointer(
                    child: FlipCard(
                      key: Key(1.toString()),
                      controller: flipCardController,
                      speed: 300,
                      front: _buildCardFront(),
                      back: _buildCardBack(),
                      flipOnTouch: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardBack() {
    return Container(
      width: 300.w,
      height: 480.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppImages.imgCardBackground),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          space(h: 200.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        controller.cardContent.value,
                        style: AppTextStyle.textStyleCommon.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.black,
                          fontFamily: 'iCielBeCool',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppImages.imgLogo2,
                width: 78.ic,
                height: 78.ic,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                alignment: Alignment.centerRight,
                child: Obx(
                  () => Text(
                    "${controller.getCardNumber()}/${controller.getTotal()}",
                    style: AppTextStyle.textStyleCommon.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      fontFamily: 'iCielBeCool',
                    ),
                  ),
                ),
              ),
            ],
          ),
          space(h: 14.h),
        ],
      ),
    );
  }

  Widget _buildCardFront() {
    return SizedBox(
      width: 280.w,
      height: 400.h,
      child: Image.asset(
        AppImages.imgFlipCard,
        fit: BoxFit.fill,
      ),
    );
  }
}
