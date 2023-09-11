import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_produk/app/providers/product/search_product_provider.dart';
import 'package:lazyui/lazyui.dart';

class SearchProductView extends ConsumerWidget {
  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(searchProductProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: LzTextField(
          hint: 'Type product name',
          onSubmit: (keyword) => notifier.searchProduct(keyword),
          autofocus: true,
        ),
      ),

      body: Consumer(builder: (context, ref, _) {
          final asyncData = ref.watch(searchProductProvider);

          return asyncData.when(
              data: (data) {
                if (data.isEmpty) {
                  return LzNoData(
                    message: 'Please type product name in search field.',
                    onTapMessage: 'Back to product',
                    onTap: () => context.pop(),
                  );
                }

                return LzListView(
                  padding: Ei.zero,
                  children: data.generate((item, i) {
                    String name = item.name.orIf();
                    String price = item.price.idr();

                    return InkTouch(
                      onTap: () {},
                      padding: Ei.all(20),
                      border: Br.only(['t'], except: i == 0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: Maa.spaceBetween,
                        children: [
                          Row(
                            children: [
                              LzImage(item.image, size: 60),
                              Columnize(
                                margin: Ei.only(l: 15),
                                children: [
                                  Text(name),
                                  Text(price),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
              error: (e, s) => LzNoData(
                    message: '$e',
                  ),
              loading: () => LzLoader.bar(message: 'Loading...'));
        })
    );
  }
}