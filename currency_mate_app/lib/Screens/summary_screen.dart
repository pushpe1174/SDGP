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
          backgroundColor: const Color(0xFF1D3557),
        ),
        backgroundColor: Style.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
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
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffe1e6dc),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
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
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF442F24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xFF1D3557),
                    //onPressed: () => flutterTts.speak('the sum is ${data['sum'] ?? ''}'),
                    onPressed: () {  },
                    child: const Icon(
                      Icons.volume_up_sharp,
                      size: 40,
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
