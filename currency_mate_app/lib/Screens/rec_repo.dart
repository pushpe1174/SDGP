import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:record/recordmodel.dart';

class RecordRepository extends GetxController {
  static RecordRepository get to => Get.find();

  final _record = FirebaseFirestore.instance;

  createRecord(RecordModel record) async {
    await _record.collection('records').add(record.toJson());
  }

  Future<RecordModel> getRecord(DateTime selectedDate) async {
    final doc = await _record
        .collection('records')
        .where("date", isEqualTo: selectedDate)
        .get();
    final userData =
        doc.docs.map((doc) => RecordModel.fromDocument(doc)).single;
    return userData;
  }

  Future<List> otherRecord() async {
    final doc = await _record.collection('records').get();
    final recordData =
        doc.docs.map((doc) => RecordModel.fromDocument(doc)).toList();
    return recordData;
  }
}
