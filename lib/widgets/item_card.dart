import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final int index;
  final String title;
  final String description;
  final ItemCardStyle style;

  const ItemCard({
    Key? key,
    required this.index,
    required this.title,
    required this.description,
    required this.style,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: widget.style.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.index + 1}. ${widget.title}',
              style: TextStyle(
                fontSize: widget.style.titleFontSize,
                fontWeight: FontWeight.bold,
                color: widget.style.titleFontColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: widget.style.descriptionFontSize,
                color: widget.style.descriptionFontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
