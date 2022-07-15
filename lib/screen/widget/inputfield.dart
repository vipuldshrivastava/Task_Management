import 'package:flutter/material.dart';
import 'package:flutter_task_management/textStyle.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {


    final String title;
    final String hint;
    final TextEditingController ? controller; 
    final Widget? widget;
    MyInputField({
      Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
    }): super(key:key);

  @override
  Widget build(BuildContext context) {

    final mq = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: kTextStyle3.copyWith(fontSize: 16)),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 7),
            height: mq.height*0.065,
            width: mq.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[400]:Colors.grey[700],
                    //cursorColor: Get.isDarkMode?Colors.blue[400]:Colors.red[700],
                    controller: controller,
                    style: kTextStyle5.copyWith(color:Colors.grey,fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: kTextStyle5,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0
                        )
                      ),
                  ),
                          ),
                ),
                widget == null? Container():Container(child: widget,)
              ],
            ),),
          ],
      ),
    );
  }
}