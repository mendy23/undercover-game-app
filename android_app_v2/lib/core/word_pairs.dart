import 'dart:math';

class WordPairs {
  static final List<List<String>> allPairs = [
    ['Lightning', 'Thunder'],
    ['Landslide', 'Tornado'],
    ['Beach', 'Coast'],
    ['Cat', 'Tiger'],
    ['Coffee', 'Tea'],
    ['Ship', 'Boat'],
  ];

  static List<String> getRandomPair(Random random) {
    return allPairs[random.nextInt(allPairs.length)];
  }
}