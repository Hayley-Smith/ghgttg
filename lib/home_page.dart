import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../catalog_provider.dart';
import 'browse_view.dart';
import 'detail_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CatalogProvider>();
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Goatherder’s Guide to the Galaxy"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: provider.setQuery,
              decoration: const InputDecoration(
                hintText: 'Search arguments…',
                filled: true,
              ),
            ),
          ),
        ),
      ),
      body: isWide
          ? Row(
              children: [
                const Expanded(flex: 2, child: BrowseView()),
                Expanded(
                  flex: 3,
                  child: provider.selected == null
                      ? const Center(child: Text("Select an entry"))
                      : DetailView(item: provider.selected!),
                ),
              ],
            )
          : const BrowseView(),
    );
  }
}
