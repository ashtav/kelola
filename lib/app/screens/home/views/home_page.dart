import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_produk/app/core/extensions/extension.dart';
import 'package:lazyui/lazyui.dart';

import '../../../providers/app_provider.dart';
import '../../account/views/account_view.dart';
import '../../product/views/product_view.dart';
import '../../transaction/views/transaction_view.dart';
import 'home_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> pages = const [
      HomeView(),
      ProductView(),
      TransactionView(),
      AccountView()
    ];

    return Scaffold(
      body: appStateProvider.watch((state) => Stack(
            children: [
              Stack(
                  children: List<Widget>.generate(4, (int index) {
                bool isActive = state.page == index;

                return IgnorePointer(
                  ignoring: !isActive,
                  child: AnimatedOpacity(
                    duration: 250.ms,
                    opacity: isActive ? 1 : 0,
                    child: Navigator(
                      onGenerateRoute: (RouteSettings settings) {
                        return MaterialPageRoute(
                          builder: (_) => pages[index],
                          settings: settings,
                        );
                      },
                    ),
                  ),
                );
              })),
            ],
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Br.only(['b'])),
        child: Intrinsic(
          children: [Ti.home, Ti.archive, Ti.fileInvoice, Ti.user]
              .generate((icon, i) {
            List<String> labels = ['Home', 'Product', 'Transaction', 'Account'];

            return Expanded(child: appStateProvider.watch(
              (state) {
                bool isActive = state.page == i;
                Color colorActive = isActive ? Colors.black : Colors.grey;

                return InkTouch(
                  onTap: () {
                    final notifier = ref.read(appStateProvider.notifier);
                    notifier.navigateTo(i);
                  },
                  padding: Ei.sym(v: 13, h: 5),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: Maa.center,
                    children: [
                      Icon(
                        icon,
                        color: colorActive,
                      ),
                      Textr(
                        labels[i],
                        style: Gfont.fs12.fcolor(colorActive),
                        margin: Ei.only(t: 5),
                      )
                    ],
                  ),
                );
              },
            ));
          }),
        ),
      ),
    );
  }
}
