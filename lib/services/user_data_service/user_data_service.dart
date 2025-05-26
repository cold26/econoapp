import 'package:econoapp/common/models/user_model.dart';
import 'package:econoapp/common/data/data_result.dart';


abstract class UserDataService {
  DataResult<UserModel> getUserData();
}