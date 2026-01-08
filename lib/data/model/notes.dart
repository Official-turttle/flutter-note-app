class Note {
  final String id;
  final String title;
  final String content;
  final String userId;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
  });

  factory Note.fromJson(Map<String, dynamic> json, String documentId) {
    return Note(
      id: documentId,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'userId': userId,
    };
  }

  void printNote() {
    print("ID: $id");
    print("Title: $title");
    print("Content: $content");
    print("User ID: $userId");
  }

  // Override toString() method to make it easy to print the entire note as a string
  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, userId: $userId}';
  }
}
