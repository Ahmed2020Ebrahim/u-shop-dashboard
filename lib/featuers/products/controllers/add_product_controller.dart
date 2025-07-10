import 'dart:math';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/data/models/image/image_model.dart';
import 'package:ushop_web/data/models/products/product_attributes_model.dart';
import 'package:ushop_web/data/models/products/product_model.dart';
import 'package:ushop_web/data/models/products/product_variations_model.dart';
import 'package:ushop_web/featuers/products/controllers/products_table_controller.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import 'package:ushop_web/utils/popups/app_popups.dart';
import '../../../data/controllers/category/category_controller.dart';
import '../../../data/controllers/products/products_controller.dart';
import '../../../data/models/brand/brand_model.dart';
import '../../../data/models/category/category_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../media/controllers/media_controller.dart';
import 'variations_controllers.dart';

class AddProductController extends GetxController {
  //*[EXTERNAL CONTROLLERS INSTANCE]//////////////////////////////////////////////////////////////////////////////////////
  //instance creator
  static AddProductController get instance => Get.find();
  //product instance
  final ProductController _productController = Get.put(ProductController());
  //mediacontroller instance
  final MediaController _mediaController = Get.put(MediaController());

  //category controller
  final CategoryController _categoryController = Get.put(CategoryController());

  //

  //*[ADD PRODUCT FORM VARIABELS]////////////////////////////////////////////////////////////////////////////////////////
  // ** form key**//
  //add product form key
  static final formKey = GlobalKey<FormState>();
  // **form controllers**//
  //product title controller
  final TextEditingController productTitleController = TextEditingController();
  //product description controller
  final TextEditingController productDescriptionController = TextEditingController();
  //stock controller
  final TextEditingController productStockController = TextEditingController();
  //price controller
  final TextEditingController productPriceController = TextEditingController();
  //discount controller
  final TextEditingController productDiscountController = TextEditingController();
  //attribute name controller
  final TextEditingController attributeNameController = TextEditingController();
  //attributes field value controller
  final TextEditingController attributesFieldValueController = TextEditingController();

  final SingleValueDropDownController dropDownController = SingleValueDropDownController();

  //*[ENUM VARIABELS]//////////////////////////////////////////////////////////////////////////////////////
  //product type
  final Rx<ProductType> productType = ProductType.single.obs;
  //product visibility
  final Rx<ProductVisibility> productVisibility = ProductVisibility.published.obs;

  //*[STRING VARIABELS]//////////////////////////////////////////////////////////////////////////////////////
  //attributeNameError
  final RxString? attributeNameError = "".obs;
  //attributes field value error
  final RxString? attributesFieldValueError = "".obs;
  //updatedProductId
  final RxString updatedProductId = "".obs;
  //updatedproductSku
  final RxString updatedProductSku = "".obs;

  //*[BOOLIAN VARIABELS]//////////////////////////////////////////////////////////////////////////////////////
  //isloading
  final RxBool isLoading = false.obs;
  //is deleting
  final RxBool isDeleting = false.obs;
  //isupdating
  final RxBool isUpdating = false.obs;

  //*[LIST VARIABELS]//////////////////////////////////////////////////////////////////////////////////////
  //product additional images
  final RxList<ImageModel> productAdditionalImages = <ImageModel>[].obs;
  //current product category
  final RxList<CategoryModel> productCategoriesList = <CategoryModel>[].obs;
  //attributes
  final RxList<ProductAttribute> productAttributesList = <ProductAttribute>[].obs;
  //product variations
  final RxList<ProductVariation> productVariationsList = <ProductVariation>[].obs;
  //variations controllers
  final RxList<VariationControllers> variationControllersList = <VariationControllers>[].obs;
  //productVariatiosAttributesList
  final RxList<Map<String, dynamic>> productVariatiosAttributesList = <Map<String, dynamic>>[].obs;

  //*[MODELS VARIABELS]//////////////////////////////////////////////////////////////////////////////////////
  //product thumbnail
  final Rx<ImageModel> productThumbnail = ImageModel.empty().obs;
  //current product brand
  final Rx<BrandModel> productBrand = BrandModel.emptyBrandModel().obs;
  //active aditionl image
  final Rx<ImageModel> activeAdditionalImage = ImageModel.empty().obs;

  //*********************************************************************************************************/
  //***************************************[--METHODS--]*****************************************************/
  //*********************************************************************************************************/

  //*[PUBLIC METHODS]//////////////////////////////////////////////////////////////////////////////////////
  //create variation
  void generateVariations() {
    if (productAttributesList.isEmpty) {
      AppPopups.showInfoToast(msg: "No Attributes added yet");
      return;
    }
    if (productAttributesList.length == 1) {
      AppPopups.showInfoToast(msg: "Only One Attribute Is Added , No Need To Create Variations");
      return;
    }
    //generate variations
    List<Map<String, String>> allVariationsResutls = [{}];

    for (var attr in productAttributesList) {
      List<Map<String, String>> temp = [];

      for (var variation in allVariationsResutls) {
        for (var value in attr.values) {
          var newVariation = Map<String, String>.from(variation);
          newVariation[attr.name] = value;
          temp.add(newVariation);
        }
      }
      allVariationsResutls = temp;
    }
    productVariatiosAttributesList.value = allVariationsResutls;

    //generate controllers for every variations
    _initVariationControllers();
  }

  //on product type changed
  void onProductTypeChanged(ProductType? value) {
    if (value == ProductType.single && productVariatiosAttributesList.isNotEmpty) {
      Dialoges.showDefaultDialog(
        context: Get.context!,
        title: "Attention",
        contant: const Text("If you change to single you will lose all variations"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              productVariatiosAttributesList.clear();
              if (value != null) {
                productType.value = value;
              }
              Get.back();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    } else {
      if (value != null) {
        productType.value = value;
      }
    }
  }

  //set curent product brand
  void setCurrentProductBrand(var brand) {
    if (brand != null) {
      productBrand.value = brand;
    }
  }

  //select current product category
  void onCategorySelected(CategoryModel? category) {
    if (category != null) {
      if (productCategoriesList.any((element) => element.id == category.id)) {
        productCategoriesList.removeWhere((element) => element.id == category.id);
      } else {
        productCategoriesList.add(category);
      }
    }
  }

  //set product visibility
  void setProductVisibility(ProductVisibility? value) {
    if (value != null) {
      productVisibility.value = value;
    }
  }

  //is category selected
  bool isCategorySelected(CategoryModel category) {
    return productCategoriesList.any((element) => element.id == category.id);
  }

  //* validators ////////////////////////////
  //stock validator
  String? stockValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid number';
    }
    return null; // valid
  }

  //price validator
  String? pricesValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }

    final doubleValue = double.tryParse(value);
    if (doubleValue == null) {
      return 'Please enter a valid number';
    }

    // Check if it has at most two decimal places
    final regex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!regex.hasMatch(value)) {
      return 'Number must have at most 2 decimal places';
    }

    return null; // Valid
  }

  // on add attribute validation
  void addAttribute() {
    if (_attributeNameVAlidator() != null) {
      attributeNameError!.value = _attributeNameVAlidator()!;
      return;
    }
    attributeNameError!.value = "";
    if (_attributeValuesValidator() != null) {
      attributesFieldValueError!.value = _attributeValuesValidator()!;
      return;
    }
    attributesFieldValueError!.value = "";
    productAttributesList.add(
      ProductAttribute(
        name: attributeNameController.text,
        values: _separetAttributesValues(attributesFieldValueController.text),
      ),
    );
    attributeNameController.clear();
    attributesFieldValueController.clear();
    AppPopups.showSuccessToast(msg: "Attribute with id :${productAttributesList.last.values.toString()} is Added");
  }

  //validate and uploadProduct
  Future<void> validateAndUploadProduct() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //validate all product data
      if (!_validateProductForm()) {
        return;
      }

      //show loading screen
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 100, height: 100));

      //upload product to firebase
      await _uploadProduct().then(
        (value) {
          clearAllData();
          //refetchproducts
          _productController.fatchProducts();
          //refresh prodcuct tabel
          Get.reload<ProductsTableController>();
          Get.back();
          AppPopups.showSuccessToast(msg: "Product Uploaded Successfully");
        },
      );
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //validate and uploadProduct
  Future<void> validateAndUpdateProduct() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //validate all product data
      if (!_validateProductForm()) {
        return;
      }

      //show loading screen
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 100, height: 100));

      //upload product to firebase
      await _updateProduct().then(
        (value) {
          clearAllData();
          //refetchproducts
          _productController.fatchProducts();
          //refresh prodcuct tabel
          Get.reload<ProductsTableController>();
          Get.back();
          AppPopups.showSuccessToast(msg: "Product Updated Successfully");
        },
      );
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //changeActiveAdditionalImage
  void changeActiveAdditionalImage(String id) {
    activeAdditionalImage.value = productAdditionalImages.firstWhere((element) => element.id == id);
    activeAdditionalImage.refresh();
  }

  //remove selected additional image
  void removeSelectedAditionalImage(String id) {
    //checi if the element is in the productAdditionalImages
    if (!productAdditionalImages.any((element) => element.id == id)) {
      return;
    }
    //chech if the element is the same activeAdditionalImage
    if (activeAdditionalImage.value.id == id) {
      //check if the element is the last element in productAdditionalImages list
      if (productAdditionalImages.length == 1) {
        //clear productAdditionalImages & set activeAdditionalImage to empty
        productAdditionalImages.clear();
        activeAdditionalImage.value = ImageModel.empty();
        activeAdditionalImage.refresh();
        productAdditionalImages.refresh();
        return;
      } else {
        //remove the element and set the activeAdditionalImage to the first of productAdditionalImages list
        //remove the element
        productAdditionalImages.removeWhere((element) => element.id == id);
        //set the first element as activeAdditionalImage
        activeAdditionalImage.value = productAdditionalImages.first;
        return;
      }
    } else {
      productAdditionalImages.removeWhere((element) => element.id == id);
      productAdditionalImages.refresh();
      return;
    }
  }

  //separet atributes values
  String separetAttributesValues(List<String> values) {
    final cleanedValues = values.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    return '{ ${cleanedValues.join(' , ')} }';
  }

  //delet attribute
  void deletAttribute(String id) {
    productAttributesList.removeWhere((element) => element.id == id);
    productAttributesList.refresh();
    AppPopups.showInfoToast(msg: "Attribute is deleted");
  }

  //open mediascreen in bottom sheet to select thumbnile
  Future<void> selectThumbnile() async {
    _mediaController.resetValues(true);
    final List<ImageModel>? resutl = await _mediaController.showSelectProductImagesBottomSheet(
        selectable: true,
        multiSelectable: false,
        selectedImages: productThumbnail.value.url.isEmpty ? null : [productThumbnail.value],
        folder: HelperFunctions.getMediaDropdownSectonsFromString(productThumbnail.value.mediaCategory));
    if (resutl!.isNotEmpty) {
      productThumbnail.value = resutl.first;
    } else {
      productThumbnail.value = ImageModel.empty();
    }
  }

  //open mediascreen in bottom sheet to select product additional images
  Future<void> selectAdditionalImages() async {
    _mediaController.resetValues(true);
    final List<ImageModel>? resutl = await _mediaController.showSelectProductImagesBottomSheet(
      selectable: true,
      multiSelectable: true,
      selectedImages: productAdditionalImages,
      folder: productAdditionalImages.isEmpty ? null : HelperFunctions.getMediaDropdownSectonsFromString(productAdditionalImages.last.mediaCategory),
    );
    changeActiveAdditionalImage(resutl!.first.id);
  }

  //clear all data after validateAndUploadProduct or when descard
  void clearAllData() {
    isUpdating.value = false;
    productTitleController.clear();
    productDescriptionController.clear();
    productType.value = ProductType.single;
    productStockController.clear();
    productPriceController.clear();
    productDiscountController.clear();
    productThumbnail.value = ImageModel.empty();
    productAdditionalImages.clear();
    productBrand.value = BrandModel.emptyBrandModel();
    productCategoriesList.clear();
    productVisibility.value = ProductVisibility.published;
    productAttributesList.clear();
    productVariatiosAttributesList.clear();
    productVariationsList.clear();
    variationControllersList.clear();
    activeAdditionalImage.value = ImageModel.empty();
    isLoading.value = false;
  }

  //setvalues to update
  void setValuesToUpdate(Product product) {
    //updated product id
    updatedProductId.value = product.id;
    //updated product sku
    updatedProductSku.value = product.sku;
    //remove thumbnile from additional images
    if (product.images.isNotEmpty && product.images.length > 1) {
      product.images.removeAt(0);
    }
    //frome categoryControllers get categories by id
    List<CategoryModel> categories = [];
    for (var category in _categoryController.allCategories) {
      if (product.categoryId.contains(category.id)) {
        categories.add(category);
      }
    }
    isUpdating.value = true;
    productTitleController.text = product.title;
    productDescriptionController.text = product.description;
    productType.value = HelperFunctions.getProductTypeFromString(product.productType)!;
    productStockController.text = product.stock.toString();
    productPriceController.text = product.price.toString();
    productDiscountController.text = product.salePrice.toString();
    productThumbnail.value = ImageModel(mime: "", url: product.thumbnail, folder: "products", fileName: "", mediaCategory: "products");
    productAdditionalImages.value = product.images.isEmpty
        ? []
        : product.images.map((e) => ImageModel(id: "${Random().nextInt(9000) + 1000}", mime: "", url: e, folder: "products", fileName: "", mediaCategory: "products")).toList();
    productBrand.value = product.brand;
    dropDownController.dropDownValue = DropDownValueModel(name: product.brand.name, value: product.brand);
    productCategoriesList.value = categories;
    productVisibility.value = HelperFunctions.getProductVisibilityFromString(product.visibility)!;
    productAttributesList.value = product.productAttributes.map((e) => ProductAttribute(name: e.name, values: e.values)).toList();
    productVariatiosAttributesList.value = product.productVariations.map((e) => e.toJson()).toList();
    activeAdditionalImage.value = productAdditionalImages.first;

    productVariationsList.value = product.productVariations;
    variationControllersList.value = productVariatiosAttributesList.map((v) {
      VariationControllers temp = VariationControllers(
        priceController: TextEditingController(text: v["price"].toString()),
        stockController: TextEditingController(text: v["stock"].toString()),
        descriptionController: TextEditingController(text: v["description"].toString()),
        discountController: TextEditingController(text: v["salePrice"].toString()),
      );
      temp.image.value = ImageModel(mime: "", url: v["image"], folder: "", fileName: "", mediaCategory: "products");
      temp.folder.value = MediaDropdownSectons.products;
      temp.isImageSelected.value = true;
      return temp;
    }).toList();
  }

//
//
//*[PRIVATE METHODS]//////////////////////////////////////////////////////////////////////////////////////
  //uploadProduct
  Future<void> _uploadProduct() async {
    final Product product = Product(
      id: "",
      brand: productBrand.value,
      categoryId: productCategoriesList.first.id,
      description: productDescriptionController.text,
      images: [productThumbnail.value.url, ...productAdditionalImages.map((e) => e.url)],
      isFeatured: true,
      price: double.parse(productPriceController.text),
      productAttributes: productAttributesList,
      productType: productType.value.name,
      productVariations: productType.value == ProductType.single ? [] : productVariationsList,

      //generate randome sku in this shape sku-random4digits
      sku: "sku-${Random().nextInt(9000) + 1000}",
      salePrice: double.parse(productDiscountController.text),
      stock: double.parse(productStockController.text.toString()),
      thumbnail: productThumbnail.value.url,
      title: productTitleController.text.toString(),
      visibility: productVisibility.value.name,
    );

    //print all product values

    await _productController.uploadProduct(product);
  }

  //updateProduct
  Future<void> _updateProduct() async {
    final Product product = Product(
      id: updatedProductId.value,
      brand: productBrand.value,
      categoryId: productCategoriesList.first.id,
      description: productDescriptionController.text,
      images: [productThumbnail.value.url, ...productAdditionalImages.map((e) => e.url)],
      isFeatured: true,
      price: double.parse(productPriceController.text),
      productAttributes: productAttributesList,
      productType: productType.value.name,
      productVariations: productType.value == ProductType.single ? [] : productVariationsList,

      //generate randome sku in this shape sku-random4digits
      sku: updatedProductSku.value == "" ? "sku-${Random().nextInt(9000) + 1000}" : updatedProductSku.value,
      salePrice: double.parse(productDiscountController.text),
      stock: double.parse(productStockController.text.toString()),
      thumbnail: productThumbnail.value.url,
      title: productTitleController.text.toString(),
      visibility: productVisibility.value.name,
    );

    //print all product values

    await _productController.updateProduct(product);
  }

  //add product form validation
  bool _validateProductForm() {
    //validate that the productVariationsAttributesList must have values if the productType is variable
    if (productType.value == ProductType.variable && productVariatiosAttributesList.isEmpty) {
      AppPopups.showWarningToast(msg: "Please Create Variations or Select Single Product Type");
      return false;
    }

    //validate vaiations images
    if (productType.value == ProductType.variable && productVariatiosAttributesList.isNotEmpty) {
      for (var i = 0; i < variationControllersList.length; i++) {
        final controller = variationControllersList[i];
        if (controller.image.value.url.isEmpty) {
          variationControllersList[i].isImageSelected.value = false;
          variationControllersList.refresh();
          AppPopups.showWarningToast(msg: "Check Variations Images");
          return false;
        } else {
          variationControllersList[i].isImageSelected.value = true;
          variationControllersList.refresh();
        }
      }
    }

    //check if any controller (priceController , stockController , discountController , descriptionController) in variationControllersList is empty
    for (var i = 0; i < variationControllersList.length; i++) {
      final controller = variationControllersList[i];
      if (controller.priceController.text.isEmpty || controller.stockController.text.isEmpty || controller.discountController.text.isEmpty || controller.descriptionController.text.isEmpty) {
        AppPopups.showWarningToast(msg: "Check ${i + 1}th Variations Inputs");
        return false;
      }
    }

    //give productVariationsList its values form variationControllersList values
    if (productType.value == ProductType.variable) {
      for (var i = 0; i < variationControllersList.length; i++) {
        final controller = variationControllersList[i];
        productVariationsList.add(
          ProductVariation(
            attributeValues: productVariatiosAttributesList[i],
            description: controller.descriptionController.text,
            id: "",
            image: controller.image.value.url,
            price: double.parse(controller.priceController.text),
            sku: "sku-${Random().nextInt(9000) + 1000}",
            salePrice: double.parse(controller.discountController.text),
            stock: double.parse(controller.stockController.text),
          ),
        );
      }
    }

    //validate thumbnile
    if (productThumbnail.value.url.isEmpty) {
      AppPopups.showWarningToast(msg: "Please Select Product Thumbnail");
      return false;
    }

    //validate additional images
    if (productAdditionalImages.isEmpty) {
      AppPopups.showWarningToast(msg: "Please Select Product Additional Images");
      return false;
    }

    //validate product brand
    if (productBrand.value.id.isEmpty) {
      AppPopups.showWarningToast(msg: "Please Select Product Brand");
      return false;
    }

    //validate product category
    if (productCategoriesList.isEmpty) {
      AppPopups.showWarningToast(msg: "Please Select Product Categories");
      return false;
    }

    //vaildate productAttributeList
    if (productAttributesList.isEmpty) {
      AppPopups.showWarningToast(msg: "Please Add Product Attributes");
      return false;
    }

    //validate
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      return true;
    }
    AppPopups.showWarningToast(msg: "check your all data and the Variations,there are some missd Inputs");
    return false;
  }

  //attribute Name Validator
  String? _attributeNameVAlidator() {
    if (attributeNameController.text.isEmpty) {
      return "Attribute Name Is Required ";
    }
    return null;
  }

  //attribute Values Validator
  String? _attributeValuesValidator() {
    if (attributesFieldValueController.text.isEmpty) {
      return "Attribute Values are Required ";
    }
    final parts = attributesFieldValueController.text.split('|').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) {
      return 'Please enter a value';
    }
    return null; // default valid
  }

  //separet attributes values
  List<String> _separetAttributesValues(String value) {
    List<String> parts = value.split('|').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return parts;
  }

  //init varations controllers
  void _initVariationControllers() {
    variationControllersList.value = productVariatiosAttributesList.map((v) {
      return VariationControllers(
        priceController: TextEditingController(),
        stockController: TextEditingController(),
        descriptionController: TextEditingController(),
        discountController: TextEditingController(),
      );
    }).toList();
  }
}
