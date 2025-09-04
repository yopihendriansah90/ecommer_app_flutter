import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_ecommerc/models/auth_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AuthRepository {
  // --- REKOMENDASI 1: Gunakan base URL yang lebih fleksibel ---
  // Menggunakan getter untuk menentukan URL berdasarkan platform
  String get _baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000/api'; // Untuk Web
    }
    if (Platform.isAndroid) {
      return 'http://0.0.0.0:8000/api'; // Untuk Emulator Android
    }
    // Untuk iOS atau platform lain, mungkin perlu disesuaikan
    return 'http://127.0.0.1:8000/api';
  }

  Future<AuthResponse> requestOtp(String phone) async {
    final url = Uri.parse('$_baseUrl/auth/request-otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );
      if (response.statusCode == 200) {
        // 2. Tipe return sekarang sesuai dengan deklarasi fungsi
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        // 3. Kesalahan sintaks dan salah ketik diperbaiki
        final errorResponse = jsonDecode(response.body);
        // 4. Menggunakan pesan error yang konsisten
        throw Exception(errorResponse['message'] ?? 'Gagal meminta OTP');
      }
    } catch (e) {
      // --- REKOMENDASI 2: Penanganan error jaringan ---
      // Menangkap error jika tidak bisa terhubung ke server
      throw Exception('Tidak dapat terhubung ke server. Periksa koneksi Anda.');
    }
  }

  Future<AuthResponse> verifyOtp(String phone, String otp) async {
    final url = Uri.parse('$_baseUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      final errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message'] ?? 'Gagal verifikasi OTP');
    }
  }
}
