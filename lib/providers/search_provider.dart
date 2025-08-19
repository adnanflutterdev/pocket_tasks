import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier() : super('');

  void updateText(String searchedText) {
    state = searchedText;
  }

  void clear() {
    state = '';
  }
}

final searchedTextProvider = StateNotifierProvider<SearchNotifier, String>(
  (ref) => SearchNotifier(),
);
