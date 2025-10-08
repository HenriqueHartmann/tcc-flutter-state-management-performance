enum DataLimitOption {
  limit1k(1000),
  limit10k(10000);

  final int value;
  const DataLimitOption(this.value);

  String get label {
    switch (this) {
      case DataLimitOption.limit1k:
        return '1.000 itens';
      case DataLimitOption.limit10k:
        return '10.000 itens';
    }
  }
}