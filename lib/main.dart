import 'package:flutter/material.dart';
import 'package:gym_management/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://ctkwcrhrrpudvzjptqer.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN0a3djcmhycnB1ZHZ6anB0cWVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0Mjc1MDAsImV4cCI6MjA0NzAwMzUwMH0.oIJHPvrfW3YmwHYNyuxvtQkeBaJZg3gUOmFTKM27CAk",
  );
  runApp(const GymManagementApp());
}