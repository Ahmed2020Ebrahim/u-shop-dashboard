import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/brand/brand_model.dart';
import '../../repositories/brand_repository/brand_repository.dart';

class BrandsController extends GetxController {
  //instance creator
  static BrandsController get instance => Get.find();

  //all brands
  RxList<BrandModel> allBrands = <BrandModel>[].obs;

  //featured brands
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  //loader
  Rx<bool> loader = false.obs;

  //brandrepository instance
  final _brandRepository = Get.put(BrandRepository());

  //current brand
  Rx<BrandModel> currentBrand = BrandModel.emptyBrandModel().obs;

  //on init
  @override
  void onInit() {
    fatchBrands();
    super.onInit();
  }

  //featch all brands
  Future<void> fatchBrands() async {
    try {
      // start loader
      loader.value = true;

      // fatch all categories
      final banners = await _brandRepository.getBrands();

      // update allCategories
      allBrands.assignAll(banners);

      //update featured categories
      featuredBrands.assignAll(banners.where((element) => element.isFeatured));

      // stop loader
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }

  //reorder brands according to user desire
  Future<void> reOrderBrands(String orderby, bool ascending) async {
    switch (orderby) {
      case "name":
        ascending ? allBrands.sort((a, b) => a.name.compareTo(b.name)) : allBrands.sort((a, b) => b.name.compareTo(a.name));
        break;

      default:
        {
          ascending
              ? allBrands.sort((a, b) => a.name.compareTo(b.name))
              : allBrands.sort(
                  (a, b) => b.name.compareTo(a.name),
                );

          allBrands.refresh();
          break;
        }
    }
  }

  //remove brand
  Future<void> removeBrand(String id) async {
    try {
      // start loader
      loader.value = true;
      // fatch all brand
      await _brandRepository.removeBrand(id);

      //remove frome all brand
      allBrands.removeWhere((element) => element.id == id);

      // stop loader
      loader.value = false;
      AppPopups.showSuccessToast(msg: "Deleted Successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }

  //set current brand
  Future<void> setCurrentBrand(BrandModel brand) async {
    currentBrand.value = brand;
  }

  //create brand
  Future<void> createBrand(BrandModel brand) async {
    try {
      // start loader
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));
      // create brand
      await _brandRepository.createBrand(brand);

      await fatchBrands();

      // stop loader
      Get.back();
      AppPopups.showSuccessToast(msg: "Brand Created Successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }

  //update brand
  Future<void> updateBrand(BrandModel brand) async {
    try {
      // start loader
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));
      // update brand

      await _brandRepository.updateBrand(brand);

      await fatchBrands();

      // stop loader
      Get.back();
      AppPopups.showSuccessToast(msg: "Brand Updated Successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }
}
