class Product {
  int? id;
  String? name;
  int? price;
  int? stock;
  String? image;

  Product({this.id, this.name, this.price, this.stock, this.image});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        stock: json['stock'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'stock': stock,
        'image': image,
      };
}
