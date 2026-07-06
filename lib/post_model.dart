class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});
  // Factory constructor to create a Post instance from JSON data
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }
}
