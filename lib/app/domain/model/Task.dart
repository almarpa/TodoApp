class Task {
  Task(this.title, {this.done = false});

  late final String title;
  late bool done;

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }
}
