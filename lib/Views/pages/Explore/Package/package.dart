import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../../widgets/Explore/Trainer Details/Packages/text_dot.dart';
import '../../../widgets/General/customBotton.dart';
import 'check_out.dart';
import 'controller/package_controller.dart';
import 'controller/subscription_details.dart';

class PackageScreen extends StatefulWidget {
  final String packageIds;

  PackageScreen({Key? key, required this.packageIds}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  int selectedContainerIndex = -1;
  final PackageController controller = Get.put(PackageController());
  @override
  void initState() {
    super.initState();
    controller.fetchPackagesById(widget.packageIds);
  }

  void selectContainer(int index) {
    setState(() {
      selectedContainerIndex = (selectedContainerIndex == index) ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Package',
        showContainer: true,
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(
              child: CustomLoder(
            color: colorBlue,
            size: 35,
          ));
        } else if (controller.packages.isEmpty) {
          return Center(child: Text("No packages found."));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ...List.generate(controller.packages.length, (index) {
                  var package = controller.packages[index];
                  return PackageSelector(
                    index: index,
                    isSelected: selectedContainerIndex == index,
                    title: package.packageName,
                    description: '${package.duration} months',
                    price: package.price.toString(),
                    price2: 'EGP',
                    svgAsset: selectedContainerIndex == index
                        ? 'assets/svgs/PackageSelect.svg'
                        : 'assets/svgs/UnPackageSelect.svg',
                    onTap: () => selectContainer(index),
                  );
                }),
                const SizedBox(height: 8),
                const CustomLabelWidget(title: 'Package Details'),
                if (selectedContainerIndex != -1)
                  TextWithDot(
                      text: controller
                          .packages[selectedContainerIndex].description),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Proceed to Checkout',
                  onPressed: () async {
                    if (selectedContainerIndex != -1 ) {
                      String packageId =
                          controller.packages[selectedContainerIndex].id;
                     await controller.selectPackage(packageId);

                      Get.to(() => CheckoutScreen(packageId: packageId),
                          binding: BindingsBuilder(() {
                        Get.put(CheckoutController());
                      }));
                    } else {
                      Get.snackbar('Error', 'Please select a package first.');
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }
      }),
    );
  }
}










//TextWithDot(text:  controller.packages[selectedContainerIndex].description),