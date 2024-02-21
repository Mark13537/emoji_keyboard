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
      emojiDetail: EmojiDetail(id: '', code: '', emoji: '', description: ''));
  EmojiDetail emojiDetail =
      EmojiDetail(id: '', code: '', emoji: '', description: '');

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
        emojiDetail.setDescription(rawList[i][3]);
        emoji.setEmojiDetail(emojiDetail);
        list.add(Emoji(
            category: emoji.category,
            subcategory: emoji.subcategory,
            emojiDetail: EmojiDetail(
                id: emojiDetail.id,
                code: emojiDetail.code,
                emoji: emojiDetail.emoji,
                description: emojiDetail.description)));
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
      EmojiDetail(id: '', code: '', emoji: '', description: '');

  Emoji(
      {required this.category,
      required this.subcategory,
      required this.emojiDetail});

  Map<String, dynamic> toMap() {
    return {
      '"category"': '"$category"',
      '"subcategory"': '"$subcategory"',
      '"emojiDetail"': emojiDetail.toMap(),
    };
  }

  Emoji.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null ? json['category'].toString() : '';
    subcategory =
        json['subcategory'] != null ? json['subcategory'].toString() : '';
    emojiDetail = (json['emojiDetail'] != null && (json['emojiDetail'] is Map))
        ? EmojiDetail.fromJson(json['emojiDetail'] as Map<String, dynamic>)
        : EmojiDetail(id: '', code: '', emoji: '', description: '');
  }

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
    return toMap().toString();
  }

  static List<Emoji> parseEmojis(String input) {
    final result = <Emoji>[];
    final parts = input.split(',');
    var currentEmoji = Emoji(
        category: '',
        subcategory: '',
        emojiDetail: EmojiDetail(id: '', code: '', emoji: '', description: ''));
    for (final part in parts) {
      if (part.startsWith('Category:')) {
        currentEmoji = Emoji(
            category: '',
            subcategory: '',
            emojiDetail:
                EmojiDetail(id: '', code: '', emoji: '', description: ''));
        currentEmoji.category = part.split(': ')[1];
      } else if (part.startsWith('Subcategory:')) {
        currentEmoji.subcategory = part.split(': ')[1];
      } else if (part.startsWith('EmojiDetail:')) {
        final details = part.split(': ')[1];
        final detailsParts = details.split(' ');
        currentEmoji.emojiDetail = EmojiDetail(
          id: detailsParts[0].split(': ')[1],
          code: detailsParts[1].split(': ')[1],
          emoji: detailsParts[2].split(': ')[1],
          description: detailsParts[3].split(': ')[1],
        );
        result.add(currentEmoji);
      }
    }
    return result;
  }
}

class EmojiDetail {
  String id = '';
  String code = '';
  String emoji = '';
  String description = '';

  EmojiDetail(
      {required this.id,
      required this.code,
      required this.emoji,
      required this.description});

  Map<String, String> toMap() {
    return {
      '"id"': '"$id"',
      '"code"': '"$code"',
      '"emoji"': '"$emoji"',
      '"description"': '"$description"',
    };
  }

  EmojiDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'].toString() : '';
    code = json['code'] != null ? json['code'].toString() : '';
    emoji = json['emoji'] != null ? json['emoji'].toString() : '';
    description =
        json['description'] != null ? json['description'].toString() : '';
  }

  void setId(String id) {
    this.id = id;
  }

  void setCode(String code) {
    this.code = code;
  }

  void setEmoji(String emoji) {
    this.emoji = emoji;
  }

  void setDescription(String description) {
    this.description = description;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
