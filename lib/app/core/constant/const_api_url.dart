class ConstApiUrl {
  static const drUrl = "http://117.217.126.127/api/Doctor";
  static const drLoginUrl = 'http://117.217.126.127/api/DrLogin';

  //  ----------------    Prod  urls ---------------
  static const baseApiUrl = drLoginUrl;
  static const validateMobile = "$baseApiUrl/ValidateMobileNo";
  static const loginWithPassword = "$drUrl/authentication";
  static const newPassword = "$baseApiUrl/GenerateNewPassword";
  static const sendOtp = "$baseApiUrl/SendMobileOTP";
  static const getSaveToken = "$baseApiUrl/Save_Get_Token";
  static const diplayDashBoard = "$drUrl/GetDashboardList";
  static const patientList = "$drUrl/GetDrPatientList";
  static const searchPatientList = "$drUrl/SearchPatientList";
  static const filterPatientData = "$drUrl/GetFilteredPatientData";
  static const sortPatientData = "$drUrl/SortDrPatientList";
  static const dashboardFilters = "$drUrl/GetDashboardFilters";
}
