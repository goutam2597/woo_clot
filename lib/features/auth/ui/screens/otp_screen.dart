import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/app/routes.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String contact;
  const OtpVerifyScreen({super.key, required this.contact});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _code = TextEditingController();
  bool _sending = false;
  int _seconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds <= 1) {
        t.cancel();
        setState(() {});
        return;
      }
      setState(() => _seconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _code.dispose();
    super.dispose();
  }

  void _verify() async {
    final v = _code.text.trim();
    if (v.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter the 6‑digit code')));
      return;
    }
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _sending = false);
    Navigator.pushNamed(
      context,
      AppRoutes.resetPassword,
      arguments: {'contact': widget.contact},
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = 'We\'ve sent a 6‑digit code to ${widget.contact}. ';
    return Scaffold(
      appBar: const CustomAppBar(title: 'Verify OTP', centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(subtitle, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  final defaultPinTheme = PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEAEAEA)),
                    ),
                  );
                  final focusedPinTheme = defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration?.copyWith(
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                  );
                  final submittedPinTheme = defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration?.copyWith(
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                  );
                  return Pinput(
                    controller: _code,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    keyboardType: TextInputType.number,
                    onCompleted: (_) => _verify(),
                  );
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_seconds > 0)
                    Text('Resend in 0:${_seconds.toString().padLeft(2, '0')}')
                  else
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OTP resent')),
                        );
                        _startTimer();
                      },
                      child: const Text('Resend code'),
                    ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  onPressed: _sending ? null : _verify,
                  child: Text(_sending ? 'Verifying...' : 'Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
