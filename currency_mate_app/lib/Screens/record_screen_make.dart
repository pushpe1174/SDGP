import 'package:flutter/material.dart';

import '../Utils/style.dart';

class PreviousRecord extends StatefulWidget {
  const PreviousRecord({Key? key}) : super(key: key);

  @override
  State<PreviousRecord> createState() => _PreviousRecordState();
}

class _PreviousRecordState extends State<PreviousRecord> {
  DateTime selectedDate = DateTime.now();
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
                    width: MediaQuery.of(context).size.width-50,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFe6e6e6),
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
