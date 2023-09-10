import 'package:lazyui/lazyui.dart';

extension CurrencyExtension on String? {
  String get rp => currency(symbol: 'Rp', separator: '.');
}
