abstract class ItemListEvent {}

class LoadItemList extends ItemListEvent {
  final int limit;

  LoadItemList({required this.limit});
}
