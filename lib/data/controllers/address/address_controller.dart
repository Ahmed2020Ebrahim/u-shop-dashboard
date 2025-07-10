import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/address/address_model.dart';
import '../../repositories/address_repository/address_repository.dart';

class AddressController extends GetxController {
  //instance creator
  static AddressController get instance => Get.find();

  //******************** new address form properties **********************/
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  final Rx<TextEditingController> street = TextEditingController().obs;
  final Rx<TextEditingController> postalCode = TextEditingController().obs;
  final Rx<TextEditingController> city = TextEditingController().obs;
  final Rx<TextEditingController> state = TextEditingController().obs;
  final Rx<TextEditingController> country = TextEditingController().obs;
  final GlobalKey<FormState> newAddressFromKey = GlobalKey<FormState>();
  //***********************************************************************/

  //addres repository
  final _addressRepository = Get.put(AddressRepository());

  //all user address
  RxList<AddressModel> allUserAddress = <AddressModel>[].obs;

  //selected user addres
  Rx<AddressModel> selectedUserAddress = AddressModel.emptyAddressModel().obs;

  //loader value
  Rx<bool> loader = false.obs;

  @override
  onInit() {
    getUserAddresses();
    super.onInit();
  }

  //**************************************************************************/
  //fetch user address
  Future<void> getUserAddresses() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //start loading
      loader.value = true;

      //fatch data
      final data = await _addressRepository.fetchUserAddress();

      //asign all user address
      allUserAddress.assignAll(data);

      //asign selected user addres
      selectedUserAddress.value = allUserAddress.firstWhere((address) => address.isSelectedAddress == true, orElse: () => AddressModel.emptyAddressModel());

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //**************************************************************************/
  //select new address
  Future<void> selectNewAddress(String id) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      loader.value = true;

      //select new addres
      await _addressRepository.selectNewAddress(id);

      //fatch data
      final data = await _addressRepository.fetchUserAddress();

      //asign all user address
      allUserAddress.assignAll(data);

      //asign selected user addres
      selectedUserAddress.value = allUserAddress.firstWhere((address) => address.isSelectedAddress == true, orElse: () => AddressModel.emptyAddressModel());

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

//*********************************************************************/
  //add new address
  Future<void> addNewAddress() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //validation check
      if (!newAddressFromKey.currentState!.validate()) return;

      //start loading
      loader.value = true;

      //add new address
      await _addressRepository.addNewAddress(AddressModel(
        id: HelperFunctions.generateId(),
        name: name.value.text,
        phoneNumber: phoneNumber.value.text,
        street: street.value.text,
        city: city.value.text,
        state: state.value.text,
        postalCode: postalCode.value.text,
        country: country.value.text,
        isSelectedAddress: false,
        dateTime: DateTime.now(),
      ));

      //fatch data
      final data = await _addressRepository.fetchUserAddress();

      //asign all user address
      allUserAddress.assignAll(data);

      //asign selected user addres
      selectedUserAddress.value = allUserAddress.firstWhere((address) => address.isSelectedAddress == true, orElse: () => AddressModel.emptyAddressModel());

      //stop loading
      loader.value = false;

      //show success masseage
      AppPopups.showSuccessSnackBar(title: "Added successfully", message: 'your new address is added successfully');

      //navigate to address screen
      // Get.offNamed(AppRouts.adressScreen);
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //********************************************************************/
  //delete address
  Future<void> deletAddress(String id) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      loader.value = true;

      //delete address
      await _addressRepository.deletAddress(id);

      //fatch data
      final data = await _addressRepository.fetchUserAddress();

      //asign all user address
      allUserAddress.assignAll(data);

      //asign selected user addres
      selectedUserAddress.value = allUserAddress.firstWhere((address) => address.isSelectedAddress == true, orElse: () => AddressModel.emptyAddressModel());

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //get user address by id
  Future<AddressModel> getSelectedUserAdressById(String userId) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return AddressModel.emptyAddressModel();
      }

      //start loading
      loader.value = true;

      //fatch data
      final data = await _addressRepository.getSelectedUserAdressById(userId);

      //asign selected user addres
      final selectedAddress = data.firstWhere((address) => address.isSelectedAddress == true, orElse: () => AddressModel.emptyAddressModel());

      //stop loading
      loader.value = false;
      //return selected address
      return selectedAddress;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
      return AddressModel.emptyAddressModel();
    } finally {
      loader.value = false;
    }
  }
}
