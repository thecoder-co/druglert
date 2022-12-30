import 'package:drug_alert_frontend/core/constants/app_colors.dart';
import 'package:drug_alert_frontend/core/route/app_routes.dart';
import 'package:drug_alert_frontend/core/shared_widgets/gradient_button.dart';
import 'package:drug_alert_frontend/core/shared_widgets/gradient_text.dart';
import 'package:drug_alert_frontend/core/utils/extensions/widget_extensions.dart';
import 'package:drug_alert_frontend/features/auth/presentation/pages/login_screen.dart';
import 'package:drug_alert_frontend/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameText = TextEditingController();
  final passwordText = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/joshua-coleman-AVqs0ItdMQM-unsplash.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    GradientText(
                      'DrugLert',
                      gradient: AppColors.gradient,
                      style: const TextStyle(
                        fontFamily: 'RubikVinyl',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    8.spacingH,
                    Text(
                      'Let\'s get started',
                      style: GoogleFonts.kanit(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 50,
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 12, 12, 12),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Sign up',
                          style: GoogleFonts.kanit(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        20.spacingH,
                        TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[800]!,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[800]!,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[800]!,
                                width: 2,
                              ),
                            ),
                            hintStyle: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            label: const Text('Email'),
                            labelStyle: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: GoogleFonts.kanit(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: usernameText,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please enter an email';
                            }

                            if (!RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(v)) {
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordText,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[800]!,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[800]!,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[800]!,
                                width: 2,
                              ),
                            ),
                            hintStyle: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            label: const Text('Password'),
                            labelStyle: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                          ),
                          style: GoogleFonts.kanit(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          obscureText: isVisible,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const Spacer(),
                        AppButton.gradient(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              auth.email = usernameText.text;
                              auth.password = passwordText.text;
                              await authNotifier.registerUser(context);
                            }
                          },
                          text: 'Create an account',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: GoogleFonts.kanit(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                pushTo(context, const LoginScreen());
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              child: GradientText(
                                'Login',
                                gradient: AppColors.gradient,
                                style: GoogleFonts.kanit(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        20.spacingH,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
