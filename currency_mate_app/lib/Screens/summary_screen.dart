import 'package:currency_mate_app/Utils/get_total.dart';
import 'package:currency_mate_app/Utils/summary_card.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
class SummaryScreen extends StatefulWidget {
  const SummaryScreen(this.res ,{super.key});
  final Map<int,int> res;

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int total = 0;
  final notes = [5000,1000,500,100,50,20];
  final FlutterTts flutterTts = FlutterTts();

  _speak(String text) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }
  

  _getSummaryNote(){
    String summary = "You have detected";
    for (int note in notes) {
      if(widget.res[note] != 0){
        String word = widget.res[note] == 1? "note" : "notes";
        summary += " ${widget.res[note]}|$note $word,";
      }
    }
    print(summary);
    return summary;
    }

  _getTotal(){
    total = GetTotal.getTotal(widget.res);
  }

  @override
  void initState() {
    super.initState();
    _getTotal();
  }

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
                    if(widget.res[notes[index]] == null){
                      return SummaryCard(notes[index],0);
                    }else{
                      return SummaryCard(notes[index],widget.res[notes[index]]!);
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
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF442F24),
                        ),
                      ),
                      Text(
                        "Rs. $total",
                        style: const TextStyle(
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
                    onPressed: () => {
                      _speak(_getSummaryNote() + "and Total amount is $total rupees")
                      },
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
