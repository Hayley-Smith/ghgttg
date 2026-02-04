import 'dart:convert';
import 'package:flutter/services.dart';
import '../card_item.dart';

class ContentRepository {
  static Future<List<CardItem>> loadItems() async {
    print('[Repository] Loading arguments.json');

    final raw = await rootBundle.loadString(
      'assets/content/arguments.json',
    );

    final decoded = json.decode(raw) as List;

    final items = decoded
        .map((e) => CardItem.fromJson(e))
        .toList();

    print('[Repository] Loaded ${items.length} items');
    return items;
  }
}
