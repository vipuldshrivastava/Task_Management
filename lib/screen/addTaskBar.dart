import 'package:flutter/material.dart';
import 'package:flutter_task_management/colorStyle.dart';
import 'package:flutter_task_management/controller/taskController.dart';
import 'package:flutter_task_management/screen/widget/button.dart';
import 'package:flutter_task_management/screen/widget/inputfield.dart';
import 'package:flutter_task_management/textStyle.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/task.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm:a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
    25,
  ];

    String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(context),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Add Task',style: kTextStyle3.copyWith(fontSize: 20)),
              MyInputField(title: "Title", hint: "Enter Your Title",controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter Your Note",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                onPressed: (){
                _getDateFromuser();
                },
                icon: Icon(Icons.calendar_month_outlined),
              ),
              ),
              Row(
                children: [
                  Expanded(child: MyInputField(
                    title: "start Time",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimefromUser(isStartTime: true);
                      },
                      icon: Icon(Icons.access_time,color: Colors.grey,),
                    ),
                  )),
                  SizedBox(width: 10),
                    Expanded(child: MyInputField(
                    title: "End Time",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimefromUser(isStartTime: false);
                      },
                      icon: Icon(Icons.access_time,color: Colors.grey,),
                    ),
                  ))
                ],
              ),
              MyInputField(title: "Remind", 
              hint: "$_selectedRemind min early",
              widget:DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: kTextStyle3.copyWith(color: Colors.black),
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                } 
              ).toList(), 
              )),
                MyInputField(title: "Repeat", 
              hint: "$_selectedRepeat",
              widget:DropdownButton(
                icon: Icon(Icons.repeat_on_outlined,color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: kTextStyle3.copyWith(color: Colors.black),
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String? value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!,style: TextStyle(color: Colors.black),),
                  );
                } 
              ).toList(), 
              )),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 _colorPallete(),
                 MyButton(label: "create Task", 
                 onTap: (){
                  _validatedate();
                 })
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
  _appbar(BuildContext context){
  return AppBar(
    backgroundColor: context.theme.backgroundColor,
    elevation: 0,
    leading: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Icon(Icons.arrow_back,
      size: 15,
      color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    ),
    actions: [
      Icon(Icons.person,size: 18),
      SizedBox(width:20),
    ],
  );
}
_getDateFromuser() async {
  DateTime? _pickerDate = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2001), 
    lastDate: DateTime(2099),
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }else{
      print("It's null or something is wrong");
    }
}

 _getTimefromUser({required bool isStartTime}) async {
  var pickedTime = await _showTimepicker();
  String _formatedTime = pickedTime.format(context);
  if(pickedTime==null){
    print("Time Cancelled");
  }else if(isStartTime == true){
    setState(() {
      _startTime = _formatedTime;
    });
  }else if(isStartTime == false){
    setState(() {
    _endTime = _formatedTime;
    });
  }
 }
 _showTimepicker(){
  return showTimePicker(context: context, 
  initialEntryMode: TimePickerEntryMode.input,
  initialTime: TimeOfDay(
    hour:int.parse(_startTime.split(":")[0]),
    minute: int.parse(_endTime.split(":")[1].split(" ")[0])),
  );
 }

 _colorPallete(){
  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color',style: kTextStyle2),
                      SizedBox(height: 6),
                      Wrap(
                        children: List<Widget>.generate(
                          3, 
                          (int index) {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selectedColor = index;
                                  print("$index");
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: (
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: index == 0?Color(0xffFD794F):index==1?Colors.pink:Colors.deepPurpleAccent,
                                    child: _selectedColor==index?Icon(Icons.done,
                                    color: Colors.white,
                                    ):Container(),
                                  )
                                ),
                              ),
                            );
                          },
                      ))
                    ],
                  );
 }

 _validatedate(){
  if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
    _addTaskToDB();     //add to database
    Get.back();
  }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
    Get.snackbar("Required", "All fields are required",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Color(0xffFD794F),
    icon: Icon(Icons.warning_amber_rounded),
    );
  }
 }

 _addTaskToDB() async{
   var value = await _taskController.addTask(
    task: Task(
    note: _noteController.text,
    title: _titleController.text,
    date: DateFormat.yMd().format(_selectedDate),
    startTime: _startTime,
    endTime: _endTime,
    remind: _selectedRemind,
    repeat: _selectedRepeat,
    color: _selectedColor,
    isCompleted: 0,
  )
  );
  print("My ID is "+" $value");
 }

}
