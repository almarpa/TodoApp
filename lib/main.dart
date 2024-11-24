import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/presentation/login/form_provider.dart';
import 'package:todo_app/app/presentation/routes/app_routes.dart';
import 'package:todo_app/app/presentation/routes/routes.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import 'app/presentation/common/firebase_service.dart';
import 'app/presentation/login/login_provider.dart';
import 'app/presentation/register/register_provider.dart';

void main() async {
  Intl.defaultLocale = 'es_ES';
  await initializeDateFormatting();

  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService.initializeApp();

  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // final userBox = await Hive.openBox('user');
  // final isLogged = userBox.get('isLogged', defaultValue: false);
  // await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(lazy: false, create: (_) => FormProvider()),
          ChangeNotifierProvider(lazy: false, create: (_) => LoginProvider()),
          ChangeNotifierProvider(
              lazy: false, create: (_) => RegisterProvider()),
        ],
        child: MaterialApp(
            title: 'TodoApp',
            routes: appRoutes,
            initialRoute: Routes.splash,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: primary, primary: primary, secondary: primary),

                // SCAFFOLD
                scaffoldBackgroundColor: colorWhite,

                // TEXT
                textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Poppins',
                    bodyColor: textColor,
                    displayColor: textColor),

                // BOTTOM SHEET
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent),

                // ELEVATED BUTTON
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w700))))));
  }
}
