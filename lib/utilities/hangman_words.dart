import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;

class HangmanWords {
  int wordCounter = 0;
  List<int> _usedNumbers = [];
  List<String> _words = [];

  Future readWords() async {
    String fileText = await rootBundle.loadString('res/hangman_words.txt');
    _words = fileText.split('\n');
  }

  void resetWords() {
    wordCounter = 0;
    _usedNumbers = [];
//    _words = [];
  }

  // ignore: missing_return
  getWord() {
    wordCounter += 1;
    var rand = Random();
    int wordLength = _words.length;
    int randNumber = rand.nextInt(wordLength);
    bool notUnique = true;
    if (wordCounter - 1 == _words.length) {
      notUnique = false;
      return '';
    }
    while (notUnique) {
      if (!_usedNumbers.contains(randNumber)) {
        notUnique = false;
        _usedNumbers.add(randNumber);
        return _words[randNumber];
      } else {
        randNumber = rand.nextInt(wordLength);
      }
    }
  }

  String getHiddenWord(int wordLength, String w) {
    String hiddenWord = '';
    for (int i = 0; i < wordLength; i++) {
      if (i == 0 || i == wordLength / 2 || i == wordLength - 1) {
        hiddenWord += w[i];
      } else {
        hiddenWord += '_';
      }
    }
    return hiddenWord;
  }
}
