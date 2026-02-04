import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../card_item.dart';
import '../catalog_provider.dart';
import 'detail_view.dart';

class ArgumentTile extends StatefulWidget {
  final CardItem item;

  const ArgumentTile({super.key, required this.item});

  @override
  State<ArgumentTile> createState() => _ArgumentTileState();
}

class _ArgumentTileState extends State<ArgumentTile> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CatalogProvider>();
    final isWide = MediaQuery.of(context).size.width > 900;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedScale(
        scale: hovering ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              print('[Tile] Selected ${widget.item.id}');
              provider.select(widget.item);

              if (!isWide) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailView(item: widget.item),
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 220,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(hovering ? 0.9 : 0.75),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(hovering ? 0.5 : 0.2),
                ),
                boxShadow: hovering
                    ? [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black.withOpacity(0.3),
                        )
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  widget.item.shortTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
