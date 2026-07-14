/// Shared form validation for marketing lead forms.
abstract final class FormValidators {
  FormValidators._();

  static String? required(String? v, [String label = 'This field']) {
    if (v == null || v.trim().isEmpty) return '$label is required';
    return null;
  }

  static String? email(String? v) {
    final base = required(v, 'Email');
    if (base != null) return base;
    final email = v!.trim();
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    if (!ok) return 'Enter a valid email address';
    return null;
  }

  static String? mobile(String? v) {
    final base = required(v, 'Mobile number');
    if (base != null) return base;
    final digits = v!.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 15) {
      return 'Enter a valid mobile number (10–15 digits)';
    }
    return null;
  }
}
