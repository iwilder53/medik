import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediq/Screens/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediq/Screens/checkout/checkout.dart';
import 'package:mediq/Screens/checkout/order_confirmed.dart';
import 'package:mediq/Screens/home/homescreen.dart';
import 'package:mediq/navigation/arguments.dart';
import 'package:mediq/providers/cart_provider.dart';
import 'package:mediq/providers/order_provider.dart';
import 'package:mediq/providers/place_provider.dart';
import 'package:mediq/providers/products_provider.dart';
import 'package:mediq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'navigation/navigationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'project-54675965409',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => OrderDetailsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PlaceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        //  themeMode: ThemeMode.system,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff188F79),
        ),
        onGenerateRoute: generateRoute,

        home: (FirebaseAuth.instance.currentUser != null)
            ? HomeScreen(
                args: HomeScreenArguments(
                    mobNumber: int.parse(
                        FirebaseAuth.instance.currentUser!.phoneNumber ?? '0')),
              )
            : const LoginScreen(),
      ),
    );
  }
}
