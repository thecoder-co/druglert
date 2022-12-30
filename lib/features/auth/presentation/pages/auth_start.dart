import 'package:drug_alert_frontend/core/constants/app_colors.dart';
import 'package:drug_alert_frontend/core/route/app_routes.dart';
import 'package:drug_alert_frontend/core/shared_widgets/gradient_button.dart';
import 'package:drug_alert_frontend/core/shared_widgets/gradient_text.dart';
import 'package:drug_alert_frontend/core/utils/extensions/widget_extensions.dart';
import 'package:drug_alert_frontend/features/auth/presentation/pages/login_screen.dart';
import 'package:drug_alert_frontend/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthStart extends StatelessWidget {
  const AuthStart({super.key});

  @override
  Widget build(BuildContext context) {
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
              Row(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientText(
                      'DrugLert',
                      gradient: AppColors.gradient,
                      style: const TextStyle(
                        fontFamily: 'RubikVinyl',
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    8.spacingH,
                    Text(
                      'Keep track of your medication',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                child: Column(
                  children: [
                    AppButton.gradient(
                      onTap: () {
                        pushTo(context, const RegisterScreen());
                      },
                      text: 'Create an account',
                    ),
                    20.spacingH,
                    AppButton(
                      onTap: () {
                        pushTo(context, const LoginScreen());
                      },
                      text: 'Login',
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
