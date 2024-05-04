import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../../widgets/Explore/Trainer Details/about/custom_list.dart';

import '../../../widgets/Explore/Trainers/trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import '../../Tabs/Explore/model/trainer.dart';
import '../About/about.dart';
import '../About/controller/trainer_about_controller.dart';
import '../Free Plans/free_plans.dart';
import '../Package/package.dart';
import '../Reviews/reviews.dart';
import '../Transformation/controller/transformation_controller.dart';
import '../Transformation/transformation .dart';

class TrainerDetails extends StatelessWidget {
  final String trainerId;
  final Trainer trainer;

  const TrainerDetails({
    Key? key,
    required this.trainerId,
    required this.trainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrainerDetailsController controller =
        Get.put(TrainerDetailsController());
    controller.loadTrainerDetails(trainerId);
    final TransformController controller2 = Get.put(TransformController());
    controller2.fetchDetails(trainerId);

    return Obx(() {
      if (controller.isLoading.isTrue) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: CustomAppBar(
            titleText: trainer.fullName ?? '',
            showContainer: true,
            isShowProfile: true,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: trainer.profilePhoto != null
                          ? Image.network(
                              trainer.profilePhoto!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/trainer.png',
                                      fit: BoxFit.cover),
                            )
                          : Image.asset('assets/images/trainer.png',
                              fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          child: CustomLabelWidget(
                            title: trainer.fullName ?? '',
                          ),
                        ),
                      ],
                    ),
                    RatingWidget(
                        rate: trainer.averageRating.toStringAsFixed(0)),
                    const SizedBox(height: 16),
                    CustomTabBar(isShowFavourite: true, tabTexts: [
                      'About',
                      'Reviews',
                      'Gallery',
                      'Free Plans'
                    ]),
                    Container(
                      height: 600,
                      child: TabBarView(
                        children: [
                          AboutSection(
                            about: controller.trainerDetails.value?.biography ??
                                'No biography available',
                            awardsList: controller.trainerDetails.value
                                    ?.qualificationsAndAchievements
                                    ?.map((achievement) =>
                                        AwardData(imagePath: achievement))
                                    .toList() ??
                                [],
                            // description:
                            //     controller.trainerDetails.value?.biography ??
                            //         'No biography available',
                            email: controller.trainerDetails.value?.email ??
                                'No email provided',
                            experience: controller
                                    .trainerDetails.value?.yearsOfExperience ??
                                'No experience provided',
                            location:
                                controller.trainerDetails.value?.location ??
                                    'No location provided',
                            createdAt:
                                controller.trainerDetails.value?.createdAt ??
                                    'No creation date provided',
                            age: controller.trainerDetails.value?.age ??
                                'No age provided',
                            specializations: controller
                                    .trainerDetails.value?.specializations ??
                                [],
                          ),
                          SingleChildScrollView(child: ReviewSection(
                              trainerId: trainerId,
                          )),
                          SingleChildScrollView(
                              child: Gallery(
                            title: controller2
                                    .transformationDetails.value?.title ??
                                '',
                            description: controller2
                                    .transformationDetails.value?.description ??
                                '',
                            beforeImage: controller2
                                    .transformationDetails.value?.beforeImage ??
                                '',
                            afterImage: controller2
                                    .transformationDetails.value?.afterImage ??
                                '',
                          )),
                          SingleChildScrollView(child: FreePlans()),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: CustomButton(
                      text: 'Choose Your Package',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PackageScreen(),
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Helper widget classes like CustomLabelWidget, RatingWidget, etc., need to be defined similarly to how you've handled other custom widgets.
