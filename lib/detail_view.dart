import 'package:flutter/material.dart';
import '../card_item.dart';

class DetailView extends StatelessWidget {
  final CardItem item;

  const DetailView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    print('[Detail] Rendering ${item.id}');

    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.fullTitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 12),

            if (item.tags.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: item.tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                      ),
                    )
                    .toList(),
              ),

            const SizedBox(height: 24),

            ...item.paragraphs.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  p,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(height: 1.5),
                ),
              ),
            ),

            if (item.links.isNotEmpty) ...[
              const SizedBox(height: 32),
              Text(
                "Further Reading",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...item.links.map(
                (link) => InkWell(
                  onTap: () {
                    print('[Link] ${link.url}');
                    // url_launcher later
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.link, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            link.label,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
