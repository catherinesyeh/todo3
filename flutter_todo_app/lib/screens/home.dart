import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

// home screen for todo app
class Home extends StatefulWidget {
  // stateful widget allows us to change state
  // (e.g., (un)check off todos, remove todos, etc.)
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = []; // keep track of matching search results
  String _currentQuery = ""; // keep track of current search query
  final _todoController =
      TextEditingController(); // controller allows us to add new todo items
  final _searchController =
      TextEditingController(); // controller allows us to edit search input field

  @override
  void initState() {
    // default search query on load is empty string, so match everything
    // (i.e., assign _foundTodo = todosList to start with)
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // set entire page background color to match top bar
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            // add padding around body content
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                // add elements to body
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          // pad todo list
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          // list title
                          'My Todos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // load todo items dynamically from todo model
                      // (only show items that match current search query)
                      for (Todo t in _foundTodo.reversed)
                        // reversed shows most recently added items first
                        TodoItem(
                          todo: t,
                          onTodoChanged: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            // add todo box at bottom of screen
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item...',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  // plus button next to add todo input field
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    // use controller to get current text in input field
                    // then add this as a new todo item
                    _addTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60, 65),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _addTodoItem(String todo) {
    // add new todo item to list
    setState(() {
      todosList.add(Todo(
          // generate unique id by using current time in milliseconds
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController
        .clear(); // clear todo input field once new item has been added
    _searchController.clear(); // clear search query so new item shows up
    _runFilter("");
  }

  void _runFilter(String keyword) {
    // filter todos by search query
    List<Todo> results = [];
    if (keyword.isEmpty) {
      results = todosList; // show all when empty query
    } else {
      // otherwise, add any todo items that contain query to results
      results = todosList
          .where((element) =>
              element.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      // save results to _foundTodo and keyword to _currentQuery
      _foundTodo = results;
      _currentQuery = keyword;
    });
  }

  void _deleteTodoItem(String id) {
    // remove todo item by id
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });

    _runFilter(_currentQuery); // refresh list to reflect deleted item
  }

  void _handleTodoChange(Todo todo) {
    // switch state of todo item (e.g., from not done to done or vice versa)
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  Widget searchBox() {
    return Container(
      // search bar widget
      padding: EdgeInsets.symmetric(horizontal: 15), // pad sides
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: _searchController,
        onChanged: ((value) => _runFilter(value)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            // add search icon
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            // constrain size of search bar
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none, // remove bottom border
          hintText: 'Search todos...', // placeholder
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    // styling for app bar element
    return AppBar(
      // top nav bar
      backgroundColor: tdBGColor,
      elevation: 0, // remove shadow from under bar
      title: Row(
          // space icons evenly across top bar
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              // black menu icon in top left corner
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              // profile picture in top right corner
              height: 40,
              width: 40,
              child: ClipRRect(
                // crop to circle
                borderRadius: BorderRadius.circular(20),
                // load avatar image from assets folder
                child: Image.asset('../assets/images/avatar.png'),
              ),
            ),
          ]),
    );
  }
}
