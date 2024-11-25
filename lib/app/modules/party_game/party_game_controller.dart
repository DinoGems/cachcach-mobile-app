import 'package:cachcach/core/utils/top_level_function.dart';
import 'package:cachcach/model/game_mode_category.dart';
import 'package:cachcach/model/question_collections.dart';
import 'package:cachcach/services/repositories/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PartyGameController extends GetxController {
  RxInt pageSelected = 0.obs;
  GameModeCategory? categorySelected;

  RxList<QuestionCollections> listQuestionCollections = RxList([]);
  List<QuestionCollections> listQuestionCollectionsRandom = [];

  RxBool isLoading = false.obs;
  RxList<GameModeCategory> listCategory = RxList([]);
  CancelToken cancelToken = CancelToken();

  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }

  Future getListCategory(int? id) async {
    try {
      isLoading.value = true;
      listCategory.value = await HomeRepository.getGameModeCategories(
          id: id, cancelToken: cancelToken);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleException(e);
    }
  }

  void reset() {
    listQuestionCollectionsRandom
        .assignAll(listQuestionCollections.map((element) => element).toList());
  }
}
