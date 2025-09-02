import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/account_page.dart';
import 'pages/register_page.dart';
import 'pages/cart_page.dart';
import 'pages/list_chat.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',  // Set login as initial route
        routes: {
          '/': (context) => const HomePage(),
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
          '/account': (context) => const AccountPage(),
          '/cart': (context) => const CartPage(),
          '/chats': (context) => const ListChatPage(),
          '/chat-detail': (context) => const DetailChatPage(chatId: ''),
        },
        builder: (context, child) {
          return WillPopScope(
            onWillPop: () async {
              // Prevent going back to login if already on login
              if (ModalRoute.of(context)?.settings.name == '/login') {
                return true; // Allow exit app on back press from login
              }
              // For other screens, go back to home
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              return false;
            },
            child: child!,
          );
        },
      ),
    );
  }
}