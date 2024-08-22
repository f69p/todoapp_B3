import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _descriptionTEController = TextEditingController();

  List<ToDo> Todos=[];


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('TODO APP'),
        actions: [
          IconButton(onPressed: (){
            Todos.clear();
            if(mounted){
              setState(() {

              });
            }
          }, icon: Icon(Icons.playlist_remove))
        ],
      ),

      body: ListView.separated(
          itemCount: Todos.length,

          itemBuilder: (context,index){
        return ListTile(
          onLongPress: (){
            if(mounted){
              Todos[index].isDone=!Todos[index].isDone;
              setState(() {

              });
            }
          },
          leading: Todos[index].isDone?Icon(Icons.done):
          Icon(Icons.close),
          
          
            title: Text(Todos[index].title),
          subtitle: Text(Todos[index].description),
           trailing: IconButton(
             icon: Icon(Icons.delete),
             onPressed: (){
               Todos.removeAt(index);
               if(mounted){
                 setState(() {

                 });
               }
             },
           )

        );

      },
          separatorBuilder:(context,index){
            return Divider(height: 0,);
          },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNewModelsheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void showAddNewModelsheet(){
    showModalBottomSheet(context: context, builder: (context){
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Add New Todo',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      fontStyle: FontStyle.italic),
                ),
                TextField(
                  controller: _titleTEController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _descriptionTEController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleTEController.text.trim().isNotEmpty &&
                        _descriptionTEController.text.trim().isNotEmpty) {
                      Todos.add(ToDo(_titleTEController.text.trim(),
                          _descriptionTEController.text.trim(), false));
                      if (mounted) {
                        setState(() {});
                      }
                      _titleTEController.clear();
                      _descriptionTEController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          );
        });
  }
}



class ToDo{
  String title, description;
  bool isDone;

  ToDo(this.title,this.description,this.isDone);
}