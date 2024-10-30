import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/app_common_widgets/common_elevated_button.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:venus/app/modules/login/views/login_view.dart';
import 'package:venus/main.dart';
import '../core/services/biometric_service.dart';
import '../modules/consultantPay/controllers/consultant_pay_controller.dart';
import '../modules/consultantPay/views/consultant_pay_view.dart';
import '../modules/costestimate/views/costestimate_view.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/hospitalDoctors/controllers/hospital_doctors_controller.dart';
import '../modules/hospitalDoctors/views/hospital_doctors_view.dart';
import '../modules/insuranceCompanies/controllers/insurance_companies_controller.dart';
import '../modules/insuranceCompanies/views/insurance_companies_view.dart';
import '../modules/opdAppointments/controllers/opd_appointments_controller.dart';
import '../modules/opdAppointments/views/opd_appointments_view.dart';
import '../modules/patientlist/controllers/patientlist_controller.dart';
import '../modules/patientlist/views/patientlist_view.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/schduleSurgeries/controllers/schdule_surgeries_controller.dart';
import '../modules/schduleSurgeries/views/schdule_surgeries_view.dart';
import '../modules/schedulechargelist/controllers/schedulechargelist_controller.dart';
import '../modules/schedulechargelist/views/schedulechargelist_view.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

PersistentTabController? persistentController =
    PersistentTabController(initialIndex: 1);

class _MyDrawerState extends State<MyDrawer> {
  String userName = '';
  String email = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('username') ?? "-";
    email = pref.getString('email') ?? "-";
    setState(() {});
  }

  logoutDialog(
      {required BuildContext context,
      required String message,
      required String longMessage,
      required String buttonText,
      required String button2Text,
      bool? logout,
      bool? deleteAccount}) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      isButtonVisible: false,
      backgroundColor: ConstColor.whiteColor,
      alertPadding: EdgeInsets.zero,
      buttonAreaPadding: EdgeInsets.zero,
      descStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: Sizes.px14,
        color: ConstColor.boldBlackColor,
      ),
      descTextAlign: TextAlign.center,
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Sizes.px20,
          color: ConstColor.boldBlackColor),
      alertAlignment: Alignment.center,
    );
    return Alert(
      context: context,
      style: alertStyle,
      onWillPopActive: true,
      type: AlertType.none,
      content: SizedBox(
        width: Get.width * 0.70,
        child: Column(
          children: [
            SizedBox(
              height: Sizes.crossLength * 0.016,
            ),
            AppText(
              text: message,
              fontColor: ConstColor.boldBlackColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              fontSize: Sizes.px20,
            ),
            SizedBox(height: Sizes.crossLength * 0.016),
            Row(
              children: [
                Expanded(
                  child: AppText(
                    text: longMessage,
                    fontColor: ConstColor.boldBlackColor,
                    fontSize: Sizes.px14,
                    maxLine: 3,
                    textAlign: TextAlign.center,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Sizes.crossLength * 0.016,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.crossLength * 0.010,
              ),
              child: const Divider(
                color: ConstColor.dividerColor,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.crossLength * 0.020),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      var bottomBarController = Get.put(BottomBarController());
                      hideBottomBar.value = true;

                      BiometricAuth.isBiomerticOn = false;
                      BiometricAuth.isBiomerticOn = null;

                      // setState(() {});
                      bottomBarController.update();
                      Get.rawSnackbar(message: 'Logout Successfully');
                     await Get.offAll(const LoginView(),
                          duration: const Duration(milliseconds: 700))?.then((value) =>     Get.rawSnackbar(message: 'Logout Successfully'),);

                    },
                    child: AppText(
                      text: buttonText.toUpperCase(),
                      fontColor: ConstColor.errorBorderColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      fontSize: Sizes.px14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: AppText(
                      text: button2Text.toUpperCase(),
                      fontColor: ConstColor.boldBlackColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                      fontSize: Sizes.px14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Sizes.crossLength * 0.016,
            ),
          ],
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).viewPadding.top;
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(builder: (controller) {
      return Drawer(
        elevation: 0,
        width: Get.width * 0.85,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
        ),
        backgroundColor: ConstColor.whiteColor,
        child: Padding(
          padding: EdgeInsets.only(
              left: Sizes.crossLength * 0.015,
              right: Sizes.crossLength * 0.015),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: topPadding + 30,
                    ),
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     Get.put(ProfileController());
                    //     var homeController = Get.put(HomeController());
                    //     PersistentNavBarNavigator.pushNewScreen(
                    //       context,
                    //       screen: ProfileView(),
                    //       withNavBar: false,
                    //       pageTransitionAnimation:
                    //           PageTransitionAnimation.cupertino,
                    //     ).then((value) {
                    //       homeController.getDashboardData();
                    //     });
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //             width: 1, color: ConstColor.hintTextColor),
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(10))),
                    //     child: Padding(
                    //       padding: EdgeInsets.only(
                    //           left: Sizes.crossLength * 0.012,
                    //           right: Sizes.crossLength * 0.012,
                    //           top: Sizes.crossLength * 0.015,
                    //           bottom: Sizes.crossLength * 0.015),
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                     width: 1,
                    //                     color: ConstColor.hintTextColor),
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(10))),
                    //             child: Center(
                    //               child: Padding(
                    //                 padding: EdgeInsets.only(
                    //                     left: Sizes.crossLength * 0.015,
                    //                     right: Sizes.crossLength * 0.015,
                    //                     top: Sizes.crossLength * 0.030,
                    //                     bottom: Sizes.crossLength * 0.030),
                    //                 child: Image.asset(
                    //                   ConstAsset.profileImage,
                    //                   scale: 2,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: Sizes.crossLength * 0.012,
                    //           ),
                    //           Expanded(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 AppText(
                    //                   text: userName,
                    //                   fontSize: Sizes.px16,
                    //                   fontWeight: FontWeight.w700,
                    //                   fontColor: ConstColor.blackColor00313C,
                    //                 ),
                    //                 SizedBox(
                    //                   height: Sizes.crossLength * 0.002,
                    //                 ),
                    //                 AppTextField(
                    //                   enabled: false,
                    //                   controller: controller.emailController,
                    //                   hintText: 'Enter Email Address',
                    //                   onTapOutside: (event) {
                    //                     FocusScope.of(context).unfocus();
                    //                   },
                    //                   validator: (val) {
                    //                     if (val!.trim().isEmpty) {
                    //                       return "Please enter Email Address.";
                    //                     } else {
                    //                       return null;
                    //                     }
                    //                   },
                    //                 ),
                    //                 AppText(
                    //                   text: email,
                    //                   fontSize: Sizes.px13,
                    //                   fontWeight: FontWeight.w500,
                    //                   fontColor: ConstColor.blackColor00313C,
                    //                 ),
                    //                 SizedBox(
                    //                   height: Sizes.crossLength * 0.010,
                    //                 ),
                    //                 SizedBox(
                    //                   height: 30,
                    //                   child: OutlinedButton(
                    //                       style: OutlinedButton.styleFrom(
                    //                         // padding: const EdgeInsets.only(top: 1),
                    //                         backgroundColor: ConstColor
                    //                             .outlineButtonBacground,
                    //                         side: const BorderSide(
                    //                             width: 1.0,
                    //                             color:
                    //                                 ConstColor.headingTexColor),
                    //                       ),
                    //                       onPressed: () {
                    //                         Get.to(() => EditProfileView());
                    //                       },
                    //                       child: AppText(text: 'Edit Profile')),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           SvgPicture.asset(ConstAsset.sideArrow)
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        Get.put(ProfileController());
                        var homeController = Get.put(HomeController());
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ProfileView(
                              email: controller
                                  .emailController.text), // Pass the email here
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ).then((value) {
                          homeController.getDashboardData();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: ConstColor.hintTextColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.crossLength * 0.012,
                            vertical: Sizes.crossLength * 0.015,
                          ),
                          // padding: EdgeInsets.only(
                          //   left: Sizes.crossLength * 0.012,
                          //   right: Sizes.crossLength * 0.012,
                          //   top: Sizes.crossLength * 0.015,
                          //   bottom: Sizes.crossLength * 0.015,
                          // ),

                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: ConstColor.hintTextColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child:controller.imageBytes != null?
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(controller.imageBytes!,
                                    fit: BoxFit.fill,
                                    height: Sizes.crossLength*0.060,
                                    width: Sizes.crossLength*0.06,
                                  ),
                                ) : Center(
                                  child: Padding(

                                    // padding: EdgeInsets.only(
                                    //   left: Sizes.crossLength * 0.015,
                                    //   right: Sizes.crossLength * 0.015,
                                    //   top: Sizes.crossLength * 0.030,
                                    //   bottom: Sizes.crossLength * 0.030,
                                    // ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Sizes.crossLength*0.015,
                                      vertical: Sizes.crossLength * 0.030,
                                    ),

                                    child:
                                    Image.asset(
                                      ConstAsset.profileImage,
                                      scale: 2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Sizes.crossLength * 0.012),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: userName,
                                      fontSize: Sizes.px16,
                                      fontWeight: FontWeight.w700,
                                      fontColor: ConstColor.blackColor00313C,
                                    ),
                                    SizedBox(height: Sizes.crossLength * 0.002),
                                    AppText(

                                      text: controller
                                              .emailController.text.isNotEmpty
                                          ? controller.emailController.text
                                          : ' - ',
                                      fontSize: Sizes.px13,
                                      fontWeight: FontWeight.w500,
                                      fontColor: ConstColor.blackColor00313C,
                                    ),
                                    SizedBox(height: Sizes.crossLength * 0.010),
                                    SizedBox(
                                      height: 30,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              ConstColor.outlineButtonBacground,
                                          side: const BorderSide(
                                            width: 1.0,
                                            color: ConstColor.headingTexColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Get.to(() => EditProfileView());
                                        },
                                        child: AppText(text: 'Edit Profile'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(ConstAsset.sideArrow),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.040,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            hideBottomBar.value = false;
                            Navigator.pop(context);
                            var patientController =
                                Get.put(PatientlistController());
                            var homeController = Get.put(HomeController());
                            // var bottomBarCntrl = Get.put(BottomBarController());

                            patientController.searchController.clear();
                            patientController.filterPatientList = [];
                            patientController.selectedOrganizationList = [];
                            patientController.selectedFloorList = [];
                            patientController.selectedWardList = [];
                            patientController.sortBySelected = null;
                            patientController.update();
                            patientController.getFilterData(isLoader: true);
                            patientController.getDashboardFilters(
                                isLoader: false);
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const PatientlistView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ).then(
                                (value) => homeController.getDashboardData());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.admittedPatient),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              AppText(
                                text: 'Admitted Patients',
                                fontSize: Sizes.px16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Sizes.crossLength * 0.025),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            Navigator.pop(context);
                            var schduleController =
                                Get.put(SchduleSurgeriesController());
                            var homeController = Get.put(HomeController());
                            calenderType = 1;
                            schduleController.selectedScheduleDate =
                                DateTime.now();
                            procedureDates = [];
                            schduleController.procedureListData = [];
                            schduleController.scrollController();
                            schduleController.getOpdSchdulesDates(
                                isLoader: true);
                            schduleController.getSchduleListApi(isLoader: true);
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const SchduleSurgeriesView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ).then(
                                (value) => homeController.getDashboardData());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.surgiryImage),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppText(
                                  text: 'Schedule Surgeries/Procedures',
                                  fontSize: Sizes.px16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            Navigator.pop(context);
                            var appointmentcontroller =
                                Get.put(OpdAppointmentsController());
                            var homeController = Get.put(HomeController());
                            calenderType = 0;
                            appointmentcontroller.selectedDate = DateTime.now();
                            appointmentcontroller.appointmentData = [];
                            appointMentsDate = [];
                            appointmentcontroller.searchController.clear();
                            appointmentcontroller.scrollController();
                            appointmentcontroller.getOpdAppointmentsDates(
                                isLoader: true);
                            appointmentcontroller.getOpdAppointments(
                                isLoader: true);
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const OpdAppointmentsView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ).then((value) {
                              homeController.getDashboardData();
                            });
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.opdImage),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              AppText(
                                text: 'OPD Appointments',
                                fontSize: Sizes.px16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            hideBottomBar.value = false;

                            Navigator.pop(context);
                            var schduleCharges =
                                Get.put(SchedulechargelistController());
                            var homeController = Get.put(HomeController());
                            schduleCharges.selectedTab = 0;
                            schduleCharges.searchController.clear();
                            schduleCharges.selectedOperationList = [];
                            schduleCharges.selectedOperationId = [];
                            schduleCharges.roomsData = [];
                            hideBottomBar.value = false;
                            schduleCharges.doctorsListData = [];
                            schduleCharges.operationClassListData = [];
                            schduleCharges.surgeryListData = [];
                            schduleCharges.operationClassController.clear();
                            schduleCharges.scrollListner();
                            schduleCharges.getRooms(isLoader: true);
                            schduleCharges.getOperationClass();
                            schduleCharges.getOperationName();
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const SchedulechargelistView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.chargesImage),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              AppText(
                                text: 'Schedule of Charges',
                                fontSize: Sizes.px16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            Navigator.pop(context);
                            calenderType = 2;
                            previousDateEnable = false;
                            Get.to(const CostestimateView());
                            // Get.to(() => const CostestimateView());
                            // if (!Get.isSnackbarOpen) {
                            //   Get.rawSnackbar(message: "Coming Soon");
                            // }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.viewSurgical),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppText(
                                  text: 'View Surgical Procedure Estimate',
                                  fontSize: Sizes.px16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            //Get.to(const ConsultantPayView());
                            Navigator.pop(context);
                            var homeController = Get.put(HomeController());
                            var consultantController =
                                Get.put(ConsultantPayController());
                            consultantController.paymentStatus = [];
                            consultantController.selectedItem = '2024'.obs;
                            consultantController.getConsultantPay();
                            consultantController.scrollController();
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const ConsultantPayView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ).then(
                                (value) => homeController.getDashboardData());
                            // if (!Get.isSnackbarOpen) {
                            //   Get.rawSnackbar(message: "Coming Soon");
                            // }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.consultant),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppText(
                                  text: 'Consultant Pay',
                                  fontSize: Sizes.px16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        GestureDetector(
                          // onTap: () {
                          //   var bottomBarCntrl = Get.put(BottomBarController());
                          //   bottomBarCntrl.persistentController!.jumpToTab(1);
                          //   bottomBarCntrl.update();
                          // Future.delayed(const Duration(milliseconds: 300))
                          //     .then((value) {});
                          //   Navigator.pop(context);
                          //   var homeController = Get.put(HomeController());
                          //   var InsuranceCompany =
                          //       Get.put(InsuranceCompaniesController());
                          //   InsuranceCompany.getInsuranceCompany();
                          //   PersistentNavBarNavigator.pushNewScreen(
                          //     homeController.scaffoldKey.currentContext!,
                          //     screen: const InsuranceCompaniesView(),
                          //     withNavBar: true,
                          //     pageTransitionAnimation:
                          //         PageTransitionAnimation.cupertino,
                          //   ).then(
                          //       (value) => homeController.getDashboardData());
                          // },

                          onTap: () {
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});
                            Navigator.pop(context);
                            var homeController = Get.put(HomeController());
                            var InsuranceCompany =
                                Get.put(InsuranceCompaniesController());
                            InsuranceCompany.selectedTab = 0;
                            InsuranceCompany.getInsuranceCompany(
                                selectedTab: 'Cashless');
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const InsuranceCompaniesView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ).then(
                                (value) => homeController.getDashboardData());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.insurance),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppText(
                                  text: 'Insurance Companies',
                                  fontSize: Sizes.px16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            // Get.find<BottomBarController>().navigateToHome();
                            var bottomBarCntrl = Get.put(BottomBarController());
                            bottomBarCntrl.persistentController!.jumpToTab(1);
                            bottomBarCntrl.update();
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {});

                            Navigator.pop(context);
                            var homeController = Get.put(HomeController());
                            var hospitalDoctor =
                                Get.put(HospitalDoctorsController());
                            hospitalDoctor.getHospitalDoctors();
                            //Get.to(const HospitalDoctorsView());
                            //bottomBarController.navigateToHome();
                            // var bottomBarController =
                            //     Get.put(BottomBarController());
                            // void navigateToHome() {
                            //   persistentController!.jumpToTab(1);
                            //   //update();
                            // }
                            // Get.find<BottomBarController>().navigateToHome();
                            PersistentNavBarNavigator.pushNewScreen(
                              homeController.scaffoldKey.currentContext!,
                              screen: const HospitalDoctorsView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ).then(
                                (value) => homeController.getDashboardData());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ConstAsset.hospitalDoctor),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppText(
                                  text: 'Hospital Doctors',
                                  fontSize: Sizes.px16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: Sizes.crossLength * 0.010,
                    ),
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: AppButton(
                        radius: 50,
                        isDelete: true,
                        onPressed: () async {
                          logoutDialog(
                              context: context,
                              button2Text: 'Cancel',
                              buttonText: 'Logout',
                              longMessage: "Are you sure you want to logout?",
                              message: 'Logout');
                        },
                        text: 'Logout',
                      ),
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.015,
                    ),
                    Image.asset(
                      'assets/images/png/sidemenulogo.png',
                      scale: 2.5,
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.010,
                    ),
                    AppText(
                      text: 'Version 1.0.0',
                      fontSize: Sizes.px13,
                      fontWeight: FontWeight.w500,
                      fontColor: ConstColor.versionTextColor,
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.030,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
