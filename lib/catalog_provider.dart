import 'package:flutter/foundation.dart';
import '../content_repository.dart';
import '../card_item.dart';

class CatalogProvider extends ChangeNotifier {
  bool loading = false;
  bool loaded = false;
  String? loadError;

  String query = '';
  CardItem? selected;

  List<CardItem> _allItems = [];

  List<CardItem> get filteredItems {
    if (query.isEmpty) return _allItems;

    final q = query.toLowerCase();

    return _allItems.where((item) {
      return item.shortTitle.toLowerCase().contains(q) ||
          item.fullTitle.toLowerCase().contains(q) ||
          item.paragraphs.any((p) => p.toLowerCase().contains(q)) ||
          item.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  Map<String, List<CardItem>> get groupedByCategory {
    final map = <String, List<CardItem>>{};

    for (final item in filteredItems) {
      map.putIfAbsent(item.category, () => []).add(item);
    }

    for (final list in map.values) {
      list.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }

    return map;
  }

  Future<void> load() async {
    if (loading) return;

    loading = true;
    notifyListeners();

    try {
      _allItems = await ContentRepository.loadItems();
      loaded = true;
      print('[Provider] Load success');
    } catch (e) {
      loadError = e.toString();
      print('[Provider] Load error: $e');
    }

    loading = false;
    notifyListeners();
  }

  void setQuery(String value) {
    query = value;
    notifyListeners();
  }

  void select(CardItem item) {
    selected = item;
    notifyListeners();
  }
}
