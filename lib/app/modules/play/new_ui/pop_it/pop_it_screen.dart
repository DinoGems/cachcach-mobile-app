import 'dart:async';
import 'package:cachcach/core/values/consts.dart';
import 'package:cachcach/routes/routes.dart';
import 'package:confetti/confetti.dart';

import 'package:cachcach/app/modules/play/widgets/confetti.dart';
import 'package:cachcach/app/widgets/widget_common.dart';
import 'package:cachcach/core/theme/colors.dart';
import 'package:cachcach/core/theme/images.dart';
import 'package:cachcach/core/theme/text_styles.dart';
import 'package:cachcach/core/utils/my_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ItemImage {
  late String value;
  late int index;
}

class PopItScreen extends StatefulWidget {
  const PopItScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PopItScreenState();
}

class _PopItScreenState extends State<PopItScreen> {
  late ConfettiController _controllerTopCenter;
  List<String> listBegin = List.from(listBeginConst);
  List<String> listResult = List.from(listDefaultConst);
  List<String> listError = [];

  List<int> answerGame = [];
  List<int> answerUser = [];

  int round = 1;
  int _countdownDisplay = 5;
  int _countdownReply = 10;

  bool isReply = false;
  bool isShowError = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  void incrementRound() {
    setState(() {
      round++;
    });
  }

  void defaultRound() {
    setState(() {
      round = 1;
    });
  }

  void startCountdownDisplay() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownDisplay > 0) {
          _countdownDisplay--;
        } else {
          timer.cancel();
          _countdownReply = 10;
          isReply = !isReply;
          startCountdownReply();
        }
      });
    });
  }

  void startCountdownReply() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownReply > 0) {
          _countdownReply--;
        } else {
          timer.cancel();
          bool allElementsMatch = answerGame.length == answerUser.length &&
              answerUser.every((element) => answerGame.contains(element));
          if (allElementsMatch) {
            _controllerTopCenter.play();
            if (round < 3) {
              round++;
              isReply = !isReply;
              isPlaying = false;
              _countdownDisplay = 5 - round;
            } else {
              startCountdownResult(
                  "Bạn đã thắng cả 3 vòng, bạn là người có quyền chỉ định người rút bài!");
            }
          } else {
            getListError();
            isShowError = true;
            if (round == 1) {
              startCountdownResult("Bạn quá ăn hại, bạn là người rút bài!");
            } else if (round == 2) {
              startCountdownResult(
                  "Bạn không qua vòng 2 nên bạn vẫn là người rút bài!");
            } else {
              startCountdownResult("Người bên trái bạn rút bài!");
            }
          }
        }
      });
    });
  }

  void startCountdownResult(String title) {
    int countdown = 2;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
      } else {
        timer.cancel();
        dialogResult(title);
        resetGame();
      }
    });
  }

  void shuffle() {
    setState(() {
      isPlaying = true;
      answerGame = [];
      answerUser = [];
      listBegin.shuffle();
      listResult = List.from(listDefaultConst);
      for (int i = 0; i < listBegin.length; i++) {
        if (listBegin[i] == "yellow") {
          answerGame.add(i);
        }
      }
    });
  }

  void changeAnswerUser(int index) {
    setState(() {
      listResult[index] = listResult[index] == "black" ? "yellow" : "black";
      int indexFind = answerUser.indexWhere((element) => element == index);
      if (indexFind > -1) {
        answerUser.removeAt(indexFind);
      } else {
        answerUser.add(index);
      }
    });
  }

  void getListError() {
    setState(() {
      List<int> differentItems =
          answerUser.toSet().difference(answerGame.toSet()).toList();

      listError = listBegin;
      differentItems.forEach((index) {
        listError[index] = "red";
      });
    });
  }

  void resetGame() {
    setState(() {
      listBegin = List.from(listBeginConst);
      listResult = List.from(listDefaultConst);
      listError = [];

      answerGame = [];
      answerUser = [];

      round = 1;
      _countdownDisplay = 5;
      _countdownReply = 10;

      isReply = false;
      isShowError = false;
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black900,
      body: Column(
        children: [
          buildTopBar(title: "Pop It"),
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
          // space(h: 65.h),
          confetti(_controllerTopCenter),
          _widgetCountDown(isReply),
          space(h: 24.h),
          _imageButton(countdown: _countdownDisplay, showErr: isShowError),
          space(h: 38.h),
          _rowButtons(),
        ],
      ),
    );
  }

  Widget _widgetCountDown(bool isReply) {
    int countdown = isReply ? _countdownReply : _countdownDisplay;
    return Align(
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
        child: Text(
          '$countdown s',
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _imageButton({required int countdown, required bool showErr}) {
    List<String> listImg = [];
    if (showErr) {
      listImg = listError;
    } else {
      listImg = countdown > 0 ? listBegin : listResult;
    }
    List<Map<String, dynamic>> listImageHasIndex = [];
    listImg.asMap().forEach((index, value) {
      listImageHasIndex.add({'value': value, 'index': index});
    });

    Widget _rowImage(List<Map<String, dynamic>> list) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...list.map((Map<String, dynamic> item) {
            String imagePath = item['value'] == "black"
                ? AppImages.imgBlackPopIt
                : item['value'] == "yellow"
                    ? AppImages.imgYellowPopIt
                    : AppImages.imgRedPopIt;

            return GestureDetector(
              onTap: () {
                changeAnswerUser(item['index']);
              },
              child: Image.asset(
                imagePath,
                width: 66.ic,
                height: 60.ic,
                fit: BoxFit.fitWidth,
              ),
            );
          }).toList(),
        ],
      );
    }

    return Column(children: [
      _rowImage(listImageHasIndex.sublist(0, 3)),
      _rowImage(listImageHasIndex.sublist(3, listImageHasIndex.length - 3)),
      _rowImage(listImageHasIndex.sublist(
          listImageHasIndex.length - 3, listImageHasIndex.length)),
    ]);
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
              width: 150.w,
              height: 28.h,
              borderRadius: 50.r,
              backgroundColor: AppColors.brightYellow,
              onTap: () {
                if (!isPlaying) {
                  shuffle();
                  startCountdownDisplay();
                }
              },
              child: Center(
                child: Text(
                  'Bắt đầu vòng $round',
                  style: AppTextStyle.textStyleCommon.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black900,
                  ),
                ),
              ),
            ),
            space(h: 60.h),
            _turnButton(turn: '1/3', title: 'Tự mình rút bài 2', round: round),
            space(h: 30.h),
            _turnButton(
                turn: '2/3', title: 'Người bên trái rút bài', round: round),
            space(h: 30.h),
            _turnButton(
                turn: '3/3', title: 'Chỉ định người rút bài', round: round),
          ]),
        ],
      ),
    );
  }

  Widget _turnButton(
      {required String turn, required String title, required int round}) {
    bool choose = (turn == "1/3" && round == 1) ||
        (turn == "2/3" && round == 2) ||
        (turn == "3/3" && round == 3);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        normalButton(
          width: 250.w,
          height: 36.h,
          borderRadius: 50.r,
          backgroundColor:
              choose ? AppColors.brightYellow : const Color(0xFF8D6311),
          onTap: () {},
          child: Row(
            children: [
              space(w: 16.w),
              Text(
                turn,
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: choose
                      ? AppColors.white
                      : AppColors.white.withOpacity(0.7),
                ),
              ),
              space(w: 12.w),
              Text(
                title,
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: choose
                      ? AppColors.black900
                      : AppColors.black900.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRowRules() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          showRulesPopIt();
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

  void dialogResult(String title) {
    Get.dialog(popupWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            space(h: 12.h),
            Center(
              child: Text(
                "Kết quả",
                style: AppTextStyle.textStyleCommon.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            space(h: 12.h),
            Row(
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
                    title,
                    style: AppTextStyle.textStyleCommon.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            space(h: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      RouteName.flipTheCard,
                      arguments: {"category_id": '1'},
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brightYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    "Lật bài",
                    style: AppTextStyle.textStyleCommon.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            space(h: 40),
          ],
        ),
      ),
    ));
  }
}
