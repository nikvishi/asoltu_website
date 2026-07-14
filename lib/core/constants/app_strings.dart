/// Marketing copy constants.
abstract final class AppStrings {
  AppStrings._();

  static const brandName = 'ASOLTU';
  static const productName = 'ASOLTU School ERP';
  static const tagline = 'Manage • Educate • Elevate';
  static const companyLegal = 'ASOLTU Tech Solutions';

  static String get copyright =>
      '© ${DateTime.now().year} $companyLegal. All rights reserved.';

  static const metaDefaultTitle =
      'ASOLTU — AI-Powered School ERP | Admissions, Fees, Attendance & More';
  static const metaDefaultDescription =
      'ASOLTU is the AI-powered school ERP for modern institutions. Manage admissions, '
      'attendance, fees, exams, HR, payroll, parent apps and analytics in one secure cloud platform.';
}
