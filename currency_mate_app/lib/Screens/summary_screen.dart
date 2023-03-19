import 'package:currency_mate_app/Utils/summary_card.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
class SummaryScreen extends StatelessWidget {
  SummaryScreen(this.res ,{super.key});
  final Map<int,int> res;

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
              if(res[notes[index]] == null){
                return SummaryCard(notes[index],0);
              }else{
                return SummaryCard(notes[index],res[notes[index]]!);
              }
            },
          ),
        )
      ),
    );
  }
}
