import 'package:app_ecommerc/pages/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_ecommerc/providers/auth_provider.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), actions: const []),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.status == AuthStatus.otpRequested) {
            // navigasi otomati ke halmaan OTP setelah permintaan berhasil
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => OtpPage()),
              );
            });
          }
          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'masukna nomor telpon anda',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Nomor Telpon',
                      border: OutlineInputBorder(),

                      prefixText: '+62',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor telpon tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  if (authProvider.status == AuthStatus.loading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          authProvider.requestOtp(_phoneController.text);
                        }
                      },
                      child: Text('Login & Minta OTP'),
                    ),
                  if (authProvider.status == AuthStatus.error)
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        authProvider.errorMessage ?? 'Terjadi kesalahan',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
