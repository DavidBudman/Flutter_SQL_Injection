import 'package:flutter/material.dart';
import 'package:sqli_vulnerable/Course.dart';
import 'dart:math' as math;
import 'package:sqli_vulnerable/database.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String _username;
  int _userID;
  List<Map> _grades = [];
  int _studentAverage;

  Future<List<Map<String, String>>> getStudentGradesByID(int studentID) async {
    // query database for users grades
    //'''SELECT name, grade FROM grades NATURAL JOIN courses'''
    List<Map> res = await DBProvider.db.getStudentGradesByID(studentID);
    print(res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arguments =
        ModalRoute.of(context).settings.arguments;
    _username = arguments['username'];
    _userID = arguments['userID'];
    //_studentAverage = '90';

    return Scaffold(
        appBar: AppBar(title: Text('$_username details')),
//        floatingActionButton: FloatingActionButton(
//            onPressed: () => Navigator.pushNamed(context, '/courses'),
//            child: Icon(Icons.book)),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
            SizedBox(height: 50),
            Container(
                alignment: Alignment.center,
                width: 150,
                child: Text('Average',
                    style: TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.bold))),
            Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 4.0)),
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: DBProvider.db.getStudentAverageByID(_userID),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        return Text(snap.data.toString(),
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center);
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
            SizedBox(height: 50),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text('Course',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Grade',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Credits',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ]),
            Divider(height: 20, thickness: 2.0),
            FutureBuilder<List<Map<String, dynamic>>>(
                // future: getStudentGradesByID(_userID),
                future: DBProvider.db.getStudentGradesByID(_userID),
                builder: (context, snap) {
                  print(snap.data);
                  if (!snap.hasData)
                    return Container();
                  else
                    return Expanded(child: ListView(
                        shrinkWrap: true,
                        children: (snap.data.map((Map courseGrade) => Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text('${courseGrade['name']}')),
                                    Expanded(
                                        child: Text('${courseGrade['grade']}',
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text('${courseGrade['credits']}',
                                            textAlign: TextAlign.center))
                                  ]),
                            ))).toList()));
                }),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/courses');
                    },
                    child: Text('View All Courses')
                  ),
                )
          ]),
        ));
  }
}
