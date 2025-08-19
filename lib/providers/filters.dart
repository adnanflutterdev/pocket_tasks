import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> filters = ['All', 'Active', 'Done'];

class FilterIndexNotifier extends StateNotifier<int> {
  FilterIndexNotifier() : super(0);

  void changeIndex(int index) {
    state = index;
  }
}

final filterIndexProvider = StateNotifierProvider<FilterIndexNotifier, int>(
  (ref) => FilterIndexNotifier(),
);
