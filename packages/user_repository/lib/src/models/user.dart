import '../entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.hasActiveCart});

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }
}
//required itu memastikan bahwa parameter (input) harus diberikan saat 
//membuat objek dari class 
//Biasanya dipakai di constructor (fungsi) untuk mendeklarasikan bahwa nilai untuk parameter tersebut tidak boleh kosong.

//this itu nunjukin 'ini', Dalam konteks constructor
// 'this' digunakan buat mengakses parameter yang diterima oleh constructor dan menyamakan nama parameter tersebut dengan variabel instance (atribut kelas).

//-------------------------
//MyUserEntity itu berfungsi buat transform data dari class MyUser yang nanti bakal di send ke json map (database)
//MyUser itu buat actual act nya. Buat komprehensif aja

//gini prosesnya
//input dari class MyUser
//to method: MyUserEntity bakal transform class dari MyUser ke json map thats going to database
//from method: from Entity itu ngambil json map dari database dan transform json within MyUserEntity objek  dan MyUserEntity transform datanya sendiri ke MyUser Class
//Make sense
//---------------------