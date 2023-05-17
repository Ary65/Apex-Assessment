import 'package:apex_assessment/common/widgets/custom_button.dart';
import 'package:apex_assessment/common/widgets/custom_textfield.dart';
import 'package:apex_assessment/providers/data_providers.dart';
import 'package:apex_assessment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDialog extends ConsumerStatefulWidget {
  const MyDialog({super.key});

  @override
  ConsumerState<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends ConsumerState<MyDialog> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  void submitRequest() {
    if (_formKey.currentState!.validate()) {
      final apiService = ref.read(apiServiceProvider);
      apiService.createNewCompany(
        nameController.text,
        emailController.text,
        passwordController.text,
        phoneController.text,
      );
      ref.invalidate(companiesProvider);
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'New Company has created successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: AppColors.primaryColor,
      );
    }
  }

  // Never forget to dispose the controller otherwise it will cause memory leak
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: SizedBox(
        height: 466,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            const Text(
              'Create a New Company',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Company Name',
                      obSecure: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Company name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Work Email',
                      obSecure: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obSecure: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 7) {
                          return 'Password must be at least 7 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: phoneController,
                      hintText: 'Phone',
                      obSecure: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number is required';
                        }
                        // Phone number validation regular expression
                        const phoneRegex = r'^[0-9]{10}$';
                        if (!RegExp(phoneRegex).hasMatch(value)) {
                          return 'Enter a 10 digit phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                onTap: () => submitRequest(),
                text: 'Create a New Company',
              ),
            )
          ],
        ),
      ),
    );
  }
}
