import 'link_item.dart';

class CardItem {
  final String id;
  final String category;
  final String shortTitle;
  final String fullTitle;
  final List<String> paragraphs;
  final List<LinkItem> links;
  final List<String> tags;
  final int sortOrder;

  CardItem({
    required this.id,
    required this.category,
    required this.shortTitle,
    required this.fullTitle,
    required this.paragraphs,
    required this.links,
    required this.tags,
    required this.sortOrder,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
      category: json['category'],
      shortTitle: json['shortTitle'],
      fullTitle: json['fullTitle'],
      paragraphs: List<String>.from(json['paragraphs']),
      links: (json['links'] as List)
          .map((e) => LinkItem.fromJson(e))
          .toList(),
      tags: List<String>.from(json['tags'] ?? []),
      sortOrder: json['sortOrder'] ?? 0,
    );
  }
}
