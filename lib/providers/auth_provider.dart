import 'package:flutter/material.dart';
import 'package:app_ecommerc/models/auth_model.dart';
import 'package:app_ecommerc/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, otpRequested, authenticated, error }

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  AuthStatus _status = AuthStatus.initial;
  String? _token;
  User? _user;
  String? _tempPhone;
  String? _errorMessage;

  AuthStatus get status => _status;
  String? get token => _token;
  User? get user => _user;
  String? get tempPhone => _tempPhone;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<void> requestOtp(String phone) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authRepository.requestOtp(phone);
      _status = AuthStatus.otpRequested;
      _tempPhone = phone;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> verifyOtp(String otp) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_tempPhone == null) {
        throw Exception('Nomor telpon tidak ditemukan.');
      }

      final response = await _authRepository.verifyOtp(_tempPhone!, otp);
      _status = AuthStatus.authenticated;
      _token = response.token;
      _user = response.user;
      _tempPhone = null; // bersihkan nomor sementara
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void logout() {
    _status = AuthStatus.initial;
    _token = null;
    _user = null;
    notifyListeners();
  }
}
