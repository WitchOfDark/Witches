import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error404 extends StatelessWidget {
  const Error404({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SelectableText("Error 404 : $error"),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleError extends StatelessWidget {
  const SimpleError(this.error, {super.key});

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Home'),
                    ),
                    if (error is FlutterErrorDetails)
                      SelectableText(
                        error.exception.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.purple),
                        textDirection: TextDirection.ltr,
                      ),
                    SelectableText(
                      error.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.amber),
                      textDirection: TextDirection.ltr,
                    ),
                    if (error is FlutterError || error is FlutterErrorDetails)
                      SelectableText(
                        error is FlutterErrorDetails ? error.stack.toString() : error.stackTrace.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                        textDirection: TextDirection.ltr,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
