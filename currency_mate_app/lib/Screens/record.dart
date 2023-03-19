import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_mate_app/Screens/recordmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';



class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  static createRecord(Map<int, int> detect , sum) async {
    // User? user = FirebaseAuth.instance.currentUser;
    List<int> data_arr = [];
    // int note5000 ;
    int? note1000 ;
    // int note500 ;
    // int note100 ;
    // int note50 ;
    // int note20 ;

    if(detect[1000] == null){
      note1000 = 0;
    }else{
      note1000 = detect[1000];
    }


    final record = RecordModel(
        // user as String,
      "aS",
        DateTime.now(),
        0,
        0,0,0,0,0,
        sum
    );

    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('records').add(record.toJson());
      print('Record added successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding record: $e');
    }

  }

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Records'),
        backgroundColor: const Color(0xFF1D3557),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF1FAEE),
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFe6e6e6),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 3),
                padding: const EdgeInsets.fromLTRB(8, 15, 8, 20),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        "Previous Records",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF442F24),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Select a Date',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF442F24),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          controller: TextEditingController(
                            text:
                            'Date    ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          ),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != _selectedDate) {
                              setState(() {
                                _selectedDate = picked;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFe6e6e6),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                padding: const EdgeInsets.fromLTRB(8, 15, 8, 3),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Text("List",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF442F24),
                        )),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 254, 228),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 335,
                      width: 420,
                      margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 3),
                      child: SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('records').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text(
                                  'No Records',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF442F24),
                                  ),
                                ),
                              );
                            }
                            final documents = snapshot.data!.docs;
                            final filteredDocuments = documents.where((document) {  //filter the records by date
                              //filter the records by user id
                              final documentDate = document['date'].toDate();
                              return documentDate.year == _selectedDate.year &&
                                  documentDate.month == _selectedDate.month &&
                                  documentDate.day == _selectedDate.day;
                            }).toList();
                            return Column(
                              children: [
                                // display the filtered record list
                                ListView.builder(
                                  //sort the list in ascending order by time
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: filteredDocuments.length,
                                  itemBuilder: (context, index) {
                                    final document = filteredDocuments[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainPage(document: document),
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          DateFormat('H:mm:ss').format(document['date'].toDate()),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF442F24),
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Rs. ${document['sum']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(20, 3, 20, 20),
                  child: TextButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/second');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF1D3557),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final QueryDocumentSnapshot? document;

  const MainPage({Key? key, required this.document}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FlutterTts flutterTts = FlutterTts();

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('records');
  final DateTime now = DateTime.now();

  int note5000 = 2;
  int note1000 = 2;
  int note500 = 2;
  int note100 = 2;
  int note50 = 2;
  int note20 = 2;
  int sum = 0;

  void initSetting() async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.1);
    await flutterTts.setLanguage("en-US");
  }

  void _speak() async {
    initSetting();
    await flutterTts.speak('2500');
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.document!.data() as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
        backgroundColor: const Color(0xFF1D3557),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF1FAEE),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFe6e6e6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 3),
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Previous Records",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF442F24),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Selected Date',
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF442F24),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            controller: TextEditingController(
                                text:
                                'Date: ${DateFormat.yMMMd().format((data['date'] as Timestamp?)?.toDate() ?? DateTime.now())}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFe6e6e6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 3),
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text("Quantity",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF442F24),
                            )),
                        Container(
                          padding: const EdgeInsets.only(top: 12.0),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Rs.5000",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "x",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    alignment: Alignment.centerRight,
                                    child:  Text(
                                        '${data['5000amount'] ?? ''}',
                                        style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500,
                                          color:Color(0xFF442F24),
                                        ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Rs.1000",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "x",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    alignment: Alignment.centerRight,
                                    child: Text('${data['1000amount'] ?? ''}',
                                    style:const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF442F24),
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Rs.500",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "x",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${data['500amount'] ?? ''}',
                                      style:const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Rs.100",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "x",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${data['100amount'] ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Rs.50",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "x",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${data['50amount'] ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Rs.20",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "x",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${data['20amount'] ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF442F24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFe6e6e6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 3),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: const [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF442F24),
                          ),
                        ),
                        Text(
                          "Rs. 2500",
                          style: TextStyle(
                            fontSize: 39,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF442F24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xFF1D3557),
                    onPressed: () => flutterTts.speak('the sum is ${data['sum'] ?? ''}'),
                    child: const Icon(
                      Icons.volume_up_sharp,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


