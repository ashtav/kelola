import 'package:kelola_produk/app/data/models/product.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod/riverpod.dart';

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductNotifier() : super(const AsyncValue.loading()) {
    getProduct();
  }

  Future getProduct() async {
    try {
      state = const AsyncValue.loading();
      await Future.delayed(1.s);

      // kita asumsikan data berikut berasal dari API
      List<Map<String, dynamic>> rawData = [
        {
          'id': 1,
          'name': 'Red Apple',
          'price': 10000,
          'stock': 10,
          'image': 'https://www.plantingtree.com/cdn/shop/products/3584_grande.jpg?v=1614270725'
        }
      ];

      List<Product> products = rawData.map((e) => Product.fromJson(e)).toList();
      state = AsyncValue.data(products);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // this methos is used to delete product
  Future delete(int id) async {
    try {
      LzToast.overlay('Deleting product...');
      await Future.delayed(1.s);

      state.whenData((value) {
        value.removeWhere((e) => e.id == id);
        state = AsyncValue.data(value);
      });
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final productProvider = StateNotifierProvider.autoDispose<ProductNotifier, AsyncValue<List<Product>>>((ref) {
  return ProductNotifier();
});
