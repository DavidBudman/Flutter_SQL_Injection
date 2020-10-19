import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) async {
      Batch batch = db.batch();
      batch.execute('''
        CREATE TABLE `users` (
        `id` INT NOT NULL,
        `name` VARCHAR(45) NOT NULL,
        `username` VARCHAR(45) NOT NULL,
        `password` VARCHAR(45) NOT NULL,
        `type` VARCHAR(45) NOT NULL,
        `stuffed_animal` TINYINT NULL,
        PRIMARY KEY (`ID`));
      ''');
      batch.execute('''
        CREATE TABLE `grades` (
        `studentID` INT NOT NULL,
        `grade` INT NOT NULL,
        `courseID` INT NOT NULL,
        PRIMARY KEY (`studentID`, `courseID`));
      ''');
      batch.execute('''
        CREATE TABLE `courses` (
        `id` INT NOT NULL,
        `credits` FLOAT NOT NULL,
        `name` VARCHAR(45) NOT NULL,
        `teacher` VARCHAR(45) NULL,
        PRIMARY KEY (`id`));
      ''');
      await batch.commit();

      batch = db.batch();
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('1', 'Dovid Samuels ', 'dsamuels', 'oneDayIWillMakeMyOwnEyal', 'student', '1');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('2', 'Dovid Budman', 'darkwing', 'iAmBatman', 'admin', '0');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('3', 'Saul Rothman', 'srothman', 'tieFighterRacesAreSoPredictable', 'student', '0');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('4', 'Daniel Klein', 'dklein', 'theMoonIsFlat', 'student', '1');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('5', 'Nati Yudkowski', 'nYudkowski', 'its80DegreesInAmerica', 'admin', '1');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('6', 'Jonah Lawrence', 'jlawrence', 'iPoopCode', 'admin', '0');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('7', 'Elad Harizy', 'eharizy', 'iHaveBabies', 'student', '0');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('8', 'Avraham Merciano', 'amerciano', 'noImNotEnglish', 'student', '0');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('9', 'Ezra Dweck', 'edweck', 'lol', 'student', '0');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('10', 'Yosef Berger', 'yberger', 'bergyBergy', 'admin', '1');''');
      batch.rawInsert('''INSERT INTO `users` (`ID`, `Name`, `UserName`, `Password`, `Type`, `stuffed_animal`) 
        VALUES ('11 ', 'Jack Benzaquen', 'jacques', 'theCoolKid', 'student', '0');''');
      await batch.commit();

      batch = db.batch();
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('1', '90', '1');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('1', '100', '2');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('2', '23', '3');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('2', '98', '2');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('3', '97', '1');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('4', '95', '3');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('5', '99', '2');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('6', '96', '1');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('7', '94', '2');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('8', '95', '1');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('9', '93', '3');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('10', '100', '4');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('11', '90', '4');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('3', '80', '5');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('3', '85', '3');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('4 ', '90', '2');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('4', '92', '1');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('5', '88', '5');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('6', '82', '5');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('7', '98', '4');''');
      batch.rawInsert('''INSERT INTO `grades` (`studentID`, `grade`, `courseID`) VALUES ('8', '96', '4');''');
      await batch.commit();

      batch = db.batch();
      batch.rawInsert('''INSERT INTO `courses` (`id`, `credits`, `name`, `teacher`) VALUES ('1', '4', 'calculus', 'novick');''');
      batch.rawInsert('''INSERT INTO `courses` (`id`, `credits`, `name`, `teacher`) VALUES ('2', '2.5', 'probability', 'novick');''');
      batch.rawInsert('''INSERT INTO `courses` (`id`, `credits`, `name`, `teacher`) VALUES ('3', '3', 'astrophysics', 'tyson');''');
      batch.rawInsert('''INSERT INTO `courses` (`id`, `credits`, `name`, `teacher`) VALUES ('4', '45', 'meanin_of_life', 'guru');''');
      batch.rawInsert('''INSERT INTO `courses` (`id`, `credits`, `name`, `teacher`) VALUES ('5', '2', 'discrete', 'miller');''');
      await batch.commit();

      print('initialized database');
    }, version: 1);
  }

  Future<dynamic> getUsers() async {
    final db = await database;
    List<Map> res = await db.rawQuery('''SELECT * FROM `users`''');
    return res;
  }

  Future<List<Map<String, dynamic>>> getStudentGradesByID(int studentID) async {
    final db = await database;
    List<Map> res = await db.rawQuery('''SELECT courses.name, grade, credits FROM grades JOIN courses WHERE grades.courseID=courses.id AND grades.studentID="$studentID"''');
    return res;
  }

  Future<int> getStudentAverageByID(int studentID) async {
    List<Map> courseGrades = await getStudentGradesByID(studentID);
    if (courseGrades.isEmpty) return 0;
    double sum = 0;
    double credits = 0;
    for (int i = 0; i < courseGrades.length; i++) {
      sum += courseGrades[i]['grade'] * courseGrades[i]['credits'];
      credits += courseGrades[i]['credits'];
    }
    return sum ~/ credits;
  }

  Future<int> loginAndGetUserID(String username, String password) async {
    final db = await database;
    String query = '''SELECT ID FROM users WHERE username="$username" AND password="$password";''';

    // VULNERABLE
    // List<Map> res = await db.rawQuery('''SELECT ID FROM users WHERE username="$username" AND password="$password";''');

    // SAFE
    List<Map> res = await db.rawQuery('''SELECT ID FROM users WHERE username=? AND password=?;''', [username, password]);

    //'''SELECT ID FROM users WHERE username="" OR 1=1;-- AND password="";'''
    // '''SELECT ID FROM users WHERE username="\" OR 1=1;--" AND password="";'''

    // VULNERABLE
    return res.isEmpty ? -1 : res[0]['id'];

    // SAFE
    //return res.length == 1 ? res[0]['id'] : -1;
  }

  Future<List<Map<String, dynamic>>> getCoursesByName(String courseName) async {
    final db = await database;
    return await db.rawQuery('''SELECT name, credits, teacher FROM courses WHERE name LIKE "%$courseName%"''');
    // return await db.rawQuery('''SELECT name, credits, teacher FROM courses WHERE name LIKE "%?%"''', [courseName]);
  }
}
