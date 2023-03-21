class GetTotal{
  static final notes = [5000,1000,500,100,50,20];

  static getTotal(Map<int,int> detect) {
    int total = 0;
    for (int i = 0; i < notes.length; i++) {
      if (detect[notes[i]] == null) {
        total += 0;
      } else {
        int noteValue = notes[i];
        int noteAmount = detect[notes[i]]!;
        total += noteValue * noteAmount;
      }
    }
    return total;
  }
}