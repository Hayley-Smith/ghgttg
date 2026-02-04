import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../catalog_provider.dart';
import 'category_row.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CatalogProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final groups = provider.groupedByCategory.entries.toList();

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final entry = groups[index];
        return CategoryRow(
          category: entry.key,
          items: entry.value,
        );
      },
    );
  }
}
