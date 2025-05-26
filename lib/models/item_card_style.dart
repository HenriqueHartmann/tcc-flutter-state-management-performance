import 'package:flutter/material.dart';

enum ItemCardState {
  normal,
  selecionado,
}

class ItemCardStyle {
  // Definição de constantes para evitar problemas de comparação
  static const Color normalBackgroundColor = Colors.white;
  static final Color selectedBackgroundColor = Colors.blue[100]!;

  static const double normalTitleFontSize = 18;
  static const double selectedTitleFontSize = 22;

  static const Color normalTitleFontColor = Colors.black;
  static const Color selectedTitleFontColor = Colors.red;

  static const double normalDescriptionFontSize = 14;
  static const double selectedDescriptionFontSize = 16;

  static const Color normalDescriptionFontColor = Colors.grey;
  static const Color selectedDescriptionFontColor = Colors.blueGrey;

  final Color backgroundColor;
  final double titleFontSize;
  final Color titleFontColor;
  final double descriptionFontSize;
  final Color descriptionFontColor;

  const ItemCardStyle({
    this.backgroundColor = normalBackgroundColor,
    this.titleFontSize = normalTitleFontSize,
    this.titleFontColor = normalTitleFontColor,
    this.descriptionFontSize = normalDescriptionFontSize,
    this.descriptionFontColor = normalDescriptionFontColor,
  });

  ItemCardStyle copyWith({
    Color? backgroundColor,
    double? titleFontSize,
    Color? titleFontColor,
    double? descriptionFontSize,
    Color? descriptionFontColor,
  }) {
    return ItemCardStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleFontColor: titleFontColor ?? this.titleFontColor,
      descriptionFontSize: descriptionFontSize ?? this.descriptionFontSize,
      descriptionFontColor: descriptionFontColor ?? this.descriptionFontColor,
    );
  }

  /// Alterna a cor de fundo entre normal e selecionado
  ItemCardStyle toggleBackgroundColor() {
    return copyWith(
      backgroundColor: backgroundColor == selectedBackgroundColor
          ? normalBackgroundColor
          : selectedBackgroundColor,
    );
  }

  /// Alterna o tamanho da fonte do título entre normal e selecionado
  ItemCardStyle toggleTitleFontSize() {
    return copyWith(
      titleFontSize: titleFontSize == selectedTitleFontSize
          ? normalTitleFontSize
          : selectedTitleFontSize,
    );
  }

  /// Alterna a cor da fonte do título entre normal e selecionado
  ItemCardStyle toggleTitleFontColor() {
    return copyWith(
      titleFontColor: titleFontColor == selectedTitleFontColor
          ? normalTitleFontColor
          : selectedTitleFontColor,
    );
  }

  /// Alterna o tamanho da fonte da descrição entre normal e selecionado
  ItemCardStyle toggleDescriptionFontSize() {
    return copyWith(
      descriptionFontSize: descriptionFontSize == selectedDescriptionFontSize
          ? normalDescriptionFontSize
          : selectedDescriptionFontSize,
    );
  }

  /// Alterna a cor da fonte da descrição entre normal e selecionado
  ItemCardStyle toggleDescriptionFontColor() {
    return copyWith(
      descriptionFontColor: descriptionFontColor == selectedDescriptionFontColor
          ? normalDescriptionFontColor
          : selectedDescriptionFontColor,
    );
  }
}
