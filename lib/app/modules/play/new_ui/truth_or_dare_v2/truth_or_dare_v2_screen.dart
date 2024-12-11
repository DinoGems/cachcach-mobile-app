import 'package:cachcach/app/modules/play/new_ui/truth_or_dare_v2/controller/truth_or_dare_v2_controller.dart';
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

class TruthOrDareV2Screen extends StatefulWidget {
  const TruthOrDareV2Screen({super.key});

  @override
  State<TruthOrDareV2Screen> createState() => _TruthOrDareV2ScreenState();
}

class _TruthOrDareV2ScreenState extends State<TruthOrDareV2Screen> {
  final controller = Get.put(TruthOrDareV2Controller());
  FlipCardController flipTruthController = FlipCardController();
  FlipCardController flipDareController = FlipCardController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print(Get.arguments);
      final categoryId = Get.arguments['category_id'];
      controller.getListQuestionCollections(categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black900,
      body: Column(
        children: [
          buildTopBar(title: "Thật hay thách"),
          space(h: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                _buildRowRules(),
              ],
            ),
          ),
          space(h: 20.h),
          Expanded(child: _buildTruthOrDare()),
          _buildButtonNext(),
        ],
      ),
    );
  }

  Widget _buildTruthOrDare() {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: AppColors.white,
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTruth(),
              space(h: 20.h),
              _buildDare(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTruth() {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () {
        if (controller.listQuestionCollections.isEmpty) {
          return;
        }

        if (flipTruthController.state?.isFront == true) {
          if (controller.questionSelected.value != null) {
            return;
          }
          controller.randomQuestion();
          flipTruthController.toggleCard();
        }
      },
      child: IgnorePointer(
        child: FlipCard(
          key: Key(1.toString()),
          controller: flipTruthController,
          speed: 300,
          front: Image.asset(
            AppImages.imgTruthV2,
            width: 340.w,
            height: 240.h,
          ),
          back: SizedBox(
            width: 340.w,
            height: 240.h,
            child: Stack(
              children: [
                Image.asset(
                  AppImages.imgBgContent,
                  width: 340.w,
                  height: 240.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.w, vertical: 16.h),
                  child: Center(
                    child: Obx(
                      () => Text(
                        controller.contentTruth.value,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.textStyleCommon.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          fontFamily: 'iCielBeCool',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          flipOnTouch: false,
        ),
      ),
    );
  }

  Widget _buildDare() {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () {
        if (controller.listQuestionCollections.isEmpty) {
          return;
        }

        if (flipDareController.state?.isFront == true) {
          if (controller.questionSelected.value != null) {
            return;
          }

          controller.randomQuestion();
          flipDareController.toggleCard();
        }
      },
      child: IgnorePointer(
        child: FlipCard(
          key: Key(1.toString()),
          controller: flipDareController,
          speed: 300,
          front: Image.asset(
            AppImages.imgDareV2,
            width: 340.w,
            height: 240.h,
          ),
          back: SizedBox(
            width: 340.w,
            height: 240.h,
            child: Stack(
              children: [
                Image.asset(
                  AppImages.imgBgContent,
                  width: 340.w,
                  height: 240.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h),
                  child: Center(
                    child: Obx(
                      () => Text(
                        controller.contentDare.value,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.textStyleCommon.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          fontFamily: 'iCielBeCool',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          flipOnTouch: false,
        ),
      ),
    );
  }

  Widget _buildButtonNext() {
    return SizedBox(
      height: 90.h,
      child: Center(
        child: Obx(
          () {
            if (controller.isEndGame.value) {
              return gradientButton(
                onTap: () {
                  Get.back();
                },
                width: 170.w,
                child: Center(
                  child: Text(
                    "Kết thúc",
                    style: AppTextStyle.textStyleCommon.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            }

            if (controller.questionSelected.value == null) {
              return Container();
            }

            return gradientButton(
              onTap: () {
                if (flipTruthController.state?.isFront == false) {
                  flipTruthController.toggleCard();
                }

                if (flipDareController.state?.isFront == false) {
                  flipDareController.toggleCard();
                }

                controller.removeItemSelected();
              },
              width: 170.w,
              child: Center(
                child: Text(
                  "Tiếp theo",
                  style: AppTextStyle.textStyleCommon.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRowRules() {
    return Align(
      alignment: Alignment.topRight,
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
    );
  }
}
