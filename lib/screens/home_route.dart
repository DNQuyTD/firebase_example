import 'package:firebase_example/locator.dart';
import 'package:firebase_example/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  String token = '';

  Future<void> getToken() async {
    final tk =  await locator<FcmService>().getFcmToken() ?? '';
    await Clipboard.setData(ClipboardData(text: tk));
    setState(() {
      token = tk;
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(token),
          onPressed: () {
            context.push('/first-page');
          },
        ),
      ),
    );
  }
}
