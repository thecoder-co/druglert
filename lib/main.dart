import 'package:drug_alert_frontend/core/services/local_data.dart';
import 'package:drug_alert_frontend/features/auth/presentation/pages/auth_start.dart';
import 'package:drug_alert_frontend/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

// import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  await LocalData.getInstance.init();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //close the keypad whenever the user taps on an inactive widget
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        supportedLocales: const [
          Locale('en', ''),
          Locale('tr', ''),
        ],
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: const Color(0xffBF28CE),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
          primarySwatch: const MaterialColor(
            800,
            {
              900: Color(0xffA523B2),
              800: Color(0xffBF28CE),
              700: Color(0xffCB3ED9),
              600: Color(0xffD25ADE),
              500: Color(0xffDA75E4),
              400: Color(0xffE191E9),
              300: Color(0xffE9ACEF),
              200: Color(0xffF0C8F4),
              100: Color(0xffF8E3FA),
              50: Color(0xffFDF0FF),
            },
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const Router(),
        // home: const PhoneNumberTextField(),

        // home: const LoginScreen()
      ),
    );
  }
}

class Router extends StatefulWidget {
  const Router({super.key});

  @override
  State<Router> createState() => _RouterState();
}

class _RouterState extends State<Router> {
  @override
  Widget build(BuildContext context) {
    if (LocalData.getInstance.token != null) {
      return const HomeScreen();
    } else {
      return const AuthStart();
    }
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   String? validator(String? text) {
//     if (!text!.isValidEmail) {
//       return 'Please write a valid email text';
//     }

//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           SizedBox(
//             height: 40,
//             // How to use localization extension
//             child: Text(AppText.findYourMatch.localized),
//           ),
//           const AppButton.secondary(
//             isDisabled: true,
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           // AppInput(),
//           const SizedBox(
//             height: 40,
//           ),
//           AppTextfield(
//             errorCondition: validator,

//             // isDisabled: isDisabled,
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           AppTextfield.password(),
//           AppTextfield(
//             // isDisabled: isDisabled,
//             errorCondition: validator,
//           ),
//         ],
//       ),
//     );
//   }
// }
