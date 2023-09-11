import 'package:kelola_produk/app/data/models/product.dart';
import 'package:kelola_produk/app/providers/product/product_provider.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod/riverpod.dart';

class SearchProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final AutoDisposeStateNotifierProviderRef ref;
  SearchProductNotifier(this.ref) : super(const AsyncValue.data([]));

  Future searchProduct(String keyword) async {
    try {
      final productNotifier = ref.read(productProvider.notifier);
      state = const AsyncValue.loading();

      // simulasi seolah olah kita mengambil data dari API
      await Future.delayed(1.s);

      productNotifier.state.whenData((value) {
        List<Product> products = value.where((e) => e.name!.toLowerCase().contains(keyword.toLowerCase())).toList();
        state = AsyncValue.data(products);
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final searchProductProvider = StateNotifierProvider.autoDispose<SearchProductNotifier, AsyncValue<List<Product>>>((ref) {
  return SearchProductNotifier(ref);
});
