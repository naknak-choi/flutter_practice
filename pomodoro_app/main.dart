import 'dart:ffi';
import 'dart:mirrors';

//Mixin - 생성자가 없는 클래스 / 상속 필요 없이 안에 있는 정보를 가져다가 쓸 수 있는 거 with 으로 사용
class Strong {
  final double strenghtLevel = 1500.99;
}

class QuickRunner {
  void runQuick() {
    print('runnnnnn');
  }
}

class Tall {
  final double height = 1.99;
}

class Human with Strong, QuickRunner, Tall {
  final String name;
  Human({required this.name});

  void sayHello() {
    print("$name");
  }
}

typedef ListOfInts = List<int>;

//enum 은 새로운 타입을 선언해서 실수를 방지하는 역할을 합니다.
enum Team { blue, red }

// class
class Player extends Human {
  String name;
  int xp, age;
  Team team;

  Player.fromJson(Map<String, dynamic> playerJson)
      : name = playerJson['name'],
        xp = playerJson['xp'],
        team = playerJson['team'];

  // Player(String name, int xp){
  //   this.name = name;
  //   this.xp = xp;
  // }
  // named constructor parameters - null 값 방지
  Player({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  }) : super(name: name);
// 자바와 다르게 super을 생성자 안에가 아닌 밖에다 선언해준다

  @override
  void sayHello() {
    super.sayHello();
    print("${team}");
  }

  Player.createBlueteam({
    required String name,
    required int age,
  })  : this.xp = 0,
        this.team = Team.blue,
        this.age = age,
        this.name = name;
  Player.createRedteam(String name, int age)
      : this.xp = 0,
        this.team = Team.red,
        this.age = age,
        this.name = name;

  //String name;
  // int xp;

  // Player(this.name, this.xp);  이렇게 하면 더 멋짐

  void sayHello() {
    print("Hi my name is $name");
  }
}

