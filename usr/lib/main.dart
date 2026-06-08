import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/dashboard_screen.dart';
import 'package:couldai_user_app/screens/pipeline_screen.dart';
import 'package:couldai_user_app/screens/leads_screen.dart';

void main() {
  runApp(const LeadAutomationApp());
}

class LeadAutomationApp extends StatelessWidget {
  const LeadAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'n8n Lead Automation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/pipeline': (context) => const PipelineScreen(),
        '/leads': (context) => const LeadsScreen(),
      },
    );
  }
}
