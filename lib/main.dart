import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origin/controller/random_user.dart';
import 'package:origin/resources/route_manager.dart';
import 'package:origin/user_preferences/user_preferences.dart';
import 'package:provider/provider.dart';
import 'bloc/network_cubit.dart';
import 'bloc/network_services.dart';
import 'controller/locale_provider.dart';
import 'ui/screens/splash/splashScreen.dart';
import 'package:origin/l10n/localization.dart';
import 'package:provider/provider.dart' as prov;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  // This widget is the root of your application.
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    UserPreferences.getLocaleLanguageCode().then((value) => {
      setState(() {
        LocaleProvider().setLocale(locale = Locale(value));
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    var networkService = NetworkService();
    return MultiBlocProvider(
        providers:[
          BlocProvider<NetworkCubit>(
            create: (context) =>
                NetworkCubit(networkService: networkService, context: context),
          ),
        ],
        child: MultiProvider(
            providers: [
              // ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
              ChangeNotifierProvider<RandomUserProvider>(create: (_) => RandomUserProvider()),
            ],
            child: prov.ChangeNotifierProvider(
                create: (_) => LocaleProvider(),
                child: prov.Consumer<LocaleProvider>(
                  builder: (context, model, child) {
                    return ScreenUtilInit(
                      minTextAdapt: false,
                      builder: (BuildContext context, Widget? child) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          onGenerateTitle: (context) =>
                          AppLocalizations.of(context)!.appName,
                          theme: ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                          locale: model.locale ?? locale,
                          localizationsDelegates: const [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                          ],
                          supportedLocales: L10n.all,
                          initialRoute: Splash.id,
                          routes: routes,
                        );
                      },
                    );
                  },
                ))),
    );
  }
}
