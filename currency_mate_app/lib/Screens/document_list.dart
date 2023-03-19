import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class DocumentDetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot? document;

  const DocumentDetailsScreen({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (document == null) {
      return const Scaffold(
        body: Center(
          child: Text('No document found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF442F24),
            ),
          ),
        ),
      );
    }

    final data = document!.data() as Map<String, dynamic>;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Userid: ${data['userid'] ?? ''}'),
            Text('Date: ${DateFormat.yMMMd().format((data['date'] as Timestamp?)?.toDate() ?? DateTime.now())}'),
            Text('5000amount:    ${data['5000amount'] ?? ''}'),
            Text('1000amount:    ${data['1000amount'] ?? ''}'),
            Text('20amount:    ${data['500amount'] ?? ''}'),
            Text('100amount:    ${data['100amount'] ?? ''}'),
            Text('500amount:    ${data['50amount'] ?? ''}'),
            Text('50amount:    ${data['20amount'] ?? ''}'),
            Text('Sum:          ${data['sum'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}



