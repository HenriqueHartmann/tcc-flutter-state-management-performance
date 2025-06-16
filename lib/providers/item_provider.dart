import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:app_base_gestao_estado/models/item_with_style_notifier.dart';
import 'package:flutter/material.dart';

class ItemProvider with ChangeNotifier {
  List<ItemWithStyleNotifier> _items = [];

  List<ItemWithStyleNotifier> get items => _items;

  void initialize(List<Item> items) {
    _items = items.map((item) {
      return ItemWithStyleNotifier(
        item: item,
        style: const ItemCardStyle(),
      );
    }).toList();
    notifyListeners();
  }
}
