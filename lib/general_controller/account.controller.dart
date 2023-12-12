import 'package:get/get.dart';
import 'package:multiplatform_app/models/user.model.dart';

class AccountController extends GetxController {
  var account = Rx<User?>(null);
}