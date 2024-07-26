import 'package:get/get.dart';

import '../modules/NoInternet/bindings/no_internet_binding.dart';
import '../modules/NoInternet/views/no_internet_view.dart';
import '../modules/bottomBar/bindings/bottom_bar_binding.dart';
import '../modules/bottomBar/views/bottom_bar_view.dart';
import '../modules/clinicalSummary/bindings/clinical_summary_binding.dart';
import '../modules/clinicalSummary/views/clinical_summary_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/costestimate/bindings/costestimate_binding.dart';
import '../modules/costestimate/views/costestimate_view.dart';
import '../modules/forgotpassword/bindings/forgotpassword_binding.dart';
import '../modules/forgotpassword/views/forgotpassword_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/opdAppointments/bindings/opd_appointments_binding.dart';
import '../modules/opdAppointments/views/opd_appointments_view.dart';
import '../modules/otscheduler/bindings/otscheduler_binding.dart';
import '../modules/otscheduler/views/otscheduler_view.dart';
import '../modules/patientlist/bindings/patientlist_binding.dart';
import '../modules/patientlist/views/patientlist_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/schduleSurgeries/bindings/schdule_surgeries_binding.dart';
import '../modules/schduleSurgeries/views/schdule_surgeries_view.dart';
import '../modules/schedulechargelist/bindings/schedulechargelist_binding.dart';
import '../modules/schedulechargelist/views/schedulechargelist_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/verifyotp/bindings/verifyotp_binding.dart';
import '../modules/verifyotp/views/verifyotp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORD,
      page: () => const ForgotpasswordView(),
      binding: ForgotpasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFYOTP,
      page: () => const VerifyotpView(),
      binding: VerifyotpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PATIENTLIST,
      page: () => const PatientlistView(),
      binding: PatientlistBinding(),
    ),
    GetPage(
      name: _Paths.OTSCHEDULER,
      page: () => const OtschedulerView(),
      binding: OtschedulerBinding(),
    ),
    GetPage(
      name: _Paths.OPD_APPOINTMENTS,
      page: () => const OpdAppointmentsView(),
      binding: OpdAppointmentsBinding(),
    ),
    GetPage(
      name: _Paths.CLINICAL_SUMMARY,
      page: () => const ClinicalSummaryView(),
      binding: ClinicalSummaryBinding(),
    ),
    GetPage(
      name: _Paths.SCHDULE_SURGERIES,
      page: () => const SchduleSurgeriesView(),
      binding: SchduleSurgeriesBinding(),
    ),
    GetPage(
      name: _Paths.COSTESTIMATE,
      page: () => const CostestimateView(),
      binding: CostestimateBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULECHARGELIST,
      page: () => const SchedulechargelistView(),
      binding: SchedulechargelistBinding(),
    ),
    GetPage(
      name: _Paths.CHARGELIST,
      page: () => const NoInternetView(),
      binding: NoInternetBinding(),
    ),
  ];
}
