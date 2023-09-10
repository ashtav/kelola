import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_produk/app/core/extensions/extension.dart';
import 'package:kelola_produk/app/providers/product/product_provider.dart';
import 'package:kelola_produk/app/routes/paths.dart';
import 'package:lazyui/lazyui.dart' hide LzContextExtension;

import '../../../data/models/product.dart';

class ProductView extends ConsumerWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
          actions: [
            const Icon(Ti.search).onPressed(() {
              // pergi ke halaman search
            }),
            const Icon(Ti.plus).onPressed(() {
              context.push(Paths.formProduct);
            })
          ],
        ),
        body: Consumer(builder: (context, ref, _) {
          final asyncData = ref.watch(productProvider);

          return asyncData.when(
              data: (data) {
                if (data.isEmpty) {
                  return LzNoData(
                    message: 'No data product',
                    onTap: () => notifier.getProduct(),
                  );
                }

                return LzListView(
                  padding: Ei.zero,
                  children: data.generate((item, i) {
                    String name = item.name.orIf();
                    String price = item.price.idr();

                    GlobalKey key = GlobalKey();

                    return InkTouch(
                      onTap: () {
                        DropX.show(key,
                            options: ['Edit', 'Delete'].options(options: {
                              1: ['Confirm', 'Cancel'].options()
                            }), onSelect: (state) {
                          if (state.option == 'Edit') {
                            context.push(Paths.formProduct, extra: item);
                          } else if (state.option == 'Confirm') {
                            notifier.delete(item.id!);
                          }
                        });
                      },
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
                          Icon(Ti.dotsVertical, color: Colors.black45, key: key)
                        ],
                      ),
                    );
                  }),
                ).onRefresh(() => notifier.getProduct());
              },
              error: (e, s) => LzNoData(
                    message: '$e',
                  ),
              loading: () => LzLoader.bar(message: 'Loading...'));
        }));
  }
}
