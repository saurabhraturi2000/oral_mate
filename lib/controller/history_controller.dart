import 'package:get/get.dart';

class HistoryController extends GetxController {
  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
  }

  uploadActivity() {}

  getActivity() {}
}
