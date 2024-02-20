import 'dart:convert';
import 'package:flutter/services.dart';

class EmojiConfig {
  final String filePath;
  static String jsonString = '';
  static late final List<List<String>> parsedList;
  late final List<Emoji> emojiList;

  Emoji emoji = Emoji(
      category: '',
      subcategory: '',
      emojiDetail: EmojiDetail(id: '', code: '', emoji: '', discription: ''));
  EmojiDetail emojiDetail =
      EmojiDetail(id: '', code: '', emoji: '', discription: '');

  EmojiConfig._create({required this.filePath});

  static Future<EmojiConfig> create({required String filePath}) async {
    // Call the private constructor
    var instance = EmojiConfig._create(filePath: filePath);

    // Do initialization that requires async
    await setDataFromJson(filePath);
    final dynamicList = jsonDecode(jsonString) as List<dynamic>;
    parsedList = dynamicList.map((list) {
      return List<String>.from(list as Iterable<dynamic>);
    }).toList();
    instance.emojiList = instance.getList(parsedList);

    // Return the fully initialized object
    return instance;
  }

  // transforming the list of emojis to list of Emoji object
  List<Emoji> getList(List<List<String>> rawList) {
    final List<Emoji> list = [];
    for (int i = 0; i < rawList.length; i++) {
      if (rawList[i].length == 1) {
        if ((i - 1 >= 0 && rawList[i - 1].length == 1) ||
            (i - 1 >= 0 &&
                rawList[i - 1].length == 4 &&
                rawList[i + 1].length == 4)) {
          emoji.setSubcategory(rawList[i][0]);
        } else {
          emoji.setCategory(rawList[i][0]);
        }
      } else {
        emojiDetail.setId(rawList[i][0]);
        emojiDetail.setCode(rawList[i][1]);
        emojiDetail.setEmoji(rawList[i][2]);
        emojiDetail.setDiscription(rawList[i][3]);
        emoji.setEmojiDetail(emojiDetail);
        list.add(Emoji(
            category: emoji.category,
            subcategory: emoji.subcategory,
            emojiDetail: EmojiDetail(
                id: emojiDetail.id,
                code: emojiDetail.code,
                emoji: emojiDetail.emoji,
                discription: emojiDetail.discription)));
      }
    }
    return list;
  }

  // get data for json file
  static Future<void> setDataFromJson(String path) async {
    jsonString = await rootBundle.loadString(path);
  }
}

class Emoji {
  String category = '';
  String subcategory = '';
  EmojiDetail emojiDetail =
      EmojiDetail(id: '', code: '', emoji: '', discription: '');

  Emoji(
      {required this.category,
      required this.subcategory,
      required this.emojiDetail});

  void setCategory(String category) {
    this.category = category;
  }

  void setSubcategory(String subcategory) {
    this.subcategory = subcategory;
  }

  void setEmojiDetail(EmojiDetail emojiDetail) {
    this.emojiDetail = emojiDetail;
  }

  @override
  String toString() {
    return 'Category: $category Subcategory: $subcategory EmojiDetail: $emojiDetail';
  }
}

class EmojiDetail {
  String id = '';
  String code = '';
  String emoji = '';
  String discription = '';

  EmojiDetail(
      {required this.id,
      required this.code,
      required this.emoji,
      required this.discription});

  void setId(String id) {
    this.id = id;
  }

  void setCode(String code) {
    this.code = code;
  }

  void setEmoji(String emoji) {
    this.emoji = emoji;
  }

  void setDiscription(String discription) {
    this.discription = discription;
  }

  @override
  String toString() {
    return 'Id: $id Code: $code Emoji: $emoji Discription: $discription';
  }
}
