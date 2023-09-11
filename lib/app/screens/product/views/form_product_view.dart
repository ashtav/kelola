import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/product.dart';

class FormProductView extends StatelessWidget {
  final Product? product;
  const FormProductView({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    bool isEdit = product != null;
    String title = isEdit ? 'Edit Product' : 'Add Product';

    final forms = LzForm.make(['name', 'price', 'stock', 'image']).fill({
      'name': 'Orange Melon',
      'price': 53900,
      'stock': 14,
      'image': 'https://tipbuzz.com/wp-content/uploads/Cantaloupe-wedges.jpg'
    });

    if (isEdit) {
      forms.fill(product!.toJson().currency(['price']));
    }

    return Wrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: LzFormList(
          style: const LzFormStyle(type: FormType.topAligned),
          children: [
            LzForm.input(
                label: 'Name',
                hint: 'Please input product name',
                model: forms['name']),
            LzFormGroup(
              label: 'Price & Stock',
              labelStyle: Gfont.fs14,
              children: [
                LzForm.input(
                    label: 'Price',
                    hint: 'Please input product price',
                    model: forms['price'],
                    formatters: [InputFormat.currency('.')],
                    keyboard: Tit.number),
                LzForm.number(
                    label: 'Stock',
                    hint: 'Please input product stock',
                    model: forms['stock'])
              ],
            ),
            LzForm.input(
                label: 'Image',
                hint: 'Please paste image url',
                model: forms['image']),
          ],
        ),
        bottomNavigationBar: LzButton(
          onTap: (_) {
            // pertama, kita perlu melakukan validasi
            // untuk memastikan form terisi dengan benar

            final form = LzForm.validate(forms, required: ['*']);

            if (form.ok) {
              // jika valid maka proses data tersebut

              // generate random id, atau gunakan product.id jika type form adalah edit
              int id = isEdit ? product!.id! : DateTime.now().millisecond;

              // kemas data dalam bentuk model
              // jangan lupa semua data form adalah string
              // dan kita perlu menyesuaikan dengan type data yang dibutuhkan
              Product data = Product.fromJson(
                  {'id': id, ...form.value}.numeric(['price', 'stock']));

              // kembali
              context.pop(data);
            }
          },
          text: 'Submit',
        ).theme1(),
      ),
    );
  }
}
