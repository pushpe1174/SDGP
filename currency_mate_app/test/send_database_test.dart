import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_mate_app/Api/send_to_database.dart';
import 'package:currency_mate_app/Model/user_record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('SendToDatabase', () {
    final Map<int, int> detect = {5000: 1, 1000: 2};
    final SendToDatabase sendToDatabase = SendToDatabase(detect);

    // Initialize Firebase once before running the tests
    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      // Mock FirebaseAuth
      final mockFirebaseAuth = MockFirebaseAuth();
      FirebaseAuth.instance.app = mockFirebaseAuth as FirebaseApp;

      // Mock FirebaseFirestore
      final mockFirestore = MockFirestore();
      FirebaseFirestore.instance.app = mockFirestore as FirebaseApp;
    });

    test('_createRecord adds a record to Firestore', () async {
      // Mock UserRecord
      final mockUserRecord = MockUserRecord();
      when(mockUserRecord.toJson()).thenReturn({
        'userId': '123',
        'timestamp': DateTime.now(),
        'total': 7000,
        'note5000': 1,
        'note1000': 2,
        'note500': 0,
        'note100': 0,
        'note50': 0,
        'note20': 0,
      });

      // Call _createRecord
      await sendToDatabase.createRecord(detect, 7000);

      // Verify that a record was added to Firestore
      final mockFirestore = MockFirestore();
      FirebaseFirestore.instance.app = mockFirestore as FirebaseApp;
      verify(mockFirestore.collection('records').add({
        'userId': '123',
        'timestamp': any,
        'total': 7000,
        'note5000': 1,
        'note1000': 2,
        'note500': 0,
        'note100': 0,
        'note50': 0,
        'note20': 0,
      }));
    });
  });
}

// Mock FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock FirebaseFirestore
class MockFirestore extends Mock implements FirebaseFirestore {}

// Mock UserRecord
class MockUserRecord extends Mock implements UserRecord {}