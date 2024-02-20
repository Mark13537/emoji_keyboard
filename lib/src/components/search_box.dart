import 'package:emoji_keyboard/src/home_feature/emoji_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/constants.dart';

class SearchBox extends ConsumerWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 45,
      child: TextField(
        cursorColor: Colors.blue.shade800,
        style: TextStyle(color: Colors.blue.shade800),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          hintText: Constants.serchTextHint,
          hintStyle: TextStyle(
              letterSpacing: 0.4, fontSize: 14, color: Colors.blue.shade800),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          ref.read(emojiProvider.notifier).searching();
        },
        onChanged: (text) {
          ref.read(emojiProvider.notifier).textInputChanged(text);
        },
      ),
    );
  }
}
