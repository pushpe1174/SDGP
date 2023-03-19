import '../Screens/record.dart';

class SendToDatabase{
  final notes = [5000,1000,500,100,50,20];
  int total = 0;
  final Map<int,int> detect;
  SendToDatabase(this.detect);

  sendDatabase() async {
    for (int i =0; i<notes.length; i<6) {
      if (detect[notes[i]] == null) {
        total += 0;
      } else {
        int noteValue = notes[i];
        int noteAmount = detect[notes[i]]!;
        total += noteValue * noteAmount;
      }
      await SelectDate.createRecord(detect, total);
    }
  }

}