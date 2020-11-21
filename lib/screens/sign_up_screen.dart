import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:pactise_app/screens/login_screen.dart';
import 'package:pactise_app/sqlite/db_helper.dart';
import '../models/user_information.dart';

class SignUpSCreen extends StatefulWidget {
  static const logInRoute = '/login_screen.dart';
  @override
  _SignUpSCreenState createState() => _SignUpSCreenState();
}

String passwordLengthValidator(value) {
  if (value.isEmpty) {
    return "Required *";
  } else if (value.length < 6) {
    return "Password should be at least 6 charaters";
  } else if (value.length >= 15) {
    return "Password should be less then 15 characters";
  } else {
    return null;
  }
}

class _SignUpSCreenState extends State<SignUpSCreen> {
  static final _formKey = GlobalKey<FormState>();
  Future<List<UserInformation>> userInformation;
  static String name;
  static String email;
  static String phone;
  static String dateOfBirth;
  static String password;
  var dbHelper;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SignUp Page',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    onSaved: (value) {
                      name = value;
                      print("name: $name");
                      //print("User Name: ${_nameController.text}");
                    },
                    focusNode: myFocusNode,
                    // autofocus: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    onSaved: (value) {
                      email = value;
                      print("email: $email");
                      //print("User E-Mail: ${_emailController.text}");
                    },
                    focusNode: myFocusNode,
                    autofocus: true,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required *"),
                      EmailValidator(errorText: "Not A Valid Email"),
                    ]),
                    // validator: (value){
                    //   if(value.isEmpty){
                    //     return 'Please enter your E-mail';
                    //   }else{
                    //     return null;
                    //   }
                    // },
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      hintText: 'E-Mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    onSaved: (value) {
                      phone = value;
                      print("phone: $phone");
                      //print("Phone: ${_phoneController.text}");
                    },
                    focusNode: myFocusNode,
                    autofocus: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your phone number';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   keyboardType: TextInputType.text,
                  //   controller:_dateOfBirthController,
                  //   onChanged: (value) {
                  //     print("Date Of Birth: ${_dateOfBirthController.text}");
                  //   },
                  //   focusNode: myFocusNode,
                  //   autofocus: true,
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return 'Please enter your date of Birth';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Date Of Birth',
                  //     hintText: 'Date Of Birth',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  TextFormField(
                    controller: _dateOfBirthController,
                    decoration: InputDecoration(
                      labelText: "Date of birth",
                      hintText: "Ex. Insert your dob",
                    ),
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      _dateOfBirthController.text =
                          DateFormat.yMMMMEEEEd().format(date);
                      //dateOfBirth = _dateOfBirthController.text;
                    },
                    onSaved: (value) {
                      dateOfBirth = value;
                      print("DOB: $dateOfBirth");
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    onSaved: (value) {
                      password = value;
                      print("password: $password");
                      //print("User Password: ${_passwordController.text}");
                    },
                    focusNode: myFocusNode,
                    autofocus: true,
                    validator: passwordLengthValidator,
                    // validator: (value){
                    //   if(value.isEmpty){
                    //     return 'please enter your password';
                    //   }else{
                    //     return null;
                    //   }
                    // },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'password',
                      border: OutlineInputBorder(),
                    ),
                    // _passwordController.clear();
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // return showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return AlertDialog(
                      //       content: Column(children: <Widget>[
                      //         Card(
                      //           child: Column(children: <Widget>[
                      //             ListTile(
                      //               title:
                      //                   Text("Name: ${_nameController.text}"),
                      //             ),
                      //             ListTile(
                      //               title:
                      //                   Text("Email: ${_emailController.text}"),
                      //             ),
                      //             SizedBox(
                      //               height: 20.0,
                      //             ),
                      //             ListTile(
                      //               title:
                      //                   Text("Phone: ${_phoneController.text}"),
                      //             ),
                      //             SizedBox(
                      //               height: 20.0,
                      //             ),
                      //             ListTile(
                      //               title:
                      //                   Text("Date Of Birth: ${_dateOfBirthController.text}"),
                      //             ),
                      //             SizedBox(
                      //               height: 20.0,
                      //             ),
                      //             ListTile(
                      //               title: Text(
                      //                   "Password: ${_passwordController.text}"),
                      //             ),
                      //             SizedBox(
                      //               height: 20.0,
                      //             ),
                      //           ]),
                      //         ),
                      //       ]),
                      //     );
                      //   },
                      // );
                      // if (_nameController.text != null) {
                      //   print('Name is not null');
                      // } else {
                      //   print('Name is null');
                      // }
                      if (_nameController.text != '' &&
                          _emailController.text != '' &&
                          _phoneController.text != '' &&
                          _dateOfBirthController.text != '' &&
                          _passwordController.text != '') {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        UserInformation e = UserInformation(
                            null, name, email, phone, dateOfBirth, password);
                        dbHelper.save(e);
                        _nameController.clear();
                        _emailController.clear();
                        _phoneController.clear();
                        _dateOfBirthController.clear();
                        _passwordController.clear();
                      }
                    },
                    tooltip: 'Show me the user Information',
                    child: Icon(Icons.texture),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
