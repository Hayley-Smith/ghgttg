// sample_data.dart
// Models + JSON loader + Provider
// goatherdersguidetothegalaxy.com
//
// One flat catalogue of arguments.
// Rows are generated dynamically by category.
// Read-only, static JSON content.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
class LinkItem {
  final String label;
  final String url;
  final String? type;

  const LinkItem({
    required this.label,
    required this.url,
    this.type,
  });

  factory LinkItem.fromJson(Map<String, dynamic> json) {
    return LinkItem(
      label: json['label'],
      url: json['url'],
      type: json['type'],
    );
  }
}

@immutable
class CardItem {
  final String id;
  final String category;
  final String shortTitle;
  final String fullTitle;
  final List<String> paragraphs;
  final List<LinkItem> links;
  final List<String> tags;
  final int sortOrder;

  const CardItem({
    required this.id,
    required this.category,
    required this.shortTitle,
    required this.fullTitle,
    required this.paragraphs,
    required this.links,
    required this.sortOrder,
    this.tags = const [],
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
      category: json['category'],
      shortTitle: json['shortTitle'],
      fullTitle: json['fullTitle'],
      paragraphs: List<String>.from(json['paragraphs']),
      links: (json['links'] as List)
          .map((l) => LinkItem.fromJson(l))
          .toList(),
      tags: List<String>.from(json['tags'] ?? []),
      sortOrder: json['sortOrder'] ?? 0,
    );
  }
}

/// ------------------------------
/// CONTENT LOADER
/// ------------------------------
class ContentRepository {
  static Future<List<CardItem>> loadItems() async {
    final raw = await rootBundle.loadString(
      'assets/content/arguments.json',
    );

    final List decoded = jsonDecode(raw);
    return decoded.map((e) => CardItem.fromJson(e)).toList();
  }
}

/// ------------------------------
/// PROVIDER
/// ------------------------------
class ContentProvider extends ChangeNotifier {
  List<CardItem> _allItems = [];
  CardItem? _selected;
  String _query = '';
  bool _loaded = false;

  bool get loaded => _loaded;
  CardItem? get selected => _selected;
  String get query => _query;

  Future<void> load() async {
    if (_loaded) return;
    _allItems = await ContentRepository.loadItems()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    _loaded = true;
    notifyListeners();
  }

  List<String> get categories {
    return _filteredItems
        .map((e) => e.category)
        .toSet()
        .toList()
      ..sort();
  }

  List<CardItem> itemsForCategory(String category) {
    return _filteredItems.where((e) => e.category == category).toList();
  }

  List<CardItem> get _filteredItems {
    if (_query.trim().isEmpty) return _allItems;
    final q = _query.toLowerCase();
    return _allItems.where((item) {
      return item.shortTitle.toLowerCase().contains(q) ||
          item.fullTitle.toLowerCase().contains(q) ||
          item.paragraphs.any((p) => p.toLowerCase().contains(q)) ||
          item.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  void select(CardItem item) {
    _selected = item;
    notifyListeners();
  }

  void clearSelection() {
    _selected = null;
    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }
}
