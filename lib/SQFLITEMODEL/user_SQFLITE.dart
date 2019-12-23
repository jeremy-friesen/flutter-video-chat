class User{
  //Creating the variables first
  int userName;
  int email;
  String age;

  //Making a Constructor
  User({
    this.userName,
    this.email,
    this.age,
  });

  User.fromMap(Map<String,dynamic> map){
    this.userName = map['userName'];
    this.email = map['email'];
    this.age = map['age'];
  }

  //Putting these elements to a map
  Map<String, dynamic> toMap(){
    return{
      'id': this.userName,
      'sid': this.email,
      'grades' : this.age,
    };
  }

  //Overriding the toString function
  @override
  String toString(){
    return 'Grades{id: $userName, sid: $email, grades: $age}';
  }

}// Grade