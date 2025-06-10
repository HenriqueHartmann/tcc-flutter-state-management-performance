import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoaded extends ItemState {
  final Item item;
  final ItemCardStyle style;

  ItemLoaded({required this.item, required this.style});
}
