import 'package:flutter/material.dart';
import 'item_card_style.dart'; // Importa a classe ItemCardStyle

class ItemCard extends StatelessWidget {
  final String title;
  final String description;
  final ItemCardStyle style; // Utiliza a classe ItemCardStyle

  const ItemCard({
    Key? key,
    required this.title,
    required this.description,
    required this.style,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(8.0),
    color: style.backgroundColor, // Utiliza o backgroundColor do estilo
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: style.titleFontSize, // Utiliza o fontSize do título do estilo
              fontWeight: FontWeight.bold,
              color: style.titleFontColor, // Utiliza a cor do título do estilo
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: style.descriptionFontSize, // Utiliza o fontSize da descrição do estilo
              color: style.descriptionFontColor, // Utiliza a cor da descrição do estilo
            ),
          ),
        ],
      ),
    ),
  );
}
}