import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_mate_app/Screens/summary_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/style.dart';

class PreviousRecord extends StatefulWidget {
  const PreviousRecord({Key? key}) : super(key: key);

  @override
  State<PreviousRecord> createState() => _PreviousRecordState();
}

class _PreviousRecordState extends State<PreviousRecord> {
  DateTime selectedDate = DateTime.now();

  _convertMap(QueryDocumentSnapshot<Object?> document){
    Map<int,int> convertDoc = {
      5000 : int.parse('${document['5000']}'),
      1000 : int.parse('${document['1000']}'),
      500 : int.parse('${document['500']}'),
      100 : int.parse('${document['100']}'),
      50 : int.parse('${document['50']}'),
      20 : int.parse('${document['20']}'),
    };
    return convertDoc;
  }

  _documentData(AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
    final documents = snapshot.data!.docs;
    final filteredDocuments = documents.where((document) {
      final documentDate = document['date'].toDate();
      return documentDate.year == selectedDate.year &&
          documentDate.month == selectedDate.month &&
          documentDate.day == selectedDate.day &&
          document["userid"]== FirebaseAuth.instance.currentUser?.uid.toString();
    }).toList();
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: filteredDocuments.length,
            itemBuilder: (BuildContext context, int index) {
              final document = filteredDocuments[index];
              Map<int,int> getMapData = _convertMap(document);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryScreen(getMapData),
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    color: const Color(0xffe1e6dc),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat('H:mm:ss').format(document['date'].toDate()),
                                style: Style.numberStyle2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Rs. ${document['total']}',
                                style: Style.numberStyle2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              );
            }
        )
      ],
    );
  }

  _setDate() async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Records',
              style: Style.headingStyle,
            ),
            backgroundColor: const Color(0xFF1D3557),
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: Style.bgColor,
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                  child: Container(
                    width: MediaQuery.of(context).size.width-20,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFe6e6e6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20
                      ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Select a Date',
                          labelStyle: Style.numberStyle,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: TextEditingController(
                          text: '      ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        ),
                        onTap: _setDate,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 8,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 253, 254, 228),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 5,
                            ),
                            margin: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                            width: MediaQuery.of(context).size.width-20,
                            height:MediaQuery.of(context).size.height-300 ,
                            child: SingleChildScrollView(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('records').snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text('Error loading data');
                                  }else{
                                    return _documentData(snapshot);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
