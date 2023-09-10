import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_produk/app/providers/product/product_provider.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final StateNotifierProviderRef ref; // if you want to use ref inside this provider
  AppStateNotifier(this.ref) : super(AppState());

  List<int> visited = [];

  void navigateTo(int index) {
    state = state.copyWith(page: index);

    // ketika halaman belum pernah dikunjungi, get data tertentu
    // hal ini kita lakukan untuk menghemat resource (optimasi)
    if (!visited.contains(index)) {
      if (index == 1) {
        final productNotifier = ref.read(productProvider.notifier);
        productNotifier.getProduct();
      }

      visited.add(index);
    }
  }
}

class AppState {
  final int page;

  AppState({this.page = 0});

  AppState copyWith({int? page}) {
    return AppState(
      page: page ?? this.page,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(ref);
});
