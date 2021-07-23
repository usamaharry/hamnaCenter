import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import './models/student.dart';
import './widgets/frontImage.dart';
import './widgets/studentsList.dart';
import './widgets/newStudent.dart';
import 'drawer.dart';
import 'filters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'Quicksand', fontSize: 20),
              ),
        ),
      ),
      home: MyHomePage(true),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isToLoadData;

  MyHomePage(this.isToLoadData);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  List<Student> students = [];

  List<Student> temp = [];

  void initState() {
    super.initState();
    if (widget.isToLoadData) loadData();
  }

  Future<void> loadData() async {
    students.clear();
    temp.clear();
    Future.delayed(Duration(seconds: 0), () async {
      final url = Uri.https(
          'hamna-318cb-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/students.json');

      setState(() {
        _isLoading = true;
      });

      http.Response response = await http.get(url);

      setState(() {
        _isLoading = false;
      });

      var data = json.decode(response.body) as Map<String, dynamic>;

      data.forEach((key, value) {
        setState(() {
          students.add(Student(
              id: key,
              program: value['program'],
              name: value['name'],
              fatherName: value['fatherName'],
              phone: value['phone'],
              address: value['address'],
              qualification: value['qualification'],
              neeyat: value['niyat'],
              previousInstitute: value['lastInstitute'],
              refernce: value['reference'],
              dateOfJoining: value['doj']));

          temp.add(Student(
              id: key,
              program: value['program'],
              name: value['name'],
              fatherName: value['fatherName'],
              phone: value['phone'],
              address: value['address'],
              qualification: value['qualification'],
              neeyat: value['niyat'],
              previousInstitute: value['lastInstitute'],
              refernce: value['reference'],
              dateOfJoining: value['doj']));
        });
      });
    });
  }

  void addNewStudent(
      String program,
      String name,
      String fatherName,
      String phone,
      String address,
      String qualification,
      String niyat,
      String lastInsti,
      String ref,
      String doj) async {
    final url = Uri.https(
        'hamna-318cb-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/students.json');

    setState(() {
      _isLoading = true;
    });
    await http
        .post(url,
            body: json.encode({
              'program': program,
              'name': name,
              'fatherName': fatherName,
              'phone': phone,
              'address': address,
              'qualification': qualification,
              'niyat': niyat,
              'lastInstitute': lastInsti,
              'reference': ref,
              'doj': doj
            }))
        .then((value) {
      print(json.decode(value.body)['name']);
      setState(
        () {
          students.add(
            Student(
                id: json.decode(value.body)['name'],
                program: program,
                name: name,
                fatherName: fatherName,
                phone: phone,
                address: address,
                qualification: qualification,
                neeyat: niyat,
                previousInstitute: lastInsti,
                refernce: ref,
                dateOfJoining: doj),
          );

          temp.add(
            Student(
                id: json.decode(value.body)['name'],
                program: program,
                name: name,
                fatherName: fatherName,
                phone: phone,
                address: address,
                qualification: qualification,
                neeyat: niyat,
                previousInstitute: lastInsti,
                refernce: ref,
                dateOfJoining: doj),
          );
        },
      );
      setState(() {
        _isLoading = false;
      });
    });

    filterData(isOneYear, isTwoYear);
  }

  bool isOneYear = true;
  bool isTwoYear = true;

  void filterData(bool oneYear, bool twoYear) {
    isOneYear = oneYear;
    isTwoYear = twoYear;
    setState(() {
      students.clear();

      temp.forEach((element) {
        if (oneYear && element.program == 'One-Year') students.add(element);

        if (twoYear && element.program == 'Two-Year') students.add(element);
      });
    });
  }

  void _deleteStudent(String id) async {
    final url = Uri.https(
        'hamna-318cb-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/students/$id.json');
    http.Response response;

    try {
      setState(() {
        _isLoading = true;
      });

      response = await http.delete(url);
      if (response.statusCode == 200) {
        setState(() {
          students.removeWhere((element) {
            return element.id == id;
          });
          temp.removeWhere((element) {
            return element.id == id;
          });
          _isLoading = false;
        });
      }
    } catch (e) {}
    filterData(isOneYear, isTwoYear);
  }

  void _addNewContact(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return AddNewStudent(addNewStudent);
        },
      ),
    );
  }

  List<Student> sortData() {
    int min = 0;
    Student temp;

    for (int i = 0; i < students.length; i++) {
      min = i;
      for (int j = i + 1; j < students.length; j++)
        if (students[min].name.codeUnitAt(0) > students[j].name.codeUnitAt(0))
          min = j;

      temp = students[i];
      students[i] = students[min];
      students[min] = temp;
    }

    return students;
  }

  Future<void> _referesh() async {
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('Hamna Center Haroonabad'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          icon: Icon(Icons.person_add_alt),
          onPressed: () => _addNewContact(context),
        ),
      ],
    );

    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      drawer: MainDrawer(
          appBar.preferredSize.height, filterData, isOneYear, isTwoYear),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _referesh(),
              child: ListView(
                children: [
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        1,
                    width: mediaQuery.size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.02,
                        ),
                        Container(
                          width: mediaQuery.size.width / 2,
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.3,
                          child: FrontImage(),
                        ),
                        SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.02,
                        ),
                        Container(
                          width: mediaQuery.size.width,
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.66,
                          child: StudentsList(sortData(), _deleteStudent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
