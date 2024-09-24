import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

//package that contain the orientation locking and more!
//import 'package:flutter/services.dart';

//creating a ColorScheme for light mode
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 36, 23, 179),
);
//creating a ColorScheme for dark mode

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  //to ensure that the orientation locking work asa intended
 
  // WidgetsFlutterBinding.ensureInitialized();
  // to lock the orientation of app if the screen rotate the app does not
  // SystemChrome.setPreferredOrientations(
    // [
      // DeviceOrientation.portraitUp,
    // ],
  // ).then(
    // (fn) {
    // ## Runapp is to be put in here
  //   },
  // );
      runApp(
        MaterialApp(
          //setting dark theme features
          //using copyWith to keep the existing and overload just the one i choose
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: kDarkColorScheme,
            cardTheme: CardTheme(
              color: kDarkColorScheme.onPrimary,
            ),
            appBarTheme: AppBarTheme(
              color: kDarkColorScheme.onSecondary,
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: kDarkColorScheme.secondaryContainer,
                backgroundColor: kDarkColorScheme.onSecondaryContainer,
              ),
            ),
            textTheme: const TextTheme().copyWith(
              titleLarge: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          //setting light theme features

          theme: ThemeData().copyWith(
            scaffoldBackgroundColor: kColorScheme.primaryContainer,
            colorScheme: kColorScheme,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: kColorScheme.secondaryContainer,
                backgroundColor: kColorScheme.onSecondaryContainer,
              ),
            ),
            cardTheme: CardTheme(
              color: kColorScheme.onPrimary,
            ),
            appBarTheme: AppBarTheme(
              color: kColorScheme.secondaryContainer,
              foregroundColor: Colors.black,
            ),
          ),
          home: const Expenses(),
          //used to determine the mode (sytem is the default).
          themeMode: ThemeMode.system,
        ),
      );
}
