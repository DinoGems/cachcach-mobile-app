import 'package:cachcach/app/modules/party_game/party_game_controller.dart';
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

class PartyGameScreen extends StatefulWidget {
  const PartyGameScreen({super.key});

  @override
  State<PartyGameScreen> createState() => _PartyGameScreenState();
}

class _PartyGameScreenState extends State<PartyGameScreen> {
  final controller = Get.put(PartyGameController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dimGray,
      body: contentWithBackgroundPattern(
        child: Column(
          children: [
            buildTopBar(title: "Party Game"),
            space(h: 12.h),

          ],
        ),
      ),
    );
  }

}
