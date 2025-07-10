class CartItemModel {
  final String productId;
  final String itemId;
  final String title;
  final double price;
  final String image;
  final int quantity;
  final String brandName;
  final Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.itemId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    required this.brandName,
    this.selectedVariation,
  });

  //empty cart item
  static CartItemModel emptyCartItem() {
    return CartItemModel(
      productId: "",
      itemId: "",
      title: "",
      price: 0,
      image: "",
      quantity: 0,
      brandName: "",
      selectedVariation: null,
    );
  }

  //from json
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? "",
      itemId: json['itemId'] ?? "",
      title: json['title'] ?? "",
      price: json['price'] ?? 0.0,
      image: json['image'] ?? "",
      quantity: json['quantity'] ?? 0,
      brandName: json['brandName'] ?? "",
      selectedVariation: json['selectedVariation'],
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "itemId": itemId,
      "title": title,
      "price": price,
      "image": image,
      "quantity": quantity,
      "brandName": brandName,
      "selectedVariation": selectedVariation,
    };
  }

  //to json with out selected variation
}
