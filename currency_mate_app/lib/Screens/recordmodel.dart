import 'package:cloud_firestore/cloud_firestore.dart';

class RecordModel {
  String userid;
  DateTime date;
  int sum;
  int note5000;
  int note1000;
  int note500;
  int note100;
  int note50;
  int note20;

  RecordModel(
      this.userid,
      this.date,
      this.sum,
      this.note5000,
      this.note1000,
      this.note500,
      this.note100,
      this.note50,
      this.note20,
      );

  factory RecordModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final date = (data['date'] as Timestamp).toDate();
    return RecordModel(
      data['userid'],
      date,
      data['sum'],
      data['5000amount'],
      data['1000amount'],
      data['note500amount'],
      data['note100amount'],
      data['note50amount'],
      data['note20amount'],
    );
}

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'date': date,
      'sum': sum,
      '5000amount': note5000,
      '1000amount': note1000,
      '500amount': note500,
      '100amount': note100,
      '50amount': note50,
      '20amount': note20,
    };
  }
}
