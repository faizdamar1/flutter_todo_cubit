class TodoModel {
  String todoMessage;
  bool isComplete;
  int id;

  TodoModel.fromJson(Map json)
      : todoMessage = json["todo"],
        isComplete = json["isComplete"] == "true",
        id = json["id"] as int;
}
