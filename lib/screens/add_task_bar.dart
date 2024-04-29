import 'package:advanced_to_do_app/components/app_input_field.dart';
import 'package:advanced_to_do_app/components/app_text_btn.dart';
import 'package:advanced_to_do_app/controllers/task_controller.dart';
import 'package:advanced_to_do_app/models/tesk_model.dart';
import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat.Hm().format(DateTime.now());
  String _endTime = "9:00";
  int _selectedRemind = 5;
  int _selectedColorIndex = 0;
  String _selectedRepeat = "None";
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  List<int> remindList = [
    5,
    10,
    15,
    20
  ];
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "MonthLy"
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task", style: headingStyle,),
              AppInputField(
                hint: "Enter your Title", 
                title: "Title", 
                controller: _titleController, 
                widget: null,
                ),
              const SizedBox(height: 10,),
              AppInputField(
                hint: "Enter your Note", 
                title: "Note", 
                controller: _noteController, 
                widget: null,
                ),
              const SizedBox(height: 10,),
              AppInputField(
                hint: DateFormat.yMd().format(_selectedDate), 
                title: "Date", 
                controller: TextEditingController(), 
                widget: IconButton(
                  onPressed: () => _getDateFromUser(), 
                  icon: Icon(Icons.calendar_today_outlined, color: Colors.grey,)
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                    hint: _startTime, 
                    title: "Start Time",
                    controller:  TextEditingController(), 
                    widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true), 
                        icon: const Icon(Icons.access_time_rounded, color: Colors.grey,)
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                  Expanded(
                    child: AppInputField(
                    hint: _endTime, 
                    title: "End Time",
                    controller:  TextEditingController(), 
                    widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false), 
                        icon: const Icon(Icons.access_time_rounded, color: Colors.grey,)
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              AppInputField(
                  hint: "${_selectedRemind} minutes early", 
                  title: "Remind", 
                  controller: TextEditingController(), 
                  widget: DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,), 
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      items:remindList.map<DropdownMenuItem<String>>((int value){
                        return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                      );
                    }
                  ).toList()
                ),
              ),
              const SizedBox(height: 10,),
              AppInputField(
                  hint: _selectedRepeat, 
                  title: "Repeat", 
                  controller: TextEditingController(), 
                  widget: DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,), 
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      items:repeatList.map<DropdownMenuItem<String>>((String? value){
                        return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value!, ),
                      );
                    }
                  ).toList()
                ),
              ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallet(),
                  AppTextBtn(
                    lable: "Create Task", 
                    onTap: () => _validateDate()
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      TaskController().addTask(task: Task(
          title: _titleController.text, 
          note: _noteController.text, 
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime, 
          endTime: _endTime,
          color: _selectedColorIndex, 
          remind: _selectedRemind, 
          repeat: _selectedRepeat
         )
      );
      Get.back();
    }else{
        Get.snackbar("Required", "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning_amber_outlined, color: pinkClr,),
      );
    }
  }

  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2100)
    );

    if (_pickerDate != null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }else{
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = '${pickedTime.hour}:${pickedTime.minute}';
        } else {
          _endTime = '${pickedTime.hour}:${pickedTime.minute}';
        }
      });
    } else {
      print("Time canceled");
    }
  }

  _showTimePicker(){
    return showTimePicker(
      context: context, 
      initialEntryMode: TimePickerEntryMode.inputOnly,
      initialTime: const TimeOfDay(
        hour: 9, 
        minute: 10
      )
    );
  }

  _colorPallet(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: titleStyle,),
        Row(
          children: [
            Wrap(
              children: List<Widget>.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColorIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0 ? primaryclr : index == 1 ? pinkClr : yellowlr,
                      child: _selectedColorIndex == index ? const Icon(Icons.done, color: Colors.white, size: 16,) : Container(),
                    ),
                  ),
                );
              }),
            )
          ],
        )
      ],
    );
  }
}

