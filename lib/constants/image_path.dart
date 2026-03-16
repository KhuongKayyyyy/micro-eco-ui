// 모티 이미지 상수값
String iconPath = "assets/icons/";
String imagePath = "assets/images/";
String samplePath = "assets/samples/";

String defaultProfile = "${iconPath}ic_default_profile.png";

abstract final class ImagePaths {
  static const _base = 'assets/icons';

  // ---------------------------Auth---------------------------------------------
  static const authGoogle = '$_base/google.png';
  static const authFacebook = '$_base/facebook.png';

  // ---------------------------Tab---------------------------------------------
  static const tabHomeON = '$_base/tab_home_on.png';
  static const tabHomeOFF = '$_base/tab_home_off.png';
  static const tabHashtagON = '$_base/tab_hashtag_on.png';
  static const tabHashtagOFF = '$_base/tab_hashtag_off.png';
  static const tabDebateON = '$_base/tab_debate_on.png';
  static const tabDebateOFF = '$_base/tab_debate_off.png';
  static const tabBadgeON = '$_base/tab_badge_on.png';
  static const tabBadgeOFF = '$_base/tab_badge_off.png';
  static const tabMentorON = '$_base/tab_mentor_on.png';
  static const tabMentorOFF = '$_base/tab_mentor_off.png';
}
