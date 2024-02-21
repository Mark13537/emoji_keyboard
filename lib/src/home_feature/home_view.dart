import 'package:emoji_keyboard/src/components/keyboard.dart';
import 'package:emoji_keyboard/src/home_feature/emoji_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiNotifier = ref.watch(emojiProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Emoji Keyboard')),
      body: emojiNotifier.when(
        data: (data) => Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 8,
              child: Keyboard(emojiModel: data),
            )
          ],
        ),
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