void main() {
  var appDate = [
    {
      'name': 'nak1',
      'xp': 0,
      'team': "red",
    },
    {
      'name': 'nak2',
      'xp': 0,
      'team': "red",
    },
    {
      'name': 'nak3',
      'xp': 0,
      'team': "red",
    },
  ];

  appDate.forEach((playerJson) {
    var player = Player.fromJson(playerJson);
    player.sayHello();
  });

// ; 제외하고 ..으로 하면 코드가 더 간결 + 값을 수정할 수 있다.
  var nak = Player(name: 'nak', xp: 12000, team: Team.blue, age: 26)
    ..name = 'las'
    ..age = 25
    ..team = Team.red
    ..xp = 1233;
  var nak2 = Player(name: 'nak', xp: 12000, team: Team.blue, age: 26);
  var poto = nak2
    ..name = 'las'
    ..age = 25
    ..team = Team.red
    ..xp = 1233
    ..sayHello();

  Player.createBlueteam(
    age: 12,
    name: '123',
  );

  print("hello world");

  // variable
  var name = 'nak';
  String name2 = 'nak2';
  // 함수, class 내에 지역 변수 var / 다른 때는 타입을 지정해준다.

  // dynamic type 변수의 타입이 dynamic이면 여러 타입이 들어갈 수 있다. 그러나 필요할 때만 사용해야한다.
  var tmp;
  dynamic tmp2;
  tmp = 'skr';
  tmp = 5;
  tmp = true;
  if (tmp is String) {
    // tmp. String에서 제공하는 다양한 함수를 사용할 수 있다.
  }
  if (tmp is Int) {
    // tmp. Int에서 제공하는 다양한 함수를 사용할 수 있다.
  }

  // null safety - 변수나 어떤 데이터가 null이 될 수도 있다는 걸 명시하는 걸 말함
  // null 값을 참조할 수 없도록 함
  bool isEmpty(String string) => string.length == 0;

  // isEmpty(null); 하면 NoSuchMethodError가 발생
  // null이 될 수 있다는 걸 명확하게 표시해야함
  String? nak = 'nak';
  nak = null;
  // nak.length; 이렇게 하면 컴파일러가 안된다고 알려줌
  nak?.isEmpty; // 이게 ?가 있으면 널이 아니라면 이라는 뜻을 가진다. 코틀린에서 !!. 과 같죠?

  // final variable
  final String name4 = 'nak';
  // name4 = "2";
  final tmp3 = 'nak'; // 이제 바꿀 수 없게 된다.

  // late variale - 초기데이터 없이 변수 선언 할 수 있게 해줌
  // final 변수이기 때문에 나중에 변경할 수 없지만 나중에 선언할 수 있게 해주고 값을 할당하기 전에 변수 사용할 수 없다.
  late final String test;
  test = 'nak';
  late String tmp4;
  tmp4 = '232';
  tmp4 = '2322';

  //const variable - 상수(자바스크립트는 final과 비슷) but, dart에서는 const란 compile-time constant라고 함
  const API = '123123'; // 바뀌지 않고 컴파일 될 때 알게됨 그러니까 컴파일이 될 때 API 변수를 컴퓨터는 몰라,
  // 컴파일 타임이란건 앱에 담긴 코드를 앱스토어에 보내기 전에 컴파일 때 평가되는 뜻. 그때 사용되는 변수를 의미한다.

  // 자료형
  String s;
  bool b;
  int a;
  double d;
  num n;
  n = 12;
  n = 1.1;

  // list 마지막을 , 로 해주는 게 좋다.
  var giveMeFive = true;
  var numbers = [
    1,
    2,
    3,
    4,
    if (giveMeFive) 5, // if(giveMeFive) {numbeers.add(5)} 와 같은 뜻
  ];
  List<int> numbers2 = [
    1,
    2,
    3,
    4,
    5,
    6,
  ];
  numbers.add(2);
  numbers2.add(3);
  numbers.first;
  numbers.last;
  numbers.isEmpty;

  // String Interpolation - text에 변수를 추가하는 방법
  var name5 = 'nak';
  var age = 5;
  var greeting =
      "Hello everyone, my name is $name5, and I'm ${age + 1}. nice meet you!";
  print(greeting);

  //collection for
  var oldFriends = [
    'nak',
    'you',
  ];
  var newFriends = [
    'lewis',
    'ralph',
    for (var friend in oldFriends) "h $friend",
  ];

  // maps - 딕셔너리 같은거
  var player = {
    // key는 String 타입, value는 object 타입으로 자동 할당된다. Maps<String, Object> 로
    'name': 'nak',
    'xp': 100,
    'superpower': false,
  };

  Map<List<int>, bool> player2 = {
    [1, 2, 4]: true,
  };

  // sets - 모든 요소가 유니크하다. 즉 중복이 될 수 없다. 이게 list 와 다른점
  Set<int> numberss = {1, 2, 3, 4};
  numberss.add(1);

  // function
  void sayHello(String name) {
    print("hello $name");
  }

  String saySomething(String name) => "hello $name";
  num plus(num a, num b) => a + b;

  // named parameter  {} 추가하면 됨
  // 만약에 유저가 null 값을 주면 어떻게 할꺼야?
  // 1. 초기값 주기
  // 2. required 추가하기 - 호출 시 해당 매개변수가 꼭 있어야 한다고 제한하는 것
  String sayHello2({
    required String name,
    required int age,
    required String country,
  }) {
    return "Hello $name, you $age, and you come from $country";
  }

  // print(sayHello2("123", 123, "dsaf"));
  print(sayHello2(age: 12, name: "fdas", country: "dsaf"));

  // optional positional parameter - ? 는 not require을 의미한다.
  String sayHello3(String name, int age, [String? country = 'cuba']) =>
      'Hello $name, $age, $country';

  var results = sayHello3('name', 12);

  // ??, ?= operator
  String capitalizeName(String? name) =>
      name != null ? name.toUpperCase() : 'ANON';

// left - null 이면 right return 시킴
  String capitalizeName2(String? name) => name?.toUpperCase() ?? 'ANON';

  String? nama;
  // name이 null 값이면 nak을 할당해줘. 그래서 2번째 nak2는 할당되지 않음.
  name ??= 'nak';
  name ??= 'nak2';

  capitalizeName('nu');
  capitalizeName(null);

  //Typedef - alias를 만들 수 있음

  ListOfInts reverseListOfNumbers(List<int> list) {
    var revesed = list.reversed;
    return revesed.toList();
  }

  ;
}
