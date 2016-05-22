part of server;

class TextObject{

  int points;

  TextObject(){
    points = 0;
  }

  Map createTextObject(String text, int value) =>
      {"text": text, "value": value};

  bool textChecker(String input, String text) {
    return input == text;
  }

  int accumulate(int value){
    points += value;
  }

}