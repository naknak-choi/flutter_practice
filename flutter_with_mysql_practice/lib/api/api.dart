class API {
  // 내 컴퓨터 로컬 저장소와 연결
  static const hostConnect = "http://10.55.1.197/api_new_members";
  // 만들었던 API에 접속하기 위한 변수 폴더에 접근
  static const hostConnectUser = "$hostConnect/user";

  static const signup = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
  static const validateEmail = "$hostConnect/user/validate_email.php";
}
