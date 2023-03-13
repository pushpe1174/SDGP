import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  DateTime _selectedDate = DateTime.now();
  int note5000 = 2;
  int note1000 = 2;
  int note500 = 2;
  int note100 = 2;
  int note50 = 2;
  int note20 = 2;
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF1FAEE),
          child: Column(
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D3557),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: const Center(
                  child: Text(
                    "Records",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAE1DD),
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
                    color: const Color(0xFFFAE1DD),
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
                                    child: Text(
                                      "$note5000",
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
                                    child: Text(
                                      "$note1000",
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
                                      "$note500",
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
                                      "$note100",
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
                                      "$note50",
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
                                      "$note20",
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
                      color: const Color(0xFFFAE1DD),
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
                    onPressed: () {},
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
