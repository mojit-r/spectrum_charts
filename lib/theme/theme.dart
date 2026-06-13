import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: Color(0xFF6D6A2E),
  onPrimary: Color(0xFFFFFFFF),

  secondary: Color(0xFF8C8A4F),
  onSecondary: Color(0xFFFFFFFF),

  tertiary: Color(0xFFA39F5F),
  onTertiary: Color(0xFF000000),

  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),

  surface: Color(0xFFFFFDE7),
  onSurface: Color(0xFF1C1C17),

  outline: Color(0xFF7A7760),
  shadow: Color(0xFF000000),

  inverseSurface: Color(0xFF31312A),
  onInverseSurface: Color(0xFFF4F1DC),

  inversePrimary: Color(0xFFD6D27A),

  surfaceTint: Color(0xFF6D6A2E),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xFFD6D27A),
  onPrimary: Color(0xFF313000),

  secondary: Color(0xFFB9B56A),
  onSecondary: Color(0xFF2A2900),

  tertiary: Color(0xFFC8C27A),
  onTertiary: Color(0xFF232200),

  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),

  surface: Color(0xFF1C1C17),
  onSurface: Color(0xFFF4F1DC),

  outline: Color(0xFF938F72),
  shadow: Color(0xFF000000),

  inverseSurface: Color(0xFFF4F1DC),
  onInverseSurface: Color(0xFF31312A),

  inversePrimary: Color(0xFF6D6A2E),

  surfaceTint: Color(0xFFD6D27A),
);

// final ColorScheme lightColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromARGB(255, 245, 242, 201),  // Color(0xFFF5F2C9)
//   brightness: Brightness.light,
// );

ThemeData lightmode = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,

  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 254, 244),

  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.dragged)) {
        return const Color(0xFFD6D27A);
      }
      return const Color(0xFFD7D8C4);
    }),
    thickness: WidgetStateProperty.all(6.0),
    radius: const Radius.circular(4),
  ),
);

ThemeData darkmode = ThemeData(
  useMaterial3: true,

  colorScheme: darkColorScheme,

  scaffoldBackgroundColor: const Color(0xFF181811),

  cardTheme: CardThemeData(
    color: const Color(0xFF24241D),
    elevation: 2,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.dragged)) {
        return const Color(0xFF6D6A2E);
      }
      return const Color(0xFF8C8A4F);
    }),
    thickness: WidgetStateProperty.all(8),
    radius: const Radius.circular(12),
  ),
);
