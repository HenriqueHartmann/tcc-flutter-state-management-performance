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

  // ...
}