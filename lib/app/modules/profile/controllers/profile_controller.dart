// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:dio/dio.dart';
// import 'package:mime/mime.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:venus/app/modules/profile/model/drSpecialities_model.dart';
// import '../../../app_common_widgets/common_elevated_button.dart';
// import '../../../app_common_widgets/common_text.dart';
// import '../../../app_common_widgets/custom_pop_menu.dart';
// import '../../../app_common_widgets/sizer_constant.dart';
// import '../../../core/constant/const_api_url.dart';
// import '../../../core/services/api_service.dart';
// import '../../../core/services/biometric_service.dart';
// import '../../../core/them/const_color.dart';
// import '../../login/views/login_view.dart';
// import 'dart:ui' as ui;
// import '../model/drDegree.dart';
// import '../model/profile_model.dart';
// import 'package:dio/dio.dart' as dio_package;
// import '../model/save_model.dart';
// import '../views/widget/custom_calendar.dart';
//
// class ProfileController extends GetxController {
//   bool apiCall = false;
//   final count = 0.obs;
//   DateTime? selectedDate;
//   CustomPopupMenuController doctorSpecialistNameController = CustomPopupMenuController();
//   CustomPopupMenuController degreeNameController = CustomPopupMenuController();
//   final nameController = TextEditingController();
//   final mobileController = TextEditingController();
//   final emailController = TextEditingController();
//   final doctorSpecialityController = TextEditingController();
//   final degreeController = TextEditingController();
//   final registrationController = TextEditingController();
//   final dateOfOperation = TextEditingController();
//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final stateController = TextEditingController();
//   final profileForKey = GlobalKey<FormState>();
//   List<ProfileListData>? profileClassListData;
//   List<DrSpecialitiesListData> drSpecialitiesData = [];
//   List<DrDegreeListData> drDegreeListData = [];
//   bool _isImagePickerActive = false;
//   String? selectedImagePath;
//   var isBiometricOn = false.obs;
//   Uint8List? imageBytes;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // getProfileClass();
//     // getDrSpeciality();
//     // getDrDegree();
//     // getProfileImage();
//   }
//
//   Future<void> selectImage(BuildContext context) async {
//     if (_isImagePickerActive) {
//       debugPrint('Image picker is already active.');
//       return;
//     }
//     _isImagePickerActive = true;
//     final picker = ImagePicker();
//     final source = await showModalBottomSheet<ImageSource>(
//         context: context,
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return SizedBox(
//             height: 150,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: Sizes.crossLength * 0.040,
//                     top: Sizes.crossLength * 0.020,
//                   ),
//                   child: AppText(
//                     text: 'Choose Photo',
//                     fontSize: Sizes.px20,
//                     fontWeight: FontWeight.w600,
//                     fontColor: ConstColor.blackColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: Sizes.crossLength * 0.01,
//                 ),
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: Sizes.crossLength * 0.040,
//                       ),
//                       child: Column(
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               Icons.camera,
//                               size: Sizes.crossLength * 0.040,
//                               color: ConstColor.black6B6B6B,
//                             ),
//                             onPressed: () => getImageFromGalleryAndCamera(
//                                 isOpenCamera: true).then(
//                               (value) => Get.back(),
//                             ),
//                             // Navigator.pop(context, ImageSource.camera),
//                           ),
//                           SizedBox(height: Sizes.crossLength * 0.001),
//                           AppText(
//                             text: 'Camera',
//                             fontSize: Sizes.px16,
//                             fontWeight: FontWeight.w600,
//                             fontColor: ConstColor.black6B6B6B,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: Sizes.crossLength * 0.040,
//                       ),
//                       child: Column(
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               Icons.photo,
//                               size: Sizes.crossLength * 0.040,
//                               color: ConstColor.black6B6B6B,
//                             ),
//                             onPressed: () => getImageFromGalleryAndCamera(
//                                 isOpenCamera: false).then(
//                               (value) => Get.back(),
//                             ),
//                             // Navigator.pop(context, ImageSource.gallery),
//                           ),
//                           AppText(
//                             text: 'Gallery',
//                             fontSize: Sizes.px16,
//                             fontWeight: FontWeight.w600,
//                             fontColor: ConstColor.black6B6B6B,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         });
//
//     if (source != null) {
//       PermissionStatus status;
//
//       if (source == ImageSource.gallery) {
//         status = await Permission.photos.request();
//       } else if (source == ImageSource.camera) {
//         status = await Permission.camera.request();
//       } else {
//         status = PermissionStatus.denied;
//       }
//
//       if (status == PermissionStatus.granted) {
//         final pickedFile = await picker.pickImage(source: source);
//         _isImagePickerActive = false;
//         if (pickedFile != null) {
//           selectedImagePath = pickedFile.path;
//           Get.rawSnackbar(message: "Profile picture updated successfully.");
//           update();
//         } else {
//           Get.rawSnackbar(message: "No image was selected, please try again.");
//         }
//       } else if (status == PermissionStatus.permanentlyDenied) {
//         _isImagePickerActive = false;
//         Get.dialog(
//           AlertDialog(
//             title: const Text("Permission Denied"),
//             content: const Text(
//                 "Permission has been permanently denied. Do you want to open settings to enable it?"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Get.back(); // Close the dialog
//                 },
//                 child: const Text("No"),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   Get.back(); // Close the dialog
//                   await openAppSettings(); // Open app settings
//                 },
//                 child: const Text("Yes"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         _isImagePickerActive = false;
//       }
//     }
//     _isImagePickerActive = false;
//   }
//
//   final picker = ImagePicker();
//
//   Future<void> getImageFromGalleryAndCamera({
//     required bool isOpenCamera,
//   }) async {
//     if (isOpenCamera) {
//       if (isOpenCamera == true) {
//         await requestPermission(typeCamera: true);
//       } else {
//         Get.rawSnackbar(message: 'Camera permission denied.');
//       }
//     } else {
//       if (Platform.isAndroid) {
//         if (isOpenCamera == false) {
//           await requestPermission(typeCamera: false);
//           // return await _pickImage(ImageSource.gallery);
//         } else {
//           Get.rawSnackbar(message: 'Gallery/Storage permission denied.');
//         }
//       } else if (Platform.isIOS) {
//         if (isOpenCamera == false) {
//           //return await _pickImage(ImageSource.gallery);
//           return await requestPermission(typeCamera: false);
//         } else {
//           Get.rawSnackbar(message: 'Photos permission denied.');
//         }
//       }
//     }
//   }
//
//   Future<void> requestPermission({bool typeCamera = true}) async {
//     Permission? permission;
//
//     if (typeCamera) {
//       permission = Permission.camera;
//     } else {
//       if (Platform.isAndroid) {
//         var androidInfo = await DeviceInfoPlugin().androidInfo;
//         // Android versions < 12 (API level 31) use storage permission
//         if (androidInfo.version.sdkInt < 31) {
//           permission = Permission.storage;
//         } else {
//           permission = Permission
//               .photos;
//         }
//       } else if (Platform.isIOS) {
//         permission =
//             Permission.photos;
//       }
//     }
//
//
//     if (await permission!.isDenied) {
//       final result = await permission.request();
//       if (result.isGranted) {
//         if (typeCamera) {
//           await _openCamera();
//         } else {
//           await _openGallery();
//         }
//       } else if (result.isPermanentlyDenied) {
//         _showPermissionDeniedDialog();
//         openAppSettings();
//       }
//     } else if (await permission.isGranted) {
//
//       if (typeCamera) {
//         await _openCamera();
//       } else {
//         await _openGallery();
//       }
//     } else if (await permission.isPermanentlyDenied) {
//
//       _showPermissionDeniedDialog();
//       openAppSettings();
//     }
//   }
//
//   Future<void> _openGallery() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         uploadProfilePicture(filename: image.name, imagePAth: image.path).then(
//           (value) {
//             getProfileImage();
//           //  Get.back();
//           },
//         );
//       } else {
//         Get.rawSnackbar(message: 'No image selected.');
//       }
//     } catch (e) {
//       Get.rawSnackbar(message: 'Failed to pick image: $e');
//     }
//     debugPrint("Opening Gallery");
//     update();
//   }
//
//   Future<void> _openCamera() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         uploadProfilePicture(filename: image.name, imagePAth: image.path).then(
//           (value) {
//             getProfileImage();
//             // Get.back();
//           },
//         );
//       } else {
//         Get.rawSnackbar(message: 'No image selected.');
//       }
//     } catch (e) {
//       Get.rawSnackbar(message: 'Failed to pick image: $e');
//     }
//     debugPrint("Opening Camera");
//     update();
//   }
//
//   void _showPermissionDeniedDialog() {
//     Get.defaultDialog(
//       barrierDismissible: true,
//
//       title: 'Permission Required',
//       middleText: 'Please enable the required permission in settings.',
//       onConfirm: () {
//         openAppSettings(); // Open app settings if permission is permanently denied
//       },
//       textConfirm: 'Open Settings',
//       textCancel: 'Cancel',
//     );
//   }
//
//   void biometricOnChanged(bool v) async {
//     await BiometricAuth.checkBiometric();
//     if (v) {
//       if (BiometricAuth.isBiometricAvailable || BiometricAuth.isFaceAvailable) {
//         await BiometricAuth.authenticate(value: v, fromLogin: true);
//         isBiometricOn.value = v;
//       } else {
//         onBiometricSetupDialog();
//       }
//     } else {
//       BiometricAuth.onBiometricSwitch(v);
//       isBiometricOn.value = v;
//     }
//   }
//
//   Future<void> onBiometricSetupDialog() {
//     return showDialog(
//       context: Get.context!,
//       builder: (context) {
//         return SizedBox(
//           width: Get.size.width * 0.45,
//           child: AlertDialog(
//             title: Center(
//               child: AppText(
//                 text: "Alert",
//                 textAlign: TextAlign.center,
//                 fontColor: ConstColor.buttonColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: Sizes.px18,
//               ),
//             ),
//             content: AppText(
//               text:
//                   "Biometric is not set up. Would you like to set it up for biometric login?",
//               fontSize: Sizes.px14,
//               textAlign: TextAlign.center,
//               fontColor: ConstColor.blackTextColor,
//               fontWeight: FontWeight.w300,
//             ),
//             actions: [
//               SizedBox(
//                 height: Sizes.crossLength * 0.050,
//                 child: AppButton(
//                   radius: 50,
//                   text: "Biometric Setup",
//                   onPressed: () {
//                     BiometricAuth.goToBiometricSettings().whenComplete(() {
//                       Get.back();
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   getBackFunction({required BuildContext context}) {
//     nameController.clear();
//     mobileController.clear();
//     emailController.clear();
//     doctorSpecialityController.clear();
//     degreeController.clear();
//     registrationController.clear();
//     dateOfOperation.clear();
//     addressController.clear();
//     cityController.clear();
//     stateController.clear();
//     // Get.back();
//     Navigator.pop(context);
//   }
//
//   editProfile({required BuildContext context}) async {
//     // Future<void> createProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String loginId = prefs.getString('loginId') ?? '';
//     String token = prefs.getString('token') ?? '';
//     Map data = {
//       // "loginId": loginId,
//       // "doctorName": nameController.text.trim(),
//       // "mobileNo": mobileController.text.trim(),
//       // "email": emailController.text.trim(),
//       // "doctorSpeciality": doctorSpecialityController.text.trim(),
//       // "dtOfOperation": dateOfOperation.text.trim(),
//       // "degree": degreeController.text.trim(),
//       // "registration": registrationController.text.trim(),
//       // "address": addressController.text.trim(),
//       // "city": cityController.text.trim(),
//       // "state": stateController.text.trim(),
//
//       "loginId": loginId,
//       "name": nameController.text.trim(),
//       "mobile": mobileController.text.trim(),
//       "email": emailController.text.trim(),
//       "speciality": doctorSpecialityController.text.trim(),
//       "degree": degreeController.text.trim(),
//       "regNo": registrationController.text.trim(),
//       "dob": dateOfOperation.text.trim(),
//       "address": addressController.text.trim(),
//       "city": cityController.text.trim(),
//       "state": stateController.text.trim(),
//     };
//     apiCall = true;
//     String apiUrl = saveDrProfile;
//     dio_package.Response finalData =
//         await APIServices.postMethodWithHeaderDioMapData(
//             body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
//     SaveModel patientResponse = SaveModel.fromJson(finalData.data);
//     if (patientResponse.statusCode == 200) {
//       Get.rawSnackbar(message: 'Edit Profile added successfully.');
//     } else if (patientResponse.statusCode == 401) {
//       prefs.clear();
//       Get.offAll(const LoginView());
//
//       Get.rawSnackbar(
//           message: 'Your session has expired. Please log in again to continue');
//     } else if (patientResponse.statusCode == 400) {
//     } else {
//       Get.rawSnackbar(message: "Something went wrong");
//     }
//   }
//
//   getProfileClass() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//     String loginId = prefs.getString('loginId') ?? '';
//     Map<String, dynamic> data = {
//       "loginId": loginId,
//     };
//
//     apiCall = true;
//     String apiUrl = getProfile;
//
//     try {
//       dio.Response response = await APIServices.postMethodWithHeaderDioMapData(
//         body: data,
//         apiUrl: apiUrl,
//         token: token,
//         isShowLoader: false,
//       );
//
//       ProfileModel profileResponse = ProfileModel.fromJson(response.data);
//
//       if (profileResponse.statusCode == 200) {
//         if (profileResponse.data != null && profileResponse.data!.isNotEmpty) {
//           profileClassListData = profileResponse.data!;
//           nameController.text = profileClassListData![0].name ?? '';
//           mobileController.text = profileClassListData![0].mobile ?? '';
//           emailController.text = profileClassListData![0].email ?? '';
//           debugPrint("Email Controller === ${emailController.text}");
//           doctorSpecialityController.text =
//               profileClassListData![0].speciality ?? '';
//           degreeController.text = profileClassListData![0].degree ?? '';
//           registrationController.text = profileClassListData![0].regNo ?? '';
//           dateOfOperation.text = profileClassListData![0].dob ?? '';
//           addressController.text = profileClassListData![0].address ?? '';
//           cityController.text = profileClassListData![0].city ?? '';
//           stateController.text = profileClassListData![0].state ?? '';
//         } else {
//           profileClassListData = [];
//         }
//         update();
//       } else if (profileResponse.statusCode == 401) {
//         prefs.clear();
//         Get.offAll(const LoginView());
//         Get.rawSnackbar(
//             message:
//                 'Your session has expired. Please log in again to continue');
//       } else if (profileResponse.statusCode == 400) {
//         profileClassListData = [];
//       } else {
//         Get.rawSnackbar(message: "Something went wrong");
//       }
//     } catch (e) {
//       Get.rawSnackbar(message: "An error occurred: $e");
//     }
//     update();
//   }
//
//   Future<void> uploadProfilePicture(
//       {required String imagePAth, required String filename}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//     String loginId = prefs.getString('loginId') ?? '';
//     String? mimeType = lookupMimeType(imagePAth);
//
//     mimeType ??= 'application/octet-stream';
//
//     debugPrint("Login Id=== $loginId");
//     apiCall = true;
//     String apiUrl = uploadDrPhoto;
//
//     dio.FormData formData = dio.FormData.fromMap({
//       'file': await dio.MultipartFile.fromFile(imagePAth.trimRight(),
//           filename: filename.trimRight(),
//           contentType: dio.DioMediaType.parse(mimeType)),
//       'loginId': loginId,
//     });
//
//     debugPrint("File Path ==== $imagePAth");
//     debugPrint("File Name ==== $filename");
//
//     try {
//       final dioPackage = Dio();
//       dio.Response response = await dioPackage
//           .request(
//             apiUrl,
//             data: formData,
//             options: dio.Options(
//               method: "POST",
//               validateStatus: (_) => true,
//               headers: {
//                 'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
//                 'Content-Type': 'multipart/form-data',
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 45));
//
//       if (kDebugMode) {
//         print("api response == $response");
//       }
//       if (response.statusCode == 200) {
//         if (response.data != null) {
//           Get.rawSnackbar(
//             snackPosition: SnackPosition.BOTTOM,
//             message: "Photo Uploaded SuccessFully",
//           );
//         }
//       } else if (response.statusCode == 400) {
//         Get.rawSnackbar(
//           snackPosition: SnackPosition.BOTTOM,
//           message: response.statusMessage,
//         );
//       } else if (response.statusCode == 401) {
//         Get.rawSnackbar(
//           snackPosition: SnackPosition.BOTTOM,
//           message: 'unauthorized',
//         );
//       } else if (response.statusCode == 500) {
//         Get.rawSnackbar(
//           snackPosition: SnackPosition.BOTTOM,
//           message: 'Internal server error',
//         );
//       } else {
//         // Handle unsuccessful response
//         debugPrint("Error: ${response.statusCode}, ${response.statusMessage}");
//         Get.rawSnackbar(
//           snackPosition: SnackPosition.BOTTOM,
//           message: response.statusMessage,
//         );
//       }
//     } on DioException catch (e) {
//       // Handle any exceptions that occur during the API call
//       debugPrint("Exception occurred during API call: $e");
//     }
//     update();
//   }
//
//   Future<void> getProfileImage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//     String loginId = prefs.getString('loginId') ?? '';
//     var data = {
//       "loginId": loginId,
//     };
//     apiCall = true;
//     String apiUrl = getDrPhoto;
//     final dioPackage = Dio();
//     dio.Response response = await dioPackage
//         .request(
//           apiUrl,
//           data: data,
//           options: dio.Options(
//             method: "GET",
//             validateStatus: (_) => true,
//             responseType: dio.ResponseType.bytes,
//             headers: {
//               'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
//               'Content-Type': 'application/json',
//             },
//           ),
//         )
//         .timeout(const Duration(seconds: 45));
//
//     // debugPrint("finalData==== $response");
//
//     if (response.statusCode == 200) {
//       imageBytes = response.data;
//       debugPrint("imageBytes === $imageBytes");
//     } else {
//       Get.rawSnackbar(message: "Something Went Wrong");
//     }
//
//     update();
//   }
//
//   getDrSpeciality() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//
//     String loginId = prefs.getString('loginId') ?? '';
//     Map data = {
//       "loginId": loginId,
//     };
//     apiCall = true;
//     String apiUrl = getDrSpecialities;
//     dio_package.Response finalData =
//         await APIServices.postMethodWithHeaderDioMapData(
//             body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
//     DrSpecialitiesModel patientResponse =
//         DrSpecialitiesModel.fromJson(finalData.data);
//     if (patientResponse.statusCode == 200) {
//       if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
//         drSpecialitiesData = patientResponse.data!;
//       } else {
//         drSpecialitiesData = [];
//       }
//       update();
//     } else if (patientResponse.statusCode == 401) {
//       prefs.clear();
//       Get.offAll(const LoginView());
//
//       Get.rawSnackbar(
//           message: 'Your session has expired. Please log in again to continue');
//     } else if (patientResponse.statusCode == 400) {
//       drSpecialitiesData = [];
//     } else {
//       Get.rawSnackbar(message: "Something went wrong");
//     }
//     update();
//   }
//
//   getDrDegree() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//     debugPrint("Token from getDrDegree == $token");
//     String loginId = prefs.getString('loginId') ?? '';
//     Map data = {
//       "loginId": loginId,
//     };
//     apiCall = true;
//     String apiUrl = getDrDegrees;
//     dio_package.Response finalData =
//         await APIServices.postMethodWithHeaderDioMapData(
//             body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
//     DrDegreeModel patientResponse = DrDegreeModel.fromJson(finalData.data);
//     if (patientResponse.statusCode == 200) {
//       if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
//         drDegreeListData = patientResponse.data!;
//       } else {
//         drDegreeListData = [];
//       }
//       update();
//     } else if (patientResponse.statusCode == 401) {
//       prefs.clear();
//       Get.offAll(const LoginView());
//
//       Get.rawSnackbar(
//           message: 'Your session has expired. Please log in again to continue');
//     } else if (patientResponse.statusCode == 400) {
//       drDegreeListData = [];
//     } else {
//       Get.rawSnackbar(message: "Something went wrong");
//     }
//     update();
//   }
//
//   Future<void> selectDateBottomSheet() async {
//     showModalBottomSheet(
//       context: Get.context!,
//       elevation: 0,
//       showDragHandle: true,
//       isScrollControlled: true,
//       backgroundColor: ConstColor.whiteColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(8),
//         ),
//       ),
//       builder: (context) => Container(
//           height: MediaQuery.of(context).size.height * 0.55,
//           width: Get.width,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25.0),
//               topRight: Radius.circular(25.0),
//             ),
//           ),
//           child: const DateofBirth()),
//     );
//   }
// }

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/profile/model/drSpecialities_model.dart';
import 'package:venus/app/modules/profile/views/edit_profile_view.dart';
import '../../../app_common_widgets/common_elevated_button.dart';
import '../../../app_common_widgets/common_text.dart';
import '../../../app_common_widgets/custom_pop_menu.dart';
import '../../../app_common_widgets/sizer_constant.dart';
import '../../../core/constant/const_api_url.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/them/const_color.dart';
import '../../login/views/login_view.dart';
import 'dart:ui' as ui;
import '../model/drDegree.dart';
import '../model/profile_model.dart';
import 'package:dio/dio.dart' as dio_package;
import '../model/save_model.dart';
import '../views/widget/custom_calendar.dart';
import '../views/widget/degree.dart';
import '../views/widget/doctor_specialist.dart';

class ProfileController extends GetxController {
  bool apiCall = false;
  final count = 0.obs;
  DateTime? selectedDate;
  CustomPopupMenuController doctorSpecialistNameController =
      CustomPopupMenuController();
  CustomPopupMenuController degreeNameController = CustomPopupMenuController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final doctorSpecialityController = TextEditingController();
  final degreeController = TextEditingController();
  final registrationController = TextEditingController();
  final dateOfOperation = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final profileForKey = GlobalKey<FormState>();
  List<ProfileListData>? profileClassListData;
  List<DrSpecialitiesListData> drSpecialitiesData = [];
  List<DrDegreeListData> drDegreeListData = [];
  bool _isImagePickerActive = false;
  String? selectedImagePath;
  var isBiometricOn = false.obs;
  Uint8List? imageBytes;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> selectImage(BuildContext context) async {
    if (_isImagePickerActive) {
      debugPrint('Image picker is already active.');
      return;
    }
    _isImagePickerActive = true;
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.crossLength * 0.040,
                    top: Sizes.crossLength * 0.020,
                  ),
                  child: AppText(
                    text: 'Choose Photo',
                    fontSize: Sizes.px20,
                    fontWeight: FontWeight.w600,
                    fontColor: ConstColor.blackColor,
                  ),
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.01,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.crossLength * 0.040,
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.camera,
                              size: Sizes.crossLength * 0.040,
                              color: ConstColor.black6B6B6B,
                            ),
                            onPressed: () => getImageFromGalleryAndCamera(
                                isOpenCamera: true),
                            // Navigator.pop(context, ImageSource.camera),
                          ),
                          SizedBox(height: Sizes.crossLength * 0.001),
                          AppText(
                            text: 'Camera',
                            fontSize: Sizes.px16,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black6B6B6B,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.crossLength * 0.040,
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.photo,
                              size: Sizes.crossLength * 0.040,
                              color: ConstColor.black6B6B6B,
                            ),
                            onPressed: () => getImageFromGalleryAndCamera(
                                isOpenCamera: false),
                            // Navigator.pop(context, ImageSource.gallery),
                          ),
                          AppText(
                            text: 'Gallery',
                            fontSize: Sizes.px16,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black6B6B6B,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
    if (source != null) {
      PermissionStatus status;
      if (source == ImageSource.gallery) {
        status = await Permission.photos.request();
      } else if (source == ImageSource.camera) {
        status = await Permission.camera.request();
      } else {
        status = PermissionStatus.denied;
      }
      if (status == PermissionStatus.granted) {
        final pickedFile = await picker.pickImage(source: source);
        _isImagePickerActive = false;
        if (pickedFile != null) {
          selectedImagePath = pickedFile.path;
          Get.rawSnackbar(message: "Profile picture updated successfully.");
          update();
        } else {
          Get.rawSnackbar(message: "No image was selected, please try again.");
        }
      } else if (status == PermissionStatus.permanentlyDenied) {
        _isImagePickerActive = false;
        Get.dialog(
          AlertDialog(
            title: const Text("Permission Denied"),
            content: const Text(
                "Permission has been permanently denied. Do you want to open settings to enable it?"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  Get.back(); // Close the dialog
                  await openAppSettings(); // Open app settings
                },
                child: const Text("Yes"),
              ),
            ],
          ),
        );
      } else {
        _isImagePickerActive = false;
      }
    }
    _isImagePickerActive = false;
  }

  Future<void> selectDateBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const DateofBirth()),
    );
  }

  final picker = ImagePicker();

  Future<void> getImageFromGalleryAndCamera({
    required bool isOpenCamera,
  }) async {
    if (isOpenCamera) {
      // Request camera permission for both Android and iOS
      // if (await Permission.camera.request().isGranted) {
      if (isOpenCamera == true) {
        await requestPermission(typeCamera: true);
        // return await _pickImage(ImageSource.camera);
      } else {
        Get.rawSnackbar(message: 'Camera permission denied.');
      }
    } else {
      if (Platform.isAndroid) {

        if (isOpenCamera == false) {
          await requestPermission(typeCamera: false);
          // return await _pickImage(ImageSource.gallery);
        } else {
          Get.rawSnackbar(message: 'Photos permission denied.');
        }
      } else if (Platform.isIOS) {
        // For iOS, request editPhotos permission
        if (isOpenCamera == false) {
          //return await _pickImage(ImageSource.gallery);
          return await requestPermission(typeCamera: false);
        } else {
          Get.rawSnackbar(message: 'Photos permission denied.');
        }
      }
    }
  }

  // Future<void> requestPermission({bool typeCamera = true}) async {
  //   Permission permission;
  //   var androidInfo = await DeviceInfoPlugin().androidInfo;
  //
  //   if (typeCamera) {
  //     permission = Permission.camera;
  //   } else {
  //     // Handle permission differences for Android versions
  //     if (Platform.isAndroid && (await androidInfo.version.sdkInt) < 32) {
  //       permission = Permission.storage;  // Use storage permission for Android versions < 12
  //     } else if(Platform.isIOS)
  //       {
  //         permission = Permission.photos;
  //       }
  //     else {
  //       permission = Permission.photos;  // Use photos permission for Android 12 and above
  //     }
  //   }
  //
  //   if (await permission.isDenied) {
  //     final result = await permission.request();
  //
  //     if (result.isGranted) {
  //       if (typeCamera) {
  //         await _openCamera();  // Open camera after permission is granted
  //       } else {
  //         await _openGallery();  // Open gallery after permission is granted
  //       }
  //     } else if (result.isPermanentlyDenied) {
  //       _showPermissionDeniedDialog();  // Open settings if permanently denied
  //     }
  //   } else if (await permission.isGranted) {
  //     if (typeCamera) {
  //       await _openCamera();  // If permission was already granted, open the camera
  //     } else {
  //       await _openGallery();  // If permission was already granted, open the gallery
  //     }
  //   } else if (await permission.isPermanentlyDenied) {
  //     _showPermissionDeniedDialog();  // Open settings if permanently denied
  //   }
  // }

  Future<void> requestPermission({bool typeCamera = true}) async {
    Permission? permission;

    if (typeCamera) {
      permission = Permission.camera;
    } else {
      if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        // Android versions < 12 (API level 31) use storage permission
        if (androidInfo.version.sdkInt < 31) {
          permission = Permission.storage;
        } else {
          permission = Permission
              .photos;
        }
      } else if (Platform.isIOS) {
        permission =
            Permission.photos;
      }
    }

    // Check if the permission is denied
    if (await permission!.isDenied) {
      final result = await permission.request();

      if (result.isGranted) {
        // If permission is granted, open camera or gallery
        if (typeCamera) {
          await openCamera();
        } else {
          await openGallery();
        }
      } else if (result.isPermanentlyDenied) {
        // If permission is permanently denied, show dialog to open settings
        showPermissionDeniedDialog();
      }
    } else if (await permission.isGranted) {
      // If permission is already granted, directly open camera or gallery
      if (typeCamera) {
        await openCamera();
      } else {
        await openGallery();
      }
    } else if (await permission.isPermanentlyDenied) {
      // If permission is permanently denied, show dialog to open settings
      showPermissionDeniedDialog();
    }
  }

  Future<void> openGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        uploadProfilePicture(filename: image.name, imagePAth: image.path).then(
              (value) {
            getProfileImage();
          },
        );
      } else {
        // Get.rawSnackbar(message: 'No image selected.');
      }
    } catch (e) {
      Get.rawSnackbar(message: 'Failed to pick image: $e');
    }
    debugPrint("Opening Gallery");
    update();
  }

  Future<void> openCamera() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        uploadProfilePicture(filename: image.name, imagePAth: image.path).then(
              (value) {
            getProfileImage();
          },
        );
      } else {
        // Get.rawSnackbar(message: 'No image selected.');
      }
    } catch (e) {
      Get.rawSnackbar(message: 'Failed to pick image: $e');
    }
    debugPrint("Opening Camera");
    update();
  }

// Function to show permission dialog and navigate to settings
  void showPermissionDeniedDialog() {
    Get.defaultDialog(
      title: 'Permission Required',
      middleText: 'Please enable the required permission in settings.',
      onConfirm: () {
        openAppSettings();
      },
      textConfirm: 'Open Settings',
      textCancel: 'Cancel',
    );
  }

  void biometricOnChanged(bool v) async {
    await BiometricAuth.checkBiometric();
    if (v) {
      if (BiometricAuth.isBiometricAvailable || BiometricAuth.isFaceAvailable) {
        await BiometricAuth.authenticate(value: v, fromLogin: true);
        isBiometricOn.value = v;
      } else {
        onBiometricSetupDialog();
      }
    } else {
      BiometricAuth.onBiometricSwitch(v);
      isBiometricOn.value = v;
    }
  }

  Future<void> onBiometricSetupDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return SizedBox(
          width: Get.size.width * 0.45,
          child: AlertDialog(
            title: Center(
              child: AppText(
                text: "Alert",
                textAlign: TextAlign.center,
                fontColor: ConstColor.buttonColor,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.px18,
              ),
            ),
            content: AppText(
              text:
              "Biometric is not set up. Would you like to set it up for biometric login?",
              fontSize: Sizes.px14,
              textAlign: TextAlign.center,
              fontColor: ConstColor.blackTextColor,
              fontWeight: FontWeight.w300,
            ),
            actions: [
              SizedBox(
                height: Sizes.crossLength * 0.050,
                child: AppButton(
                  radius: 50,
                  text: "Biometric Setup",
                  onPressed: () {
                    BiometricAuth.goToBiometricSettings().whenComplete(() {
                      Get.back();
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getbackFunction({required BuildContext context}) {
    nameController.clear();
    mobileController.clear();
    emailController.clear();
    doctorSpecialityController.clear();
    degreeController.clear();
    registrationController.clear();
    dateOfOperation.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    Navigator.pop(context);
  }

  Future<void> editProfile({required BuildContext context}) async {
    // Future<void> createProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginId = prefs.getString('loginId') ?? '';
    String token = prefs.getString('token') ?? '';
    Map data = {
      /// Payload is been changed by divyanshi
      // "loginId": loginId,
      // "doctorName": nameController.text.trim(),
      // "mobileNo": mobileController.text.trim(),
      // "email": emailController.text.trim(),
      // "doctorSpeciality": doctorSpecialityController.text.trim(),
      // "dtOfOperation": dateOfOperation.text.trim(),
      // "degree": degreeController.text.trim(),
      // "registration": registrationController.text.trim(),
      // "address": addressController.text.trim(),
      // "city": cityController.text.trim(),
      // "state": stateController.text.trim(),

      "loginId": loginId,
      "name": nameController.text.trim(),
      "mobile": mobileController.text.trim(),
      "email": emailController.text.trim(),
      "speciality": doctorSpecialityController.text.trim(),
      "degree": degreeController.text.trim(),
      "regNo": registrationController.text.trim(),
      "dob": dateOfOperation.text.trim(),
      "address": addressController.text.trim(),
      "city": cityController.text.trim(),
      "state": stateController.text.trim(),
    };
    apiCall = true;
    String apiUrl = saveDrProfile;
    dio_package.Response finalData =
    await APIServices.postMethodWithHeaderDioMapData(
        body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
    SaveModel patientResponse = SaveModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      Get.rawSnackbar(message: 'Profile Update Successfully ');
      //getbackFunction(context: context);
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  Future<void> selectDoctorSpeciality() async {
    showModalBottomSheet(
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: Get.context!,
      useRootNavigator: true,
      builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const EditProfileView()),
      ),
    );
  }

  getProfileClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map<String, dynamic> data = {
      "loginId": loginId,
    };

    apiCall = true;
    String apiUrl = getProfile;

    try {
      dio.Response response = await APIServices.postMethodWithHeaderDioMapData(
        body: data,
        apiUrl: apiUrl,
        token: token,
        isShowLoader: false,
      );

      ProfileModel profileResponse = ProfileModel.fromJson(response.data);

      if (profileResponse.statusCode == 200) {
        if (profileResponse.data != null && profileResponse.data!.isNotEmpty) {
          profileClassListData = profileResponse.data!;
          nameController.text = profileClassListData![0].name ?? '';
          mobileController.text = profileClassListData![0].mobile ?? '';
          emailController.text = profileClassListData![0].email ?? '';
          debugPrint("Email Controller === ${emailController.text}");
          doctorSpecialityController.text =
              profileClassListData![0].speciality ?? '';
          degreeController.text = profileClassListData![0].degree ?? '';
          registrationController.text = profileClassListData![0].regNo ?? '';
          dateOfOperation.text = profileClassListData![0].dob ?? '';
          addressController.text = profileClassListData![0].address ?? '';
          cityController.text = profileClassListData![0].city ?? '';
          stateController.text = profileClassListData![0].state ?? '';
        } else {
          profileClassListData = [];
        }
        update();
      } else if (profileResponse.statusCode == 401) {
        prefs.clear();
        Get.offAll(const LoginView());
        Get.rawSnackbar(
            message:
            'Your session has expired. Please log in again to continue');
      } else if (profileResponse.statusCode == 400) {
        profileClassListData = [];
      } else {
        Get.rawSnackbar(message: "Something went wrong");
      }
    } catch (e) {
      Get.rawSnackbar(message: "An error occurred: $e");
    }
    update();
  }

  /// Method By Divyanshi
  Future<void> uploadProfilePicture(
      {required String imagePAth, required String filename}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    String? mimeType = lookupMimeType(imagePAth);

    mimeType ??= 'application/octet-stream';

    debugPrint("Login Id=== $loginId");
    apiCall = true;
    String apiUrl = uploadDrPhoto;

    dio.FormData formData = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(imagePAth.trimRight(),
          filename: filename.trimRight(),
          contentType: dio.DioMediaType.parse(mimeType)),
      'loginId': loginId,
    });

    debugPrint("File Path ==== $imagePAth");
    debugPrint("File Name ==== $filename");

    try {
      final dioPackage = Dio();
      dio.Response response = await dioPackage
          .request(
        apiUrl,
        data: formData,
        options: dio.Options(
          method: "POST",
          validateStatus: (_) => true,
          headers: {
            'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
            'Content-Type': 'multipart/form-data',
          },
        ),
      )
          .timeout(const Duration(seconds: 45));

      if (kDebugMode) {
        print("api response == $response");
      }
      if (response.statusCode == 200) {
        if (response.data != null) {
          Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            message: "Photo Uploaded SuccessFully",
          );
        }
      } else if (response.statusCode == 400) {
        Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          message: response.statusMessage,
        );
      } else if (response.statusCode == 401) {
        Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          message: 'unauthorized',
        );
      } else if (response.statusCode == 500) {
        Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          message: 'Internal server error',
        );
      } else {
        // Handle unsuccessful response
        debugPrint("Error: ${response.statusCode}, ${response.statusMessage}");
        Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          message: response.statusMessage,
        );
      }
    } on DioException catch (e) {
      // Handle any exceptions that occur during the API call
      debugPrint("Exception occurred during API call: $e");
    }
    update();
  }

  Future<void> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    var data = {
      "loginId": loginId,
    };

    try 
    {
   apiCall = true;
    String apiUrl = getDrPhoto;
    final dioPackage = Dio();
    dio.Response response = await dioPackage
        .request(
      apiUrl,
      data: data,
      options: dio.Options(
        method: "GET",
        validateStatus: (_) => true,
        responseType: dio.ResponseType.bytes,
        headers: {
          'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
          'Content-Type': 'application/json',
        },
      ),
    )
        .timeout(const Duration(seconds: 45));

    // debugPrint("finalData==== $response");

    if (response.statusCode == 200) {
      imageBytes = response.data;
      debugPrint("imageBytes === $imageBytes");
    }
    else if (response.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (response.statusCode == 400) {
      Get.rawSnackbar(message: "Something Went Wrong");
    }
    else if (response.statusCode == 500) {
      Get.rawSnackbar(message: "Internal Server Error");
    }
    else {
      Get.rawSnackbar(message: response.statusMessage);
    }
     }
     on DioException catch (e) {
      // Handle any exceptions that occur during the API call
      debugPrint("Exception occurred during API call: $e");
    }
    update();
  }

  getDrSpeciality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    apiCall = true;
    String apiUrl = getDrSpecialities;
    dio_package.Response finalData =
    await APIServices.postMethodWithHeaderDioMapData(
        body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
    DrSpecialitiesModel patientResponse =
    DrSpecialitiesModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        drSpecialitiesData = patientResponse.data!;
      } else {
        drSpecialitiesData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      drSpecialitiesData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getDrDegree() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    apiCall = true;
    String apiUrl = getDrDegrees;
    dio_package.Response finalData =
    await APIServices.postMethodWithHeaderDioMapData(
        body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
    DrDegreeModel patientResponse = DrDegreeModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        drDegreeListData = patientResponse.data!;
      } else {
        drDegreeListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      drDegreeListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  get({bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId};
    apiCall = true;
    String apiUrl = getHospitalDoctorsApi;
    dio_package.Response finalData =
    await APIServices.postMethodWithHeaderDioMapData(
        body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    DrDegreeModel filterResponse = DrDegreeModel.fromJson(finalData.data);
    if (filterResponse.statusCode == 200) {
      if (filterResponse.data != null) {
        drDegreeListData = filterResponse.data!;
      } else {
        drDegreeListData = [];
      }
    } else if (filterResponse.statusCode == 400) {
      drDegreeListData = [];
    } else if (filterResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  Future<void> selectDateBirthBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const DateofBirth()),
    );
  }

  Future<void> selectDoctorSpecialistBottom() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          // top: Radius.circular(8),
        ),
      ),
      builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const DoctorSpecialist()),
      ),
    );
  }

  Future<void> selectDegreeBottom() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const DegreeList()),
      ),
    );
  }
}