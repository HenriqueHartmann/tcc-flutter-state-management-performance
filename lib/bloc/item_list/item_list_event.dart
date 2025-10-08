import 'package:app_base_gestao_estado/models/item_card_style.dart';

abstract class ItemListEvent {}

class LoadItemList extends ItemListEvent {
  final int limit;

  LoadItemList({required this.limit});
}

class ToggleItemStyle extends ItemListEvent {
  final int index;
  final ItemCardAttribute attribute;
  final DateTime? tapStartTime;

  ToggleItemStyle({
    required this.index,
    required this.attribute,
    this.tapStartTime,
  });
}
