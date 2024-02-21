# emoji_keyboard

A Flutter project that parses emojis from external json and populates into an emoji picker.

## Packages

- [flutter_riverpod: ^2.4.10](https://pub.dev/packages/flutter_riverpod)
- [shared_preferences: ^2.2.2](https://pub.dev/packages/shared_preferences)

## State Management

As app requires to maintain the state of emojis that has been use recently, to make the code readable, maintainable and modularized, we have used Riverpod's AsyncNotifier.

## Control Flow

1.  Parsing of emoji.json into dart objects
1.  Created a dart object as AsyncNotifier's model
1.  Rendered UI based on Emoji categories, followed by the emojis grid
1.  Tap events added for emojis, categories and search
1.  Recent emojis are fetched using SharedPreferences

## Additional Info

Emoji.json is a plain List of Strings. Hence added logic to format into key-value pair json.
