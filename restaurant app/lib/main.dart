import 'package:ecommerce/Core/ViewModels/FavoriteProvider.dart';
import 'package:ecommerce/Core/ViewModels/TableSelectionProvider.dart';
import 'package:ecommerce/View/Screens/Home/home.dart';
import 'package:ecommerce/View/Screens/login/Auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Core/ViewModels/AuthProvider.dart';
import 'Core/ViewModels/HomeProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => TableSelectionProvider()),

      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffee8767)),
        ),
        title: 'Ecommerce',
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return Scaffold(
              body: StreamBuilder(
                stream: auth.pb.authStore.onChange,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong!"));
                  } else if (auth.pb.authStore.isValid) {
                    return const HomeScreen();
                  } else {
                    return const CustomLoginScreen();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
