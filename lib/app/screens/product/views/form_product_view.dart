import 'package:flutter/material.dart';

import '../../../data/models/product.dart';

class FormProductView extends StatelessWidget {
  final Product? product;
  const FormProductView({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    bool isEdit = product != null;
    String title = isEdit ? 'Edit Product' : 'Add Product';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
