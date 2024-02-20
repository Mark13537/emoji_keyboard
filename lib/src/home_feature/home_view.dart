import 'package:emoji_keyboard/src/components/keyboard.dart';
import 'package:emoji_keyboard/src/home_feature/emoji_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emojiNotifier = ref.watch(emojiProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Emoji Keyboard')),
      body: emojiNotifier.when(
        data: (data) => Column(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                readOnly: true,
                controller: controller,
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
