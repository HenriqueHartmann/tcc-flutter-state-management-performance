import 'package:app_base_gestao_estado/bloc/item/item_event.dart';
import 'package:app_base_gestao_estado/bloc/item/item_state.dart';
import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;

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
      // Captura o tempo do tap
      final tapStartTime = event.tapStartTime ?? DateTime.now();
      
      // Executa a mudança
      _style = _style.toggleSelectedAttribute(event.attribute);
      emit(ItemLoaded(item: _item, style: _style));
      
      // Mede o tempo end-to-end após a renderização
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureEndToEndTime(tapStartTime);
      });
    });
  }
  
  void _measureEndToEndTime(DateTime tapStartTime) {
    final endTime = DateTime.now();
    final totalDuration = endTime.difference(tapStartTime);
    
    // Converte para milissegundos (mais fácil de ler)
    final totalMs = totalDuration.inMicroseconds / 1000.0;
    
    final message = 'Tempo end-to-end (Bloc): ${totalMs.toStringAsFixed(1)}ms';
    print(message);
    developer.log(message, name: 'Performance');
  }
}
