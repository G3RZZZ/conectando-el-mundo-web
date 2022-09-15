import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/Diary.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/services/service.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MyMainPage> {
  String? _dropDownText;
  DateTime selectedDate = DateTime.now();
  var userDiaryFilteredEntriesList;

  @override
  Widget build(BuildContext context) {

    TextEditingController _titleTextController = TextEditingController();
    TextEditingController _descriptionTextController = TextEditingController();
    var _listOfDiaries = Provider.of<List<Diary>>(context);
    // var _user = Provider.of<User?>(context);
    var latestFilteredDiariesStream;
    var earliestFilteredDiariesStream;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 100,
        elevation: 4,
        title: Row(children: [
          Text(
            'Diary',
            style: TextStyle(fontSize: 39, color: Colors.blueGrey.shade400),
          ),
          Text(
            'Book',
            style: TextStyle(fontSize: 39, color: Colors.purple),
          )
        ],),
        actions: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                items: <String>['Latest','Earliest'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value, 
                    style: TextStyle(color: Colors.grey),
                  ));
              }).toList(),
              hint: (_dropDownText == null) 
              ? Text('Select') 
              : Text(_dropDownText!),
              onChanged: (value) {
                if (value == 'Latest') {
                  setState(() {
                    _dropDownText = value;
                  });
                  _listOfDiaries.clear();
                }else if (value == 'Earliest') {
                  setState(() {
                    _dropDownText = value;
                  });
                }
              },
              ),
            ),
            //TODO: create profile
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Expanded(child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      )),
                      Text('Gerardo', style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined, size: 19, color: Colors.red,))
                ],
              ),
            )
          ],)
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  right: BorderSide(width: 0.4, color: Colors.blueGrey)
                )
              ),
              //color: Colors.green,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: SfDateRangePicker(
                      onSelectionChanged: (dateRangePickerSelection) {
                        print(dateRangePickerSelection.value.toString());
                      },
                      ),  
                  ),
                  Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Card(
                      elevation: 4,
                      child: TextButton.icon(onPressed: () {}, icon: Icon(Icons.add, size: 40, color: Colors.purpleAccent,), label: Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0), 
                        child: Text('Write New', style: TextStyle(fontSize: 17),),
                        ),)),
                    ))
                ]
              ),
            )),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(child: Container(
                    child: Column(
                      children: [
                        Expanded(child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Card(
                                elevation: 4,
                                child: ListTile(
                                  title: Text('Hello'),
                                ),
                              ),
                            );
                          },
                        ),)
                      ],
                    ),
                  ),)
                ],
              ),
            ))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
      {},
      tooltip: 'Add',
      child: Icon(
        Icons.add,
      ),),
    );
  }
}

