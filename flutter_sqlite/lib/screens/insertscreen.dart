import 'package:flutter/material.dart';
import 'package:flutter_sqlite/utils/database_helper.dart';

class InsertScreen extends StatefulWidget {
  @override
  _InsertScreenState createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  String sex = "ชาย";
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper.internal();

  @override
  Widget build(BuildContext context) {
    TextEditingController myFirstName = TextEditingController();
    TextEditingController myLastName = TextEditingController();
    TextEditingController myEmail = TextEditingController();
    TextEditingController myPhone = TextEditingController();



    Future<Null> saveData() async{
      print(myFirstName.text);
      print(myLastName.text);
      print(myEmail.text);
      print(myPhone.text);
      print(sex);

      if(_formKey.currentState.validate()){
        Map member = {
          'firstName': myFirstName.text,
          'lastName': myLastName.text,
          'email': myEmail.text,
          'telephone': myPhone.text,

        };
        await databaseHelper.saveData(member);

        print("OK");
      }else{
        print("Fail");
      }

    }


    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียนสมาชิก'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: ()=>saveData())
        ],),
      body: ListView(
        children: <Widget> [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('รายละเอียด', style: Theme.of(context).textTheme.title,),
                ),
                Divider(), //เส้นคั่น
                Padding(padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget> [
                        Row(
                          children: <Widget>[

                            Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'ชื่อ'),
                              controller: myFirstName,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'กรุณากรอกชื่อ';
                                }
                                return null;
                              },),
                            ),
                            SizedBox(width: 20.0,), //ช่องว่างคั่น
                            Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'นามสกุล'),
                              controller: myLastName,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'กรุณากรอกนามสกุล';
                                }
                                return null;
                              },
                            )
                            ),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'อีเมลล์',
                              labelStyle: TextStyle(fontSize: 15.0)
                          ), controller: myEmail ,
                          validator: (value){
                            if(value.isEmpty){
                              return 'กรุณากรอกอีเมลล์';
                            }
                            return null;
                          },

                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'เบอร์โทร',
                              labelStyle: TextStyle(fontSize: 15.0)
                          ), controller: myPhone,
                          validator: (value){
                            if(value.isEmpty){
                              return 'กรุณากรอกเบอร์โทร';
                            }
                            return null;
                          },
                        ),
                        ListTile(
                            title: const Text('เพศ', style: TextStyle(fontSize: 15.0),),
                            trailing: new DropdownButton<String>(
                              value: sex,
                              style: TextStyle(fontSize: 15.0, color: Colors.black),
                              onChanged: (String newValue){
                                setState(() {
                                  sex = newValue;
                                });
                              },
                              items: <String>[
                                'ชาย', 'หญิง', 'เพศที่สาม',
                              ].map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            )
                        )],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
