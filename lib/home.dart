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

GlobalKey<FormState>todoFrom=GlobalKey<FormState>();
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
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        
        builder: (context){

          return Padding(
            padding: EdgeInsets.all(16),

            child: Form(
               key: todoFrom,
              child: Column(

                children: [
                  Text(
                    'Add New Todo',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        fontStyle: FontStyle.italic),
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value){
                     if(value?.trim().isEmpty??true){
                       return 'Please enter your title';
                     }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String?value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (todoFrom.currentState!.validate()) {
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