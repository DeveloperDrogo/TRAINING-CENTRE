import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs =
      SharedPreferences as SharedPreferences;
  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
  }

  String get token => _sharedPrefs.getString("token") ?? "";
  String get name => _sharedPrefs.getString('name') ?? '';
  String get mobile => _sharedPrefs.getString('mobile') ?? '';
  String get dob => _sharedPrefs.getString("dob") ?? "";
  String get email => _sharedPrefs.getString("email") ?? "";
  String get address => _sharedPrefs.getString("address") ?? "";
  String get onlyNumber => _sharedPrefs.getString("onlyNumber") ?? '';
  String get countryCode => _sharedPrefs.getString("countryCode") ?? '';
  String get role => _sharedPrefs.getString("role") ?? '';
  String get isLoggedIn => _sharedPrefs.getString("isLoggedIn") ?? "";
  String get imagePath => _sharedPrefs.getString('image_path') ?? '';
  String get gender => _sharedPrefs.getString('gender') ?? '';
  String get bloodGroup => _sharedPrefs.getString('bloodGroup') ?? '';
  String get qualification => _sharedPrefs.getString('qualification') ?? '';
  String get workExperience => _sharedPrefs.getString('work_experience') ?? '';
  String get governemntId => _sharedPrefs.getString('governemnt_id') ?? '';
  String get trainingCenterName =>
      _sharedPrefs.getString('training_center_name') ?? '';
  String get trainingCenterAddress =>
      _sharedPrefs.getString('training_center_address') ?? '';
  String get trainingCenterLogo =>
      _sharedPrefs.getString('training_center_logo') ?? '';
  String get id => _sharedPrefs.getString('id') ?? '';

  set token(String value) {
    _sharedPrefs.setString('token', value);
  }

  set id(String value) {
    _sharedPrefs.setString('id', value);
  }

  set trainingCenterName(String value) {
    _sharedPrefs.setString('training_center_name', value);
  }

  set trainingCenterAddress(String value) {
    _sharedPrefs.setString('training_center_address', value);
  }

  set trainingCenterLogo(String value) {
    _sharedPrefs.setString('training_center_logo', value);
  }

  set gender(String value) {
    _sharedPrefs.setString('gender', value);
  }

  set bloodGroup(String value) {
    _sharedPrefs.setString('bloodGroup', value);
  }

  set qualification(String value) {
    _sharedPrefs.setString('qualification', value);
  }

  set workExperience(String value) {
    _sharedPrefs.setString('work_experience', value);
  }

  set governemntId(String value) {
    _sharedPrefs.setString('governemnt_id', value);
  }

  set imagePath(String value) {
    _sharedPrefs.setString('image_path', value);
  }

  set onlyNumber(String value) {
    _sharedPrefs.setString('onlyNumber', value);
  }

  set role(String value) {
    _sharedPrefs.setString('role', value);
  }

  set countryCode(String value) {
    _sharedPrefs.setString('countryCode', value);
  }

  set name(String value) {
    _sharedPrefs.setString('name', value);
  }

  set mobile(String value) {
    _sharedPrefs.setString('mobile', value);
  }

  set dob(String value) {
    _sharedPrefs.setString('dob', value);
  }

  set email(String value) {
    _sharedPrefs.setString('email', value);
  }

  set address(String value) {
    _sharedPrefs.setString('address', value);
  }

  set isLoggedIn(String value) {
    _sharedPrefs.setString('isLoggedIn', value);
  }
}
