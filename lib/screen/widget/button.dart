import 'package:flutter/material.dart';
import 'package:flutter_task_management/colorStyle.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget{
  final String label;
  final Function()? onTap;

  const MyButton({Key?key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffFD794F),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}