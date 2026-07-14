import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Marketing lead capture — writes ONLY to `contacts` and `demo_requests`.
/// Never touches ERP collections (schools, users, students, etc.).
class LeadService {
  LeadService({FirebaseFirestore? firestore}) : _db = firestore;

  FirebaseFirestore? _db;

  bool get _ready => Firebase.apps.isNotEmpty;

  FirebaseFirestore get db => _db ??= FirebaseFirestore.instance;

  Future<void> submitContact({
    required String fullName,
    required String schoolName,
    required String mobile,
    required String email,
    required String city,
    required String state,
    required String schoolType,
    required String numberOfStudents,
    required String message,
  }) async {
    final payload = <String, dynamic>{
      'fullName': fullName.trim(),
      'schoolName': schoolName.trim(),
      'mobile': mobile.trim(),
      'email': email.trim().toLowerCase(),
      'city': city.trim(),
      'state': state.trim(),
      'schoolType': schoolType.trim(),
      'numberOfStudents': numberOfStudents.trim(),
      'message': message.trim(),
      'source': 'asoltu.com/contact',
      'createdAt': FieldValue.serverTimestamp(),
      'clientTimestamp': DateTime.now().toUtc().toIso8601String(),
    };

    if (!_ready) {
      debugPrint('LeadService: Firebase not ready — contact payload logged');
      debugPrint(payload.toString());
      return;
    }

    await db.collection('contacts').add(payload);
  }

  Future<void> submitDemoRequest({
    required String name,
    required String mobile,
    required String email,
    required String preferredDate,
    required String preferredTime,
    required String schoolName,
  }) async {
    final payload = <String, dynamic>{
      'name': name.trim(),
      'mobile': mobile.trim(),
      'email': email.trim().toLowerCase(),
      'preferredDate': preferredDate.trim(),
      'preferredTime': preferredTime.trim(),
      'schoolName': schoolName.trim(),
      'source': 'asoltu.com/book-demo',
      'createdAt': FieldValue.serverTimestamp(),
      'clientTimestamp': DateTime.now().toUtc().toIso8601String(),
    };

    if (!_ready) {
      debugPrint('LeadService: Firebase not ready — demo payload logged');
      debugPrint(payload.toString());
      return;
    }

    await db.collection('demo_requests').add(payload);
  }
}

final leadService = LeadService();
