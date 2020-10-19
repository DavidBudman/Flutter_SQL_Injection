import 'package:flutter/material.dart';
import 'package:sqli_vulnerable/database.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _courseSearchController = TextEditingController();
  List<Map<String, dynamic>> _courses = [];

  void _updateCourses({String courseName}) {
    DBProvider.db.getCoursesByName(_courseSearchController.text).then((result) => setState(() { _courses = result; }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateCourses();
  }

  @override
  void dispose() {
    _courseSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Courses')),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(6.0),
            width: 300,
            child: TextField(
              controller: _courseSearchController,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto, labelText: 'Search Courses'),
            ),
          ),
          RaisedButton(
            //onPressed: () async => setState(() async => await _updateCourses(courseName: _courseSearchController.text)),
            onPressed: () => _updateCourses(),
            child: Text('SUBMIT')
          ),
          SizedBox(height: 20.0),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Text('Course',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('Credits',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('Teacher',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ]),
          Divider(height: 20, thickness: 2.0),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _courses.length,
              itemBuilder: (context, i) => Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text('${_courses[i]['name']}')),
                    Expanded(
                        child: Text('${_courses[i]['credits']}',
                            textAlign: TextAlign.center)),
                    Expanded(
                        child: Text('${_courses[i]['teacher']}',
                            textAlign: TextAlign.center))
                  ]),
              )
            ),
          )
        ]),
      )
    );
  }
}
