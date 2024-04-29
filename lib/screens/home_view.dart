import 'package:advanced_to_do_app/components/app_text_btn.dart';
import 'package:advanced_to_do_app/components/bottom_sheet_btn.dart';
import 'package:advanced_to_do_app/components/task_tile.dart';
import 'package:advanced_to_do_app/controllers/task_controller.dart';
import 'package:advanced_to_do_app/models/tesk_model.dart';
import 'package:advanced_to_do_app/screens/add_task_bar.dart';
import 'package:advanced_to_do_app/services/theme_service.dart';
import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(height: 10,),
          _showTasks()
        ]
      ),
    );
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: const Icon(Icons.nightlight_round),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.person),
        )
      ],
    );
  }

  _addTaskBar(){
    return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().format(DateTime.now()), style: subHeadingStyle,),
                    Text("Today", style: headingStyle,)
                  ],
                ),
                AppTextBtn(
                  lable: '+ Add Task', 
                  onTap: () async{
                    Get.to(AddTaskView());
                    _taskController.getTasks();
                  },
          )
        ],
      ),
    );
  }

  _addDateBar(){
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryclr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          ),
        ),
      onDateChange: (selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      },
      ),
    );
  }

  _showTasks(){
    _taskController.getTasks();
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (context, index) {
            final task = _taskController.taskList[index];
            if (task.repeat == "Daily"){
              return AnimationConfiguration.staggeredList(
                position: index, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task: task),
                        )
                      ],
                    ),
                  )
                )
              );
            }
            if(task.date == DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                position: index, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task: task),
                        )
                      ],
                    ),
                  )
                )
              );
            }else{
              return Container();
            }
          }
        );
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        width: MediaQuery.of(context).size.width,
        height: task.isCompleted == 1 ? 
          MediaQuery.of(context).size.height * 0.24 :
          MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? darkGreyClr : Colors.grey[300]
              ),
            ),
            const Spacer(),
           task.isCompleted == 1 ?
           Container() :
           BottomSheetBtn(
              isClose: false,
              color: primaryclr, 
              lable: "Task Compleated",
               onTap: () {
                _taskController.markTaskCompleted(task.id!);
                Get.back();
               }
            ),
            BottomSheetBtn(
              isClose: false,
              color: Colors.red.shade300, 
              lable: "Delete Task",
               onTap: () {
                _taskController.delete(task);
                Get.back();
               }
            ),
            const SizedBox(height: 20,),
            BottomSheetBtn(
              isClose: true,
              color: Colors.white, 
              lable: "Close",
               onTap: () {
                Get.back();
               }
            ),
             const SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}

