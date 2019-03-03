import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tasks_list/task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Task> tasks = new List();

  @override
  void initState(){
    super.initState();

  setState(() {
    tasks.add(new Task("Meeting", "Room 408", "12:30", Colors.red));
    tasks.add(new Task("Monthly Report", "Check with quality team", "14:30", Colors.purple));
    tasks.add(new Task("Call with Mike", "Discuss about release", "15:00", Colors.amber));
    tasks.add(new Task("Update", "Update website with new design", "15:30", Colors.green));
    tasks.add(new Task("Email", "Respond to Charles Email", "16:30", Colors.blue));});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
           children: <Widget>[
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                      color: Color(0xff5a348b),
                      gradient: LinearGradient(colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                        begin: Alignment.centerRight,
                        end: Alignment(-1.0, -1.0)
                    )
                  ),
                  child: _myHeaderContent(),
                ),
              ),
             Positioned(
               top: 160.0,
               left: 18.0,
               child: Container(
                 color: Colors.white,
                 width: 380.0,
                 height: MediaQuery.of(context).size.height/1.5,
                 child: ListView.builder(
                     itemCount: tasks.length,
                     itemBuilder: (context, position){
                       return Dismissible(
                           key: Key(tasks[position].toString()),
                           background: _myHiddenContainer(
                               tasks[position].status
                           ),
                           child: _myListContainer(
                             tasks[position].taskname, tasks[position].subtask, tasks[position].tasktime, tasks[position].status
                           ),
                         onDismissed: (direction){
                             if(direction == DismissDirection.startToEnd){
                               Scaffold.of(context).showSnackBar(
                                 SnackBar(content: Text("Delete")));
                               if(tasks.contains(tasks.removeAt(position))){
                                 setState(() {
                                   tasks.remove(tasks.removeAt(position));
                                 });
                               }
                             }else{
                               if(direction == DismissDirection.endToStart){
                                 Scaffold.of(context).showSnackBar(
                                   SnackBar(content: Text("Archive"))
                                 );
                                 // Archive functionality
                               }
                             }
                         },
                       );
                     }
                  ),
               ),
             ),
           ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
            showDialog(
                context: context,
              builder: (BuildContext context){
                  final taskval = TextEditingController();
                  final subval = TextEditingController();
                  final tasktime = TextEditingController();

                  Color taskcolor;

                  return AlertDialog(
                    title: Text("New Task"),
                    content: Container(
                      height: 250.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextField(
                              controller: taskval,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Task Title",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            child: TextField(
                              controller: subval,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Sub Task",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: (){
                                    taskcolor = Colors.purple;
                                  },
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    color: Colors.purple,
                                  ),
                                ),
                                new GestureDetector(
                                  onTap: (){
                                    taskcolor = Colors.amber;
                                  },
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    color: Colors.amber,
                                  ),
                                ),
                                new GestureDetector(
                                  onTap: (){
                                    taskcolor = Colors.blue;
                                  },
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    color: Colors.blue,
                                  ),
                                ),
                                new GestureDetector(
                                  onTap: (){
                                    taskcolor = Colors.green;
                                  },
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: TextField(
                              controller: tasktime,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Task Time",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                        ),
                      color: Color(0xff2da9ef),
                      child: Text("Add", style: new TextStyle(
                        color: Colors.white
                      ),),
                      onPressed: (){
                          setState(() {
                            tasks.add(new Task(taskval.text, subval.text, tasktime.text, taskcolor));
                          });
                          Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
            );
        },
        backgroundColor: Color(0xff2da9ef),
        foregroundColor: Color(0xffffffff),
        tooltip: "Increment",
        child: new Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color  (0xff2da9ef),
        shape: CircularNotchedRectangle(

        ),
        child: Row(
           mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.stickyNote),
              color: Colors.white,
              onPressed: (){

              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.search),
              color: Colors.white,
              onPressed: (){

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _myListContainer(String taskname, String subtask, String taskTime, Color taskColor){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.0,
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Color(0x802196F3),
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: 10.0,
                  color: taskColor,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(taskname, style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(subtask, style: TextStyle(
                              fontSize: 18.0, color: Colors.blueAccent)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(taskTime, style: TextStyle(
                        fontSize: 18.0, color: Colors.black45)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myHiddenContainer(Color taskColor){

    return Container(
      height: MediaQuery.of(context).size.height,
      color: taskColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.solidTrashAlt),
                  color: Colors.white,
                  onPressed: (){
                    setState(() {

                    });
                  }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.archive),
                  color: Colors.white,
                  onPressed: (){
                    setState(() {

                    });
                  }),
            ),
          ],
        ),
    );

  }
  
  Widget _myHeaderContent(){
    return Align(
      child: ListTile(
        leading: Text('26', style: TextStyle(fontSize: 50.0, color: Colors.amber)),
        title: Text("Feburary", style: TextStyle(fontSize: 34.0, color: Colors.white)),
        subtitle: Text("2019", style: TextStyle(fontSize: 24.0, color: Colors.white)),
      ),
    );
  }
}
