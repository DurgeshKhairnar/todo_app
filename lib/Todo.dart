import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Demo {
  String? title;
  String? discription;
  String? date;

  Demo({
    required this.title,
    required this.discription,
    required this.date,
  });
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController DiscriptionController = TextEditingController();
  TextEditingController DateController = TextEditingController();

  List<Demo> todo = [

  ];

  void submit(bool edit, [int? index]) {
    if (titleController.text.trim().isNotEmpty &&
        DiscriptionController.text.trim().isNotEmpty &&
        DateController.text.trim().isNotEmpty) {
      if (edit) {
       todo[index!].title = titleController.text;
       todo[index].discription = DiscriptionController.text;
       todo[index].date = DateController.text;
      } else {
        todo.add(Demo(
          title: titleController.text,
          discription: DiscriptionController.text,
          date: DateController.text,
        ));
      }
    }
    Navigator.of(context).pop();
    Clear();
    setState(() {});
  }

  List<Color> colorList = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(250, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1)
  ];
  void Clear() {
    titleController.clear();
    DiscriptionController.clear();
    DateController.clear();
  }

  void Showbottomsheet(bool edit,[int? index]) {
   
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 120),
                    Text("Create Todo", style: TextStyle(fontSize: 25))
                  ],
                ),
                const Text("Title"),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Discription"),
              SizedBox(
               height: 100,
                 child:TextField(
                  controller: DiscriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Date"),
                TextField(
                  controller: DateController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: const Icon(Icons.calendar_month_outlined)),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2025));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat.yMMMd().format(pickedDate);
                      setState(() {
                        DateController.text = formattedDate;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if(edit){
                      submit(true,index);
                      }else{
                        submit(false);
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(0,139,148,1),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-do App",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w600,
            fontSize: 25,
           
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: ListView.builder(
          itemCount: todo.length,
          itemBuilder: (context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorList[index % colorList.length],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: const Icon(Icons.image),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo[index].title!,
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    todo[index].discription!,
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color:
                                          const Color.fromRGBO(84, 84, 84, 1),
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                todo[index].date!,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color.fromRGBO(132, 132, 132, 1),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                       titleController.text = todo[index].title!;
                                        DiscriptionController.text = todo[index].discription!;
                                        DateController.text = todo[index].date!;
                                      Showbottomsheet(true,index);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    color: Color.fromRGBO(0, 139, 148, 1),
                                  )),
                              const SizedBox(width: 10),
                              GestureDetector(
                                  onTap: () {
                                    todo.removeAt(index);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.delete_outlined,
                                      color: Color.fromRGBO(0, 139, 148, 1))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        
          Showbottomsheet(false);
        },
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
