import 'package:mysql1/mysql1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tcc/shared/config.dart';

Future<SupabaseClient> connectSupadatabase() async {
  return Supabase.instance.client;
}