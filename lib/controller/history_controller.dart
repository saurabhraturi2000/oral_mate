import 'package:get/get.dart';
import 'package:oral_mate/constants.dart';

class HistoryController extends GetxController {
  final Rx<String> _uid = "".obs;
  Map<String, List> mySelectedEvents = {};

  updateUserId(String uid) {
    _uid.value = uid;
  }

  uploadActivity(Map<String, dynamic> data) {
    fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('Data')
        .doc('data')
        .update(data);
  }

  Future<Map<String, dynamic>?> getActivity() async {
    var userDoc = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('Data')
        .doc('data')
        .get();
    final userData = userDoc.data()! as dynamic;
    return userData;
  }
}
