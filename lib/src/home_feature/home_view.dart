import 'package:emoji_keyboard/src/home_feature/models/emoji_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    EmojiModel.create(filePath: 'assets/all-emoji.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Emoji Keyboard')),
        body: Column(
          children: [
            TextField(
              readOnly: true,
              controller: controller,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.text = '${controller.text} Hello';
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.text = '${controller.text} Hello2';
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.amber,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.text = '${controller.text} Hello3';
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.green,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
