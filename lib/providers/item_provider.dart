import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter/material.dart';

class ItemWithStyle {
  final Item item;
  ItemCardStyle style;

  ItemWithStyle({required this.item, required this.style});
}

class ItemProvider extends ChangeNotifier {
  final List<ItemWithStyle> _items = [];

  List<ItemWithStyle> get items => _items;

  void initialize(List<Item> itemList) {
    _items.clear();
    _items.addAll(itemList.map((e) => ItemWithStyle(item: e, style: const ItemCardStyle())));
    notifyListeners();
  }

  void toggleStyle(int index, ItemCardAttribute attribute) {
    _items[index].style = _items[index].style.toggleSelectedAttribute(attribute);
    notifyListeners();
  }
}
