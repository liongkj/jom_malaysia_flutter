class Tags {
  final String tags;

  Tags({
    this.tags
  });

  factory Tags.fromJson(List<String> parsedJson) {
    //List<String> tagList = new List<String>.from(parsedJson);
    List<String> tagList = parsedJson.cast<String>();
    var tags = tagList.toString().replaceAll ("[", "").replaceAll("]", "");
    return Tags(
      tags: tags.toString(),
    );
  }

}