class UserInformation{
    int id;
    String name;
    String email;
    String phone;
    String dateOfBirth;
    String password;

  UserInformation(
     this.id,
      this.name,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.password,
  );

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth' : dateOfBirth,
      'password':password,
    };
    return map;
  }

  UserInformation.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    dateOfBirth = map['dateOfBirth'];
    password = map['password'];
  }

}