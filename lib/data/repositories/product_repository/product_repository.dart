import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/products/product_model.dart';

class ProductRepository extends GetxController {
  //instance creatro
  static ProductRepository get instance => Get.find();

  //firebase database instance
  final _db = FirebaseFirestore.instance;

  //get products data
  Future<List<Product>> getProducts() async {
    try {
      final products = await _db.collection("Products").get();
      final data = products.docs.map((product) {
        return Product.fromSnapshot(product);
      }).toList();

      return data;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

//search product by name
  Future<List<Product>> searchProductsByName(String name) async {
    if (name.isEmpty) return [];
    try {
      final products = await _db
          .collection("Products")
          .where('title', isGreaterThanOrEqualTo: name)
          .where('title', isLessThan: '${name}z') // basic prefix match
          .get();

      final data = products.docs.map((product) => Product.fromSnapshot(product)).toList();
      return data;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

//get favoritProducts
  Future<List<Product>> getFavoritProducts(List<String> productsIds) async {
    try {
      // Check if the list is empty before proceeding
      if (productsIds.isEmpty) {
        return [];
      }
      // Fetch products from Firestore using the provided product IDs
      final products = await _db.collection("Products").where(FieldPath.documentId, whereIn: productsIds).get();
      final data = products.docs.map((product) => Product.fromSnapshot(product)).toList();
      return data;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //upload product
  Future<void> uploadProduct(Product product) async {
    try {
      //upload data to product collection
      var data = await _db.collection("Products").add(product.toJson());
      //update id after creating
      product.id = data.id;
      await _db.collection("Products").doc(data.id).update(product.toJson());
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      //upload data to product collection
      await _db.collection("Products").doc(product.id).update(product.toJson());
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //remove product
  Future<void> removeProduct(String id) async {
    try {
      await _db.collection("Products").doc(id).delete();
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "Something went wrong , please try again";
    }
  }

//!--//////////////////////////////////////////////////////////////////////////////////////////////////////////
//upload image files
  // Future<String> uploadImage(File image, String imageName) async {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child('product_images/$imageName');
  //   UploadTask uploadTask = ref.putFile(image);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  //get local file
  // Future<File> getLocalFile(String assetPath, String fileName) async {
  //   ByteData bytes = await rootBundle.load(assetPath);
  //   String tempPath = (await getTemporaryDirectory()).path;
  //   File file = File('$tempPath/$fileName');
  //   await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
  //   return file;
  // }

// generate dummy data and upload images
  // Future<List<Product>> generateDummyDataWithImageUpload() async {
  //   final random = Random();
  //   int counter = 0;
  //   List<Product> dummyProducts = [];
  //   for (int b = 0; b < DummyData.brands.length; b++) {
  //     for (int p = 0; p < DummyData.productsImages[b].length; p++) {
  //       File image = await getLocalFile(DummyData.productsImages[b][p], "${DummyData.brands[b].name.toLowerCase()}$p.jpg");
  //       String imageUrl = await uploadImage(image, "${DummyData.brands[b].name.toLowerCase()}$p.jpg");
  //       final product = Product(
  //         brand: DummyData.products[counter].brand,
  //         categoryId: (random.nextInt(16) + 1).toString(),
  //         description: DummyData.products[counter].description,
  //         images: [imageUrl],
  //         isFeatured: DummyData.products[counter].isFeatured,
  //         price: DummyData.products[counter].price,
  //         productAttributes: DummyData.products[counter].productAttributes,
  //         productType: DummyData.products[counter].productType,
  //         productVariations: DummyData.products[counter].productVariations,
  //         sku: DummyData.products[counter].sku,
  //         salePrice: DummyData.products[counter].salePrice,
  //         stock: DummyData.products[counter].stock,
  //         thumbnail: imageUrl,
  //         title: DummyData.products[counter].title,
  //       );
  //       dummyProducts.add(product);
  //       counter++;
  //     }
  //   }
  //   return dummyProducts;
  // }

//upload dummy data to firestore
  // Future<void> uploadDummyDataToFirestore() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference productsRef = firestore.collection('Products');

  //   List<Product> dummyProducts = await generateDummyDataWithImageUpload();
  //   int counter = 0;
  //   for (Product product in dummyProducts) {
  //     await productsRef.doc("00$counter+1").set(product.toJson());
  //   }
  // }

  //upload categories to the cloud firestore
  // Future<void> uploadDummyData() async {
  //   try {
  //     final random = Random();
  //     final storage = Get.put(FireBaseStorageServices());
  //     for (int item = 0; item < DummyData.products.length; item++) {
  //       final file = await storage.getImageDataFromAssets(DummyData.productsImages[item]);
  //       final url = await storage.uploadImageData("Products", file, DummyData.productsImages[item]);
  //       final product = Product(
  //         brand: DummyData.products[item].brand,
  //         categoryId: (random.nextInt(16) + 1).toString(),
  //         description: DummyData.products[item].description,
  //         images: [url],
  //         isFeatured: DummyData.products[item].isFeatured,
  //         price: DummyData.products[item].price,
  //         productAttributes: DummyData.products[item].productAttributes,
  //         productType: DummyData.products[item].productType,
  //         productVariations: DummyData.products[item].productVariations,
  //         sku: DummyData.products[item].sku,
  //         salePrice: DummyData.products[item].salePrice,
  //         stock: DummyData.products[item].stock,
  //         thumbnail: url,
  //         title: DummyData.products[item].title,
  //       );

  //       await FirebaseFirestore.instance.collection("Products").doc("00${item + 1}").set(product.toJson());
  //     }
  //   } on FirebaseAuthException catch (_) {
  //     throw "FirebaseAuthExeption has been throwen";
  //   } on FirebaseException catch (_) {
  //     throw "FirebaseException has been throwen";
  //   } on FormatException catch (_) {
  //     throw "FormatException has been throwen";
  //   } on PlatformException catch (_) {
  //     throw "PlatformException has been throwen";
  //   } catch (e) {
  //     throw "some thing went wrong";
  //   }
  // }
}
