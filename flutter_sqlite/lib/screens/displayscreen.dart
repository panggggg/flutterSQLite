import 'package:flutter/material.dart';
import 'package:flutter_sqlite/utils/database_helper.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {

  DatabaseHelper databaseHelper = DatabaseHelper.internal();

  List members = [];
  Future getMembers() async {
    var res = await databaseHelper.getList();
    print(res);
    setState(() {
      members = res;
    });
  }
  
  Future removeMembers(int id) async {
    await databaseHelper.remove(id);
    getMembers();
  }

  void initState() {
    super.initState();
    getMembers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("หน้ารายชื่อสมาชิก"),),
      body: ListView.builder(
          itemBuilder: (context, int index){
            return ListTile(
              title: Text(
                '${members[index]['first_name']} ${members[index]['last_name']}'
              ),
              subtitle: Text('${members[index]['email']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => removeMembers(members[index]['id']),
              ),
            );
          },
        itemCount: members != null ? members.length : 0,
      ),
    );
  }
}
