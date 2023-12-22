import 'package:supabase_flutter/supabase_flutter.dart';

const String nikPattern =
    r"((1[1-9])|(21)|([37][1-6])|(5[1-4])|(6[1-5])|([8-9][1-2]))[0-9]{2}[0-9]{2}(([0-6][0-9])|(7[0-1]))((0[1-9])|(1[0-2]))([0-9]{2})[0-9]{4}";

RegExp nikRegex = RegExp(nikPattern);

final supabase = Supabase.instance.client;
