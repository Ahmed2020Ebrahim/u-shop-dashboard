import 'package:uuid/uuid.dart';

class ProductAttribute {
  String id;
  String name;
  List<String> values;

  ProductAttribute({
    required this.name,
    required this.values,
    String? id,
  }) : id = id ?? const Uuid().v4();

  static ProductAttribute emptyProductAttribute() => ProductAttribute(name: "", values: []);

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    // print("-------------------->");
    // print("${json['name']}************");
    // print("${json['values']}+++++++++");
    // print("-------------------->");
    return ProductAttribute(
      name: json['name'] ?? "",
      values: List<String>.from(json['values'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }
}
