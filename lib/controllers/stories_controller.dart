import 'package:drops/repositories/stories_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:drops/entities/story.dart';

class StoriesController extends GetxController {
  final StoriesRepository repo = Get.find<StoriesRepository>();
  var stories = [].obs;

  @override
  void onInit() {
    getStories();
    super.onInit();
  }

  void getStories() async{
    print("Getting stories");
    stories.value = await repo.getStories();
  }
}