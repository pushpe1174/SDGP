import 'package:currency_mate_app/Utils/summary_card.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final notes = [5000,1000,500,100,50,20];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "Record",
              style: Style.headingStyle,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff1D3557),
        ),
        backgroundColor: Style.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0
          ),
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return SummaryCard(notes[index], index);
            },
          ),
        )
      ),
    );
  }
}
