class ProductVariation {
  Map<String, dynamic>? attributeValues;
  String description;
  String id;
  String image;
  double price;
  String sku;
  double salePrice;
  double stock;

  ProductVariation({
    required this.attributeValues,
    required this.description,
    required this.id,
    required this.image,
    required this.price,
    required this.sku,
    required this.salePrice,
    required this.stock,
  });

  //empaty
  factory ProductVariation.empty() => ProductVariation(
        attributeValues: null,
        description: "",
        id: '',
        image: '',
        price: 0.0,
        sku: "",
        salePrice: 0.0,
        stock: 0.0,
      );

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      attributeValues: json['attributeValues'],
      description: json['description'] ?? "",
      id: json['id'] ?? "",
      image: json['image'] ?? "",
      price: (double.parse((json['price'] ?? 0.0).toString())),
      sku: json['sku'] ?? "",
      salePrice: (double.parse((json['salePrice'] ?? 0.0).toString())),
      stock: (double.parse((json['stock'] ?? 0.0).toString())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributeValues': attributeValues,
      'description': description.toString(),
      'id': id.toString(),
      'image': image.toString(),
      'price': price.toDouble(),
      'sku': sku.toString(),
      'salePrice': salePrice.toDouble(),
      'stock': stock.toDouble(),
    };
  }
}
