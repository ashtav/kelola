import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kelola_produk/app/data/models/product.dart';
import 'package:kelola_produk/app/screens/product/views/form_product_view.dart';
import 'package:kelola_produk/app/screens/product/views/search_product_view.dart';

import '../screens/home/views/home_page.dart';
import 'paths.dart';

final GoRouter router = GoRouter(
  initialLocation: Paths.home,
  routes: <RouteBase>[
    GoRoute(path: Paths.home, builder: (BuildContext context, GoRouterState state) => const HomePage()),
    GoRoute(
        path: Paths.formProduct,
        builder: (BuildContext context, GoRouterState state) => FormProductView(
              product: state.extra as Product?,
            )),

    GoRoute(path: Paths.searchProduct, builder: (BuildContext context, GoRouterState state) => const SearchProductView()),
    
  ],
);
