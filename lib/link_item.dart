class LinkItem {
  final String label;
  final String url;
  final String? type;

  LinkItem({
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
