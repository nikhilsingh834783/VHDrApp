// class ConstApiUrl {
String initailUrl = 'http://117.217.126.127/api';

String drUrl = "$initailUrl/Doctor";
String drLoginUrl = '$initailUrl/DrLogin';

//  ----------------    Prod  urls ---------------
String baseApiUrl = drLoginUrl;
String validateMobile = "$baseApiUrl/ValidateMobileNo";
String loginWithPassword = "$drUrl/authentication";
String newPassword = "$baseApiUrl/GenerateNewPassword";
String sendOtpUrl = "$baseApiUrl/SendMobileOTP";
String getSaveToken = "$baseApiUrl/Save_Get_Token";
String diplayDashBoard = "$drUrl/GetDashboardList";
String patientListUrl = "$drUrl/GetDrPatientList";
String searchPatientList = "$drUrl/SearchPatientList";
String filterPatientData = "$drUrl/GetFilteredPatientData";
String sortPatientData = "$drUrl/SortDrPatientList";
String dashboardFilters = "$drUrl/GetDashboardFilters";
String getProgressSummaryUrl = "$drUrl/GetProgressSummary";
String getLabReports = "$drUrl/GetPatientLabReports";
String getRadioLogyReports = "$drUrl/GetDrRadiologyReports";
String getApdAppointmentsUrl = "$drUrl/GetAppointments";
String getApdAppointmentsDatesUrl = "$drUrl/GetApptDateCount";
String getProcedureDates = "$drUrl/GetOTScheduleDateCount";

String schduleSurgeryListApi = "$drUrl/GetOTScheduleList";
String roomsApi = "$drUrl/Rooms";
String doctorVisitApi = "$drUrl/DrVisit";
String surgeryApi = "$drUrl/GetSurgeryRate";
String getOperationClassApi = "$drUrl/GetDrOperationClass";
String getOperationNameApi = "$drUrl/GetDrOperationNames";

String getOrganizationListUrl = "$drUrl/GetOrgData";
String getDoctorPaymentListApi = "$drUrl/GetDrPaymentList";
String saveOtSchdule = "$drUrl/SaveOTSchedule";
String additionalSurgeonApi = "$drUrl/GetAdnlSurgDrData";
String getSurgicalEstimateapi = "$drUrl/GetSurgicalEstimate";
String getSurgicalEstimateapiProcedure = "$drUrl/GetSurgicalEstimate_Indoor";
String getContactsApi = "$drUrl/GetEmergencyContacts";
String getInsuranceCompanies = "$drUrl/GetInsuranceCompanies";
String getHospitalDoctorsApi = "$drUrl/GetHospitalDrs";
String getProfile = "$drUrl/GetDrProfile";
String saveDrProfile = "$drUrl/SaveDrProfile";
String getDrSpecialities = "$drUrl/GetDrSpecialities";
String getDrDegrees = "$drUrl/GetDrDegree";

/// Added divyanshi
String uploadDrPhoto = "$drUrl/UploadDrPhoto";
String getDrPhoto = "$drUrl/GetDrPhoto";
// }
