import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/featuers/bannars/controllers/add_banner_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

class AddBannerResponsiveLayout extends StatelessWidget {
  const AddBannerResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBannerController addBannerController = Get.put(AddBannerController());
    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSizes.md),
              RoundedContainer(
                width: HelperFunctions.isDesktopScreen(context) ? 400 : null,
                child: CustomeTiteledCard(
                  title: addBannerController.isUpdate.value ? "Update Banner" : "Create New Banner",
                  child: Column(
                    children: [
                      const SizedBox(height: AppSizes.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                          Center(
                            child: RoundedContainer(
                              color: AppColors.softGrey,
                              margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                              alignment: Alignment.center,
                              width: 200,
                              height: 150,
                              child: addBannerController.currentBannerImage.value.url.isNotEmpty
                                  ? CustomImage(
                                      imagePath: addBannerController.currentBannerImage.value.url,
                                      fit: BoxFit.fill,
                                      width: 190,
                                      height: 140,
                                      borderRadius: BorderRadius.circular(12),
                                      imageType: ImageType.network,
                                    )
                                  : const Icon(Iconsax.gallery, size: 120),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                await addBannerController.openMediaScreen();
                              },
                              child: const Text("Select Image"),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                          Text('Make Banner Active Or InActive', style: Theme.of(context).textTheme.labelSmall),
                          Row(
                            children: [
                              Checkbox(
                                value: addBannerController.isActive.value,
                                onChanged: (value) {
                                  addBannerController.changeIsActive(value!);
                                },
                              ),
                              // const SizedBox(width: AppSizes.sm),
                              Text("Active", style: Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                          SizedBox(
                            width: HelperFunctions.isDesktopScreen(context) ? 150 : double.infinity,
                            child: DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(20),
                              value: BannerActivationPathes.selectPath,
                              isExpanded: false,
                              items: BannerActivationPathes.values
                                  .map(
                                    (e) => DropdownMenuItem(
                                      onTap: () {},
                                      value: e,
                                      child: Text(
                                        HelperFunctions.capitalizeFirst("/${e.name}"),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) async {
                                if (value != null) {
                                  addBannerController.onBannerActivationPathesChanged(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                          AppPrimaryButton(
                            label: addBannerController.isUpdate.value ? "Update" : "Create",
                            onTap: () async {
                              if (addBannerController.isUpdate.value) {
                                await addBannerController.updateBanner();
                              } else {
                                await addBannerController.createBanner();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
