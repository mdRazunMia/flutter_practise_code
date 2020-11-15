import 'package:flutter/material.dart';
import 'package:pactise_app/models/user_information.dart';
import '../sqlite/db_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<List<UserInformation>> userInformations;
  var dbHelper;
   @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
    //myFocusNode = FocusNode();
  }




  SingleChildScrollView dataTable(List<UserInformation> userInformations) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Id'),
          ),
          // DataColumn(
          //   label: Text('Phone'),
          // ),
          // DataColumn(
          //   label: Text('DateOfBirth'),
          // ),
          DataColumn(
            label: Text('Password'),
          ),
          DataColumn(
            label: Text('Delete'),
          ),    
        ],
        rows: userInformations.map(
          (userInformation) => DataRow(
            cells: [
              DataCell(
                Text(userInformation.name),
              ),
              DataCell(
                Text('${userInformation.id}'),
              ),
              // DataCell(
              //   Text(userInformation.phone,
              // ),
              // ),
              // DataCell(
              //   Text(userInformation.dateOfBirth,
              // ),
              // ),
              DataCell(
                Text(userInformation.password),
              ),
              DataCell(
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print(userInformation.id);
                    dbHelper.delete(userInformation.id);
                    refreshList();
                  },
                ),
              ),
            ]
          )
        ).toList(),
      ),
    );
  }



    list() {
    return Expanded(
      child: FutureBuilder(
        future: userInformations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text('No Data Found');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

    refreshList() {
    setState(
      () {
        userInformations = dbHelper.getUserInformation();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'user Informations',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }
}