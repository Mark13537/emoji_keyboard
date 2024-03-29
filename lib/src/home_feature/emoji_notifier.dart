import 'dart:convert';

import 'package:emoji_keyboard/src/home_feature/models/emoji_model.dart';
import 'package:emoji_keyboard/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constants.dart';
import 'models/emoji_config.dart';

final emojiProvider =
    AsyncNotifierProvider<EmojiNotifier, EmojiModel>(EmojiNotifier.new);

class EmojiNotifier extends AsyncNotifier<EmojiModel> {
  @override
  Future<EmojiModel> build() async {
    List<Emoji>? usedEmojis;
    var emojiInstance =
        await EmojiConfig.create(filePath: 'assets/all-emoji.json');

    var sharedPrefsEmojis = await Utils.getRecentForSharedPrefs();
    usedEmojis = Utils.parseStringToObjList(sharedPrefsEmojis);

    return EmojiModel(
        searching: false,
        emojis: emojiInstance.emojiList,
        selectedEmojis: [],
        searchEmojis: [],
        selectedTabIndex: 0,
        usedEmojis: usedEmojis,
        selectedCat: Constants.catRecent,
        enteredText: '');
  }

  //On selecting category from tab of emoji category
  void selectingEmojiCat(int index) {
    state = AsyncData(state.value!.copyWith(
        searching: false,
        selectedCat: Constants.keyboardTabs[index]['category']));
    if (state.value!.selectedCat == Constants.catRecent) {
      state = AsyncData(state.value!
          .copyWith(usedEmojis: List.from(state.value!.usedEmojis.reversed)));
    }
    filterByType();
  }

  // filter emojis according to selected category
  void filterByType() {
    state = AsyncData(state.value!.copyWith(selectedEmojis: []));
    final buildEmojiList = <Emoji>[];
    for (Emoji emoji in state.value!.emojis) {
      if (emoji.category == state.value!.selectedCat) {
        buildEmojiList.add(emoji);
      }
    }
    state = AsyncData(state.value!.copyWith(selectedEmojis: buildEmojiList));
  }

  void searching() {
    state = AsyncData(state.value!.copyWith(searching: true));
  }

  void textInputChanged(String text) {
    // Update searchEmojis list according to serch text

    List<Emoji> buildSearchEmojis = state.value!.emojis
        .where((emoji) =>
            emoji.emojiDetail.description.contains(text.toLowerCase()))
        .toList();

    state = AsyncData(state.value!
        .copyWith(enteredText: text, searchEmojis: buildSearchEmojis));
  }

  void onClickEmoji(int index) {
    List<Emoji> buildUsedEmoji = state.value!.usedEmojis;
    if (!checkIsExists(index)) {
      //check lenght is >=10 then remove last item
      if (buildUsedEmoji.length >= 10) {
        buildUsedEmoji.removeLast();
      }
      state.value!.searching
          ? buildUsedEmoji.add(state.value!.searchEmojis[index])
          : buildUsedEmoji.add(state.value!.selectedEmojis[index]);

      state = AsyncData(state.value!.copyWith(usedEmojis: buildUsedEmoji));

      Utils.saveRecentInSharedPrefs(jsonEncode(buildUsedEmoji.toString()));
    }
  }

  bool checkIsExists(int index) {
    String description = state.value!.searching
        ? state.value!.searchEmojis[index].emojiDetail.description
        : state.value!.selectedEmojis[index].emojiDetail.description;
    for (Emoji emoji in state.value!.usedEmojis) {
      if (emoji.emojiDetail.description == description) {
        return true;
      }
    }
    return false;
  }
}
