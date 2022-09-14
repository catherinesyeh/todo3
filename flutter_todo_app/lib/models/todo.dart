// todo model
class Todo {
  // declare fields
  String? id;
  String? todoText;
  bool isDone;

  // constructor:
  // - id and text are required
  // - isDone isn't, but is default to false (unchecked)
  Todo({required this.id, required this.todoText, this.isDone = false});

  // generate list of todo items; preload with some examples
  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Go to the gym', isDone: true),
      Todo(id: '02', todoText: 'Buy groceries', isDone: true),
      Todo(id: '03', todoText: 'Check emails'),
      Todo(id: '04', todoText: 'Lab meeting'),
      Todo(id: '05', todoText: 'Work on CS279r homework for 2 hours'),
      Todo(id: '06', todoText: 'Walk the dog'),
    ];
  }
}
