import 'package:cachcach/app/widgets/widget_common.dart';
import 'package:cachcach/core/theme/images.dart';
import 'package:cachcach/routes/routes.dart';

class PlayUtils {
  static String getRouteByName(String name) {
    String route;
    switch (name) {
      case 'Lật Thẻ Bài':
        route = RouteName.cardSelectMode;
        break;
      case 'Thật Hay Thách':
        route = RouteName.selectTopic;
        break;
      // case 'Hãy Chọn Giá Đúng':
      //   route = RouteName.chooseRightPrice;
      //   break;
      case 'Pop It':
        route = RouteName.popIt;
        break;
      default:
        route = RouteName.cardSelectMode;
    }

    return route;
  }

  static String getTitleByTypeModeGame(int playType) {
    String title;
    switch (playType) {
      case 1:
        title = 'Dành cho tất cả';
        break;
      case 2:
        title = 'Dành cho những cặp đôi';
        break;
      case 3:
        title = 'Cho nhóm bạn';
        break;
      default:
        title = 'Dành cho tất cả';
    }

    return title;
  }

  static String getImageByNameAndPlayType({
    required String name,
    required int playType,
  }) {
    String urlImage;
    switch (name) {
      case 'Lật Thẻ Bài':
        urlImage = AppImages.imgPlayCard;
        break;
      case 'Thật Hay Thách':
        if (playType == 2) {
          urlImage = AppImages.imgTruthOrDareSingle;
        } else
          urlImage = AppImages.imgTruthOrDareGroup;
        break;
      // case 'Hãy Chọn Giá Đúng':
      //   urlImage = AppImages.imgChooseRightPrice;
      //   break;
      case 'Pop It':
        urlImage = AppImages.imgPopIt;
        break;
      default:
        urlImage = AppImages.imgPlayCard;
    }

    return urlImage;
  }

  static getRuleByName(String name) {
    switch (name) {
      case 'Lật Thẻ Bài':
        showRulesFlipCard();
        break;
      case 'Thật Hay Thách':
        showRulesTruthOrDare();
        break;
      // case 'Hãy Chọn Giá Đúng':
      //   showRulesChooseRightPrice();
      //   break;
      case 'Pop It':
        showRulesPopIt();
        break;
      default:
        showRulesTruthOrDare();
    }
  }
}
