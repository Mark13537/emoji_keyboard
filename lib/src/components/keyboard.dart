import 'package:emoji_keyboard/src/components/search_box.dart';
import 'package:emoji_keyboard/src/home_feature/models/emoji_model.dart';
import 'package:emoji_keyboard/src/home_feature/emoji_notifier.dart';
import 'package:emoji_keyboard/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Keyboard extends ConsumerWidget {
  const Keyboard({super.key, required this.emojiModel});
  final EmojiModel emojiModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade900,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Constants.keyboardTabs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ref.read(emojiProvider.notifier).selectingEmojiCat(index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35,
                            child: Center(
                              child: Text(
                                Constants.keyboardTabs[index]['emoji']!,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          emojiModel.selectedCat ==
                                  Constants.keyboardTabs[index]['category']
                              ? Container(
                                  height: 2,
                                  color: Colors.indigo,
                                  width: 28,
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const SearchBox(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Text(
                    emojiModel.searching
                        ? 'Search Results'
                        : emojiModel.selectedCat,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: emojiModel.selectedCat == Constants.catRecent
                        ? emojiModel.searching
                            ? emojiModel.searchEmojis.length
                            : emojiModel.usedEmojis.length
                        : emojiModel.searching
                            ? emojiModel.searchEmojis.length
                            : emojiModel.selectedEmojis.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7),
                    itemBuilder: (BuildContext context, int index) {
                      return buildEmoji(emojiModel, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmoji(EmojiModel emojiModel, int index) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Center(
        child: GestureDetector(
          onTap: () {
            print('CLICKED');
            // emojiModel.onClickEmoji(index);
          },
          child: Text(
            emojiModel.selectedCat == Constants.catRecent
                ? emojiModel.searching
                    ? emojiModel.searchEmojis[index].emojiDetail.emoji
                    : emojiModel.usedEmojis[index].emojiDetail.emoji
                : emojiModel.searching
                    ? emojiModel.searchEmojis[index].emojiDetail.emoji
                    : emojiModel.selectedEmojis[index].emojiDetail.emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
