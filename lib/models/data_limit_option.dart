enum DataLimitOption {
  limit10(10),
  limit1k(1000),
  limit10k(10000),
  limit100k(100000);

  final int value;
  const DataLimitOption(this.value);

  String get label {
    switch (this) {
      case DataLimitOption.limit10:
        return '10 itens';
      case DataLimitOption.limit1k:
        return '1.000 itens';
      case DataLimitOption.limit10k:
        return '10.000 itens';
      case DataLimitOption.limit100k:
        return '100.000 itens';
    }
  }
}