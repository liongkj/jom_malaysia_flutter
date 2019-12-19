class Tags {
  final List<String> tags;

  Tags({
    this.tags
  });

  factory Tags.fromJson(Map<String, dynamic> parsedJson) {
    var tags  = parsedJson['tags'];
    List<String> tag = new List<String>.from(tags);

    return Tags(
      tags: tag,
    );
  }

}