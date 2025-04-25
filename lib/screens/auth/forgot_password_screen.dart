import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:college_app/providers/auth_provider.dart';
import 'package:college_app/constants/app_colors.dart';
import 'package:college_app/constants/app_styles.dart';
import 'package:college_app/utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _resetSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(_emailController.text.trim());

      setState(() {
        _isLoading = false;
        _resetSent = true;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _resetSent ? _buildSuccessContent() : _buildFormContent(),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),

          // Reset Password Icon
          const Icon(
            Icons.lock_reset,
            size: 80,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 24),

          // Reset Password Text
          const Text(
            'Reset Password',
            style: AppStyles.heading1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Reset Password Instructions
          const Text(
            'Enter your email address below and we will send you instructions to reset your password.',
            style: AppStyles.bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: AppStyles.textFieldDecoration.copyWith(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!Validators.isValidEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Reset Button
          ElevatedButton(
            onPressed: _isLoading ? null : _resetPassword,
            style: AppStyles.primaryButtonStyle,
            child: _isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : const Text(
              'Reset Password',
              style: AppStyles.buttonText,
            ),
          ),
          const SizedBox(height: 16),

          // Back to Login
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Back to Login',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 32),

        // Success Icon
        const Icon(
          Icons.check_circle,
          size: 80,
          color: AppColors.successColor,
        ),
        const SizedBox(height: 24),

        // Success Title
        const Text(
          'Email Sent',
          style: AppStyles.heading1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Success Message
        Text(
          'We have sent password reset instructions to ${_emailController.text}. Please check your email.',
          style: AppStyles.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Back to Login Button
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: AppStyles.primaryButtonStyle,
          child: const Text(
            'Back to Login',
            style: AppStyles.buttonText,
          ),
        ),
        const SizedBox(height: 16),

        // Check Email Button
        TextButton(
          onPressed: () {
            // Placeholder for email checking functionality
            // This could open the device's email app
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening email app...'),
                backgroundColor: AppColors.infoColor,
              ),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, color: AppColors.primaryColor),
              SizedBox(width: 8),
              Text(
                'Check Email',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}