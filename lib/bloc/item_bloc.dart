import 'package:app_base_gestao_estado/bloc/item_event.dart';
import 'package:app_base_gestao_estado/bloc/item_state.dart';
import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  late Item _item;
  late ItemCardStyle _style;

  ItemBloc() : super(ItemInitial()) {
    on<InitializeItem>((event, emit) {
      _item = event.item;
      _style = event.style;
      emit(ItemLoaded(item: _item, style: _style));
    });

    on<ToggleStyle>((event, emit) {
      _style = _style.toggleSelectedAttribute(event.attribute);
      emit(ItemLoaded(item: _item, style: _style));
    });
  }
}
