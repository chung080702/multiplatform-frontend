import 'dart:async';
import 'dart:convert';

import '../../models/group.model.dart';
import 'package:http/http.dart' as http;

Future<List<Group>> fetchGroup() async {
  final response = await http.get(Uri.parse('https://multiplatform-backend.vercel.app/group/page/1'));

  if(response.statusCode == 200){
    List jsonResponse = json.decode(response.body)['groups'];
    return jsonResponse.map((group) => Group.fromJson(group)).toList();
  }else{
    throw Exception('Failed to load Group');
  }
}