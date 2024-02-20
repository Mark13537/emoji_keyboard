class Constants {
  static String serchTextHint = 'Search any Emoji ;)';

  //categories
  static String catRecent = 'Frequently Used';
  static String catSmileys = 'Smileys & Emotion';
  static String catPeople = 'People & Body';
  static String catAnimals = 'Animals & Nature';
  static String catFood = 'Food & Drink';
  static String catTravel = 'Travel & Places';
  static String catActivities = 'Activities';
  static String catObjects = 'Objects';
  static String catSymbols = 'Symbols';
  static String catFlags = 'Flags';

  //List for tab Emoji Keyboard header.
  static List<Map<String, String>> keyboardTabs = [
    {'emoji': '⌚', 'category': catRecent},
    {'emoji': '😀', 'category': catSmileys},
    {'emoji': '👋', 'category': catPeople},
    {'emoji': '🐵', 'category': catAnimals},
    {'emoji': '🍇', 'category': catFood},
    {'emoji': '🌍', 'category': catTravel},
    {'emoji': '🎃', 'category': catActivities},
    {'emoji': '👓', 'category': catObjects},
    {'emoji': '🏧', 'category': catSymbols},
    {'emoji': '🏁', 'category': catFlags},
  ];
}
