// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:emoji_keyboard/src/home_feature/models/emoji_config.dart';
import 'package:emoji_keyboard/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<String?> getRecentForSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.catRecent);
  }

  static Future<bool?> saveRecentInSharedPrefs(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Constants.catRecent, value);
  }

  static List<Emoji> parseStringToObjList(String? response) {
    if (response != null) {
      final parsed = json.decode(response) as String;
      return parseEmojis(parsed);
    }
    return [];
  }

  static List<Emoji> parseEmojis(String input) {
    final result = <Emoji>[];
    final json = jsonDecode(input) as Iterable;
    for (final emojiJson in json) {
      final emoji = Emoji(
          category: '',
          subcategory: '',
          emojiDetail:
              EmojiDetail(id: '', code: '', emoji: '', description: ''))
        ..category = emojiJson['category'].toString()
        ..subcategory = emojiJson['subcategory'].toString();

      EmojiDetail emojiDetail =
          EmojiDetail(id: '', code: '', emoji: '', description: '')
            ..id = emojiJson['emojiDetail']['id'].toString()
            ..code = emojiJson['emojiDetail']['code'].toString()
            ..emoji = emojiJson['emojiDetail']['emoji'].toString()
            ..description = emojiJson['emojiDetail']['description'].toString();
      emoji.setEmojiDetail(emojiDetail);
      result.add(emoji);
    }
    return result;
  }
}
