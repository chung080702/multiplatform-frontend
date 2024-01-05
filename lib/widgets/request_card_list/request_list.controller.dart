import 'package:get/get.dart';
import 'package:multiplatform_app/general_controller/account.controller.dart';
import 'package:multiplatform_app/models/request.model.dart';
import 'package:multiplatform_app/utils/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestListController extends GetxController {
  final accountController = Get.find<AccountController>();

  Future<List<Request>> fetchGetAllRequestApi(int page) async {
    try {
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.requestEndPoints.getAll(page));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonRequests = data['supportRequests'];
        List<Request> requests = jsonRequests.map((item) => Request.fromJson(item)).toList();
        return requests;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }

  Future<List<Request>> fetchGetAllRequestOfUserApi() async {
    try {
      var accountID = accountController.account.value?.id;
      var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.requestEndPoints.getAllOfUser(accountID!, 1));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonRequests = data['supportRequests'];
        List<Request> requests = jsonRequests.map((item) => Request.fromJson(item)).toList();
        return requests;
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
  }
}