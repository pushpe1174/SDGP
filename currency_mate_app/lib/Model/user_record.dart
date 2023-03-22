import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserRecord {
    String? userid = FirebaseAuth.instance.currentUser?.uid;
    DateTime date;
    int total;
    int note5000;
    int note1000;
    int note500;
    int note100;
    int note50;
    int note20;

    UserRecord(
      this.userid,
      this.date,
      this.total,
      this.note5000,
      this.note1000,
      this.note500,
      this.note100,
      this.note50,
      this.note20,
    );

    factory UserRecord.fromDocument(DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      final date = (data['date'] as Timestamp).toDate();

      return UserRecord(
        data['userid'],
        date,
        data['total'],
        data['5000'],
        data['1000'],
        data['500'],
        data['100'],
        data['50'],
        data['20'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'userid': userid,
        'date': date,
        'total': total,
        '5000': note5000,
        '1000': note1000,
        '500': note500,
        '100': note100,
        '50': note50,
        '20': note20,
      };
    }
}
