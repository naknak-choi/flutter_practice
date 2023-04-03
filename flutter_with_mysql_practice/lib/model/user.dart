class User {
  int user_id;
  String user_name;
  String user_email;
  String user_password;

  // json으로 converting 될 떄는 Map 데이터 형식을 취하므로
  User(this.user_id, this.user_name, this.user_email, this.user_password);

  // 생성자가 여러번 호출 되더라도 최초의 생성된 하나의 생성자만 사용하기 위한 디자인 패턴
  // 로그인이 성공한 유저의 각 항목들의 json 데이터를 가져올 수 있게 함
  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json['user_id']),
        json['user_name'],
        json['user_email'],
        json['user_password'],
      );

  // Map을 불러와서 저장해준다
  Map<String, dynamic> toJson() => {
        // column 명을 사용해서 데이터를 보내줄 것이기 때문에 정확하게 이름(같은 키네임)을 넣어줘야한다.
        'user_id': user_id.toString(),
        'user_name': user_name,
        'user_email': user_email,
        'user_password': user_password,
      };
}
