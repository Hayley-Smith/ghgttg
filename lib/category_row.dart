import 'package:flutter/material.dart';
import 'argument_tile.dart';
import '../card_item.dart';
import 'package:flutter/gestures.dart';


class CategoryRow extends StatefulWidget {
  final String category;
  final List<CardItem> items;

  const CategoryRow({
    super.key,
    required this.category,
    required this.items,
  });

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            widget.category,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              controller.jumpTo(
                controller.offset + event.scrollDelta.dy,
              );
            }
          },
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              controller: controller,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (_, i) =>
                  ArgumentTile(item: widget.items[i]),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: widget.items.length,
            ),
          ),
        ),
      ],
    );
  }
}
