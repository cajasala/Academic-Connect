import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/ProfileServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class ProfilePageModel extends BaseModel {
  final _profileServices = locator<ProfileServices>();
  final _sharedPreferences = locator<SharedPreferencesHelper>();
  User userProfile;

  Future<bool> setUserProfileData({
    String displayName,
    String standard,
    String division,
    String bloodGroup,
    String mobileNo,
    String dob,
    String enrollNo,
    String guardianName,
    UserType userType,
    var photoUrl,
  }) async {
    setState(ViewState.Busy);

    await _profileServices.setProfileData(
        displayName: displayName,
        standard: standard,
        division: division,
        bloodGroup: bloodGroup,
        mobileNo: mobileNo,
        dob: dob,
        enrollNo: enrollNo,
        guardianName: guardianName,
        userType: userType);
    await Future.delayed(const Duration(seconds: 3), () {});

    setState(ViewState.Idle);
    return true;
  }

  Future<User> getUserProfileData() async {
    setState(ViewState.Busy);
    String id = await _sharedPreferences.getLoggedInUserId();
    UserType userType = await _sharedPreferences.getUserType();
    userProfile = await _profileServices.getProfileData(id, userType);
    setState(ViewState.Idle);
    return userProfile;
  }
}