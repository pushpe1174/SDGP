import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_mate_app/Model/user_record.dart';
import 'package:get/get.dart';


class RecordRepository extends GetxController {
  static RecordRepository get to => Get.find();

  final _record = FirebaseFirestore.instance;

  createRecord(UserRecord record) async {
    await _record.collection('records').add(record.toJson());
  }

  Future<UserRecord> getRecord(DateTime selectedDate) async {
    final doc = await _record
        .collection('records')
        .where("date", isEqualTo: selectedDate)
        .get();
    final userData =
        doc.docs.map((doc) => UserRecord.fromDocument(doc)).single;
    return userData;
  }

  // Future<List> otherRecord() async {
  //   final doc = await _record.collection('records').get();
  //   final recordData =
  //       doc.docs.map((doc) => UserRecord.fromDocument(doc)).toList();
  //   return recordData;
  // }
}
