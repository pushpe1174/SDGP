import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_mate_app/Utils/get_total.dart';

import '../Model/user_record.dart';

class SendToDatabase{
  final notes = [5000,1000,500,100,50,20];
  int total = 0;
  final Map<int,int> detect;
  SendToDatabase(this.detect);

  sendDatabase() async {
    total = GetTotal.getTotal(detect);
    await _createRecord(detect, total);
  }

  _createRecord(Map<int, int> detect , total) async {
    List<int> noteAmount = [];
    for (int note in notes) {
      int value = detect[note] == null ? 0 : detect[note]!;
      noteAmount.add(value);
    }
    final record = UserRecord(
        "aS",
        DateTime.now(),
        total,
        noteAmount[0],
        noteAmount[1],
        noteAmount[2],
        noteAmount[3],
        noteAmount[4],
        noteAmount[5]
    );
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('records').add(record.toJson());
      print('Record added successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding record: $e');
    }
  }
}