import 'package:flutter/material.dart';
import 'package:flutter_task_management/screen/addTaskBar.dart';
import 'package:flutter_task_management/screen/widget/taskTile.dart';
import 'package:flutter_task_management/textStyle.dart';
import 'package:flutter_task_management/screen/widget/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';


import '../theme.dart';
import 'package:flutter_task_management/colorStyle.dart';
import 'package:flutter_task_management/screen/services/notificationService.dart';
import 'package:flutter_task_management/screen/services/theme_services.dart';
import '../controller/taskController.dart';
import '../model/task.dart';
import '../screen/addTaskBar.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  var notifyHelper;
  void initState(){
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context){

    final mq = MediaQuery.of(context).size;
    final now = new DateTime.now();

    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(DateFormat('d-M-y').format(now),
                    //Text(DateTime.now().toString(),
                    style: titleTextStyle.copyWith(fontSize: 20),
                    ),
                    Text('Today',style: kButtonTextStyle.copyWith(fontSize: 20)),
                   ],
                ),
                MyButton(label: '+ Add Task', onTap: ()async {
                  await Get.to(() => AddTaskScreen());
                  _taskController.getTasks();
                })
              ]
            ),
          ),
          _addDateBar(mq),
          SizedBox(height: 15),
          _showTask(),

        ],
      ),
    );
  }

  _addDateBar(Size mq){
    return Container(
      margin: EdgeInsets.only(top:5,left: 10,right: 10),
        child: DatePicker(
          DateTime.now(),
          height: mq.height*0.115,
          width: mq.width*0.17,
          initialSelectedDate: DateTime.now(),
          selectionColor: Color(0xffFD794F),
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          )
      ),
       dayTextStyle: GoogleFonts.poppins(
         textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey
      )
    ),
    monthTextStyle: GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.grey
      )
    ),
    onDateChange: (date){
      setState(() {
        _selectedDate = date;
      });
    },
  ));
}

_appbar(){
  return AppBar(
    backgroundColor: context.theme.backgroundColor,
    //backgroundColor: Color(0xfffD794F),
    elevation: 0,
    leading: GestureDetector(
      onTap: (){
        ThemeService().SwitchTheme();
        notifyHelper.displayNotification(
          title: "Theme Changes",
          body: Get.isDarkMode?"Activated Dark Theme":"Activated Light Theme"
        );
      },
      child: Icon(Get.isDarkMode ? Icons.sunny : Icons.mode_night,
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

 _showTask(){
  return Expanded(
    child: Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: _taskController.taskList.length,
        itemBuilder: (context,index){
          print(_taskController.taskList.length);
          Task task = _taskController.taskList[index];
          if(task.repeat == "Daily"){
            // DateTime date = DateFormat.jm().parse(task.startTime.toString());
            // var myTime = DateFormat("HH:mm").format(date);
            // notifyHelper.scheduledNotification(
            //   int.parse(myTime.toString().split(":")[0]),
            //   int.parse(myTime.toString().split(":")[1]),
            //   task
            // );
          return GestureDetector(
            onTap:(){
              _showBottomSheet(context,_taskController.taskList[index]);
            },
            child: TaskTile(_taskController.taskList[index]));
          }
          if(task.date == DateFormat.yMd().format(_selectedDate)){
          return GestureDetector(
            onTap:(){
              _showBottomSheet(context,_taskController.taskList[index]);
            },
            child: TaskTile(_taskController.taskList[index]));            
          }else{
            return Container();
          }
        });
    })
  );
}

//  _showTask(Size mq){
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: _taskController.taskList.length,
//       itemBuilder: ((context, index) => 
//       Container(
//             width: mq.width,
//             height: 50,
//             color: Colors.green,
//             margin: EdgeInsets.only(bottom: 10),
//             child: Text(
//               _taskController.taskList.toList().toString(),
//             ),
//           )
//      ) );
// }


  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted==1?MediaQuery.of(context).size.height*0.20:
        MediaQuery.of(context).size.height*0.28,
        decoration: BoxDecoration(
          color: Get.isDarkMode?ktextColor:kColor2,
        ),
        child: Column(
          children: [
            Container(height: 5,width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
            ),
            ),
            Spacer(),
            task.isCompleted==1?Container():
            _bottomSheetButton(label: "Task Compeleted", 
            onTap: (){
              _taskController.markTaskCompleted(task.id!);
              _taskController.getTasks(); 
              Get.back();
            }, 
            clr:Color(0xfffbc2eb),
            context: context,
           ),
           SizedBox(height: 12),
            _bottomSheetButton(label: "Delete Task", 
            onTap: (){
              _taskController.delete(task);
              Get.back();
            }, 
            clr:Color(0xffffb199),
            context: context,
           ),
           SizedBox(height: 12),
            _bottomSheetButton(label: "Close", 
            onTap: (){
              Get.back();
            }, 
            clr:kColor2,
            context: context,
            isClose: true,
           ),            
          ],
        ),
      )
    );
  }
  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          color: isClose==true?kColor2:clr,
          border:Border.all(
            width: 2,
            color: isClose==true?kColor2:clr
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(label,
          style: isClose?kTextStyle2.copyWith(color: Colors.black):kTextStyle2.copyWith(color: Colors.white),
          )),
      ),  
    );
  }
}