import 'package:flutter/material.dart';
import '../models/item_card_style.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final String description;
  final ItemCardStyle style;

  const ItemCard({
    Key? key,
    required this.title,
    required this.description,
    required this.style,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String _selectedAttribute = 'backgroundColor';

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
              widget.title,
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
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedAttribute,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAttribute = newValue!;
                });
              },
              items: <String>['backgroundColor', 'titleFontSize', 'titleFontColor', 'descriptionFontSize', 'descriptionFontColor']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                _changeItemStyle();
              },
              child: Text('Alterar $_selectedAttribute'),
            ),
          ],
        ),
      ),
    );
  }

  void _changeItemStyle() {
    ItemCardStyle newStyle = widget.style;
    switch (_selectedAttribute) {
      case 'backgroundColor':
        newStyle.toggleBackgroundColor();
        break;
      case 'titleFontSize':
        newStyle.toggleTitleFontSize();
        break;
      case 'titleFontColor':
        newStyle.toggleTitleFontColor();
        break;
      case 'descriptionFontSize':
        newStyle.toggleDescriptionFontSize();
        break;
      case 'descriptionFontColor':
        newStyle.toggleTitleFontColor();
        break;
    }
  }
}
