import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<bool> checkEmailOrCpf(String value) async {
  final response = await Supabase.instance.client
      .from('cliente')
      .select()
      .or('email.eq.$value,cpf.eq.$value')
      .maybeSingle();

  // Verifica se `response` é `null`, indicando que nenhum registro foi encontrado
  if (response == null) {
    print("falso");
    return false;
  } else {
    print("verdadeiro");
    return true;
  }
}

