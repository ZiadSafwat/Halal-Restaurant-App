///////////////////////////////////////////////////
// class LoginScreen extends StatefulWidget {
//   /// Simulates the multilanguage, you will implement your own logic.
//   /// According to the current language, you can display a text message
//   /// with the help of [LoginTexts] class.
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   LanguageOption language = _languageOptions[1];
//   AuthMode currentMode = AuthMode.login;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedLogin(
//       onLogin: LoginFunctions(context).onLogin,
//       onSignup: LoginFunctions(context).onSignup,
//       onForgotPassword: LoginFunctions(context).onForgotPassword,
//       logo: Image.asset('assets/imgs/logo2.png'),
//       // backgroundImage: 'images/background_image.jpg',
//       signUpMode: SignUpModes.both,
//       socialLogins: const [],
//       loginDesktopTheme: _desktopTheme,
//       loginMobileTheme: _mobileTheme,
//       loginTexts: _loginTexts,
//       changeLanguageCallback: (LanguageOption? _language) {
//         if (_language != null) {
//           DialogBuilder(context).showResultDialog(
//               'Successfully changed the language to: ${_language.value}.');
//           if (mounted) setState(() => language = _language);
//         }
//       },
//       languageOptions: _languageOptions,
//       selectedLanguage: language,
//       initialMode: currentMode,
//       onAuthModeChange: (AuthMode newMode) => currentMode = newMode,
//     );
//   }
//
//   static List<LanguageOption> get _languageOptions => const <LanguageOption>[
//         LanguageOption(
//           value: 'Arabic',
//           code: 'AR',
//           //  iconPath: 'assets/images/tr.png',
//         ),
//         LanguageOption(
//           value: 'English',
//           code: 'EN',
//           // iconPath: 'assets/images/en.png',
//         ),
//       ];
//
//   /// You can adjust the colors, text styles, button styles, borders
//   /// according to your design preferences for *DESKTOP* view.
//   /// You can also set some additional display options such as [showLabelTexts].
//   LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
//         // To set the color of button text, use foreground color.
//         actionButtonStyle: ButtonStyle(
//           foregroundColor: WidgetStateProperty.all(Colors.white),
//         ),
//         dialogTheme: const AnimatedDialogTheme(
//           languageDialogTheme: LanguageDialogTheme(
//               optionMargin: EdgeInsets.symmetric(horizontal: 80)),
//         ),
//       );
//
//   /// You can adjust the colors, text styles, button styles, borders
//   /// according to your design preferences for *MOBILE* view.
//   /// You can also set some additional display options such as [showLabelTexts].
//   LoginViewTheme get _mobileTheme => LoginViewTheme(
//         // showLabelTexts: false,
//         backgroundColor: const Color(0xffee8767), // const Color(0xFF6666FF),
//         formFieldBackgroundColor: Colors.white,
//         formWidthRatio: 60,
//
//         // actionButtonStyle: ButtonStyle(
//         //   foregroundColor: MaterialStateProperty.all(Colors.blue),
//         // ),
//       );
//
//   LoginTexts get _loginTexts => LoginTexts(
//       signupPasswordHint: _loginPasswordHint,
//       signupEmailHint: _loginEmailHint,
//       confirmPasswordHint: _confirmPasswordHint,
//       loginEmailHint: _loginEmailHint,
//       loginPasswordHint: _loginPasswordHint,
//       termsConditionsLink: 'https://www.facebook.com/ziadsafowat',
//       privacyPolicyLink: 'https://www.facebook.com/ziadsafowat',
//       forgotPassword: _forgotPassword,
//       nameHint: _username,
//       login: _login,
//       signUp: _signup,
//       agreementText: _agreementText,
//       alreadyHaveAnAccount: _alreadyHaveAnAccount,
//       notHaveAnAccount: _notHaveAnAccount,
//       welcome: _welcome,
//       welcomeBack: _welcomeBack,
//       welcomeBackDescription: _welcomeBackDescription,
//       welcomeDescription: _welcomeDescription,
//       termsConditionsText: _termsConditionsText,
//       privacyPolicyText: _privacyPolicyText);
//
//   /// You can adjust the texts in the screen according to the current language
//   /// With the help of [LoginTexts], you can create a multilanguage scren.
//   String get _loginEmailHint => language.code == 'AR' ? 'الحساب' : 'Email';
//   String get _loginPasswordHint =>
//       language.code == 'AR' ? 'كلمة السر' : 'Password';
//   String get _confirmPasswordHint =>
//       language.code == 'AR' ? 'تأكيد كلمة السر' : 'confirm password';
//   String get _welcomeBack =>
//       language.code == 'AR' ? 'مرحبا بعودتك' : 'welcome Back';
//   String get _welcomeBackDescription =>
//       language.code == 'AR' ? 'يسرنا أن نراك مجددا' : 'happy to see you again';
//   String get _welcomeDescription => language.code == 'AR'
//       ? 'نتمنى لك تجربة سلسة وممتعة'
//       : 'hope you enjoy your time';
//   String get _termsConditionsText =>
//       language.code == 'AR' ? 'الشروط والأحكام' : 'Terms and Conditions';
//   String get _privacyPolicyText =>
//       language.code == 'AR' ? 'سياسة الخصوصية' : 'Privacy policy';
//
//   String get _welcome => language.code == 'AR' ? 'أهلا' : 'welcome';
//   String get _forgotPassword =>
//       language.code == 'AR' ? 'نسيت كلمة السر' : 'Forgot password';
//   String get _notHaveAnAccount =>
//       language.code == 'AR' ? 'ليس لدي حساب' : 'Not have an account';
//   String get _alreadyHaveAnAccount =>
//       language.code == 'AR' ? 'بالفعل لدي حساب' : 'Already have an account';
//   String get _username => language.code == 'AR' ? 'اسم المستخدم' : 'Username';
//
//   String get _login => language.code == 'AR' ? 'تسجيل دخول' : 'Login';
//
//   String get _signup => language.code == 'AR' ? 'إنشاء حساب' : 'Sign Up';
//   String get _agreementText =>
//       language.code == 'AR' ? 'أنا أوافق على' : 'I agree to the';
//
//   /// Social login options, you should provide callback function and icon path.
//   /// Icon paths should be the full path in the assets
//   /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
//   List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
//         SocialLogin(
//             callback: () async => LoginFunctions(context).socialLogin('Google'),
//             iconPath: 'assets/images/google.png'),
//         SocialLogin(
//             callback: () async =>
//                 LoginFunctions(context).socialLogin('Facebook'),
//             iconPath: 'assets/images/facebook.png'),
//         SocialLogin(
//             callback: () async =>
//                 LoginFunctions(context).socialLogin('Linkedin'),
//             iconPath: 'assets/images/linkedin.png'),
//       ];
// }
//
// class LoginFunctions {
//   /// Collection of functions will be performed on login/signup.
//   /// * e.g. [onLogin], [onSignup], [socialLogin], and [onForgotPassword]
//   const LoginFunctions(this.context);
//   final BuildContext context;
//
//   /// Login action that will be performed on click to action button in login mode.
//   Future<String?> onLogin(LoginData loginData) async {
//     DialogBuilder(context).showLoadingDialog();
//     await Future.delayed(const Duration(seconds: 2));
//     Navigator.of(context).pop();
//     DialogBuilder(context).showResultDialog('Successful login.');
//     Navigator.of(context).pop();
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => const EcommerceTest(),
//     ));
//     return null;
//   }
//
//   /// Sign up action that will be performed on click to action button in sign up mode.
//   Future<String?> onSignup(SignUpData signupData) async {
//     DialogBuilder(context).showLoadingDialog();
//     await Future.delayed(const Duration(seconds: 2));
//     Navigator.of(context).pop();
//     DialogBuilder(context).showResultDialog('Successful sign up.');
//     Navigator.of(context).pop();
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => const EcommerceTest(),
//     ));
//
//     return null;
//   }
//
//   /// Social login callback example.
//   Future<String?> socialLogin(String type) async {
//     DialogBuilder(context).showLoadingDialog();
//     await Future.delayed(const Duration(seconds: 2));
//     Navigator.of(context).pop();
//     DialogBuilder(context)
//         .showResultDialog('Successful social login with $type.');
//     return null;
//   }
//
//   /// Action that will be performed on click to "Forgot Password?" text/CTA.
//   /// Probably you will navigate user to a page to create a new password after the verification.
//   Future<String?> onForgotPassword(String email) async {
//     DialogBuilder(context).showLoadingDialog();
//     await Future.delayed(const Duration(seconds: 2));
//     Navigator.of(context).pop();
//     // You should determine this path and create the screen.
//     // Navigator.of(context).pushNamed('/forgotPass');
//     return null;
//   }
// }
//
// class DialogBuilder {
//   /// Builds various dialogs with different methods.
//   /// * e.g. [showLoadingDialog], [showResultDialog]
//   const DialogBuilder(this.context);
//   final BuildContext context;
//
//   /// Example loading dialog
//   Future<void> showLoadingDialog() => showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) => WillPopScope(
//           onWillPop: () async => false,
//           child: AlertDialog(
//             content: SizedBox(
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: CircularProgressIndicator(
//                   color: Theme.of(context).primaryColor,
//                   strokeWidth: 3,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//
//   /// Example result dialog
//   Future<void> showResultDialog(String text) => showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           content: SizedBox(
//             height: 100,
//             width: 100,
//             child: Center(child: Text(text, textAlign: TextAlign.center)),
//           ),
//         ),
//       );
// }
