import 'package:emoji_keyboard/src/home_feature/models/emoji_config.dart';

class EmojiModel {
  final bool searching;
  final List<Emoji> emojis;
  final List<Emoji> selectedEmojis;
  final List<Emoji> searchEmojis;
  final int selectedTabIndex;
  final List<Emoji> usedEmojis;
  final String selectedCat;
  final String enteredText;

  EmojiModel({
    required this.searching,
    required this.emojis,
    required this.selectedEmojis,
    required this.searchEmojis,
    required this.selectedTabIndex,
    required this.usedEmojis,
    required this.selectedCat,
    required this.enteredText,
  });

  EmojiModel copyWith({
    bool? searching,
    List<Emoji>? emojis,
    List<Emoji>? selectedEmojis,
    List<Emoji>? searchEmojis,
    int? selectedTabIndex,
    List<Emoji>? usedEmojis,
    String? selectedCat,
    String? enteredText,
  }) {
    return EmojiModel(
        searching: searching ?? this.searching,
        emojis: emojis ?? this.emojis,
        selectedEmojis: selectedEmojis ?? this.selectedEmojis,
        searchEmojis: searchEmojis ?? this.searchEmojis,
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
        usedEmojis: usedEmojis ?? this.usedEmojis,
        selectedCat: selectedCat ?? this.selectedCat,
        enteredText: enteredText ?? this.enteredText);
  }
}
