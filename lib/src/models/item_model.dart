import 'dart:convert';

class ItemModel {
  final int id; //The item's unique id.
  final bool deleted; //true if the item is deleted.
  final String
      type; //The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  final String by; //The username of the item's author.
  final int time; //Creation date of the item, in Unix Time.
  final String text; //The comment, story or poll text. HTML.
  final bool dead; //true if the item is dead.
  final int
      parent; //The comment's parent: either another comment or the relevant story.
  final List<dynamic>
      kids; //The ids of the item's comments, in ranked display order.
  final String url; //The URL of the story.
  final int score; //The story's score, or the votes for a pollopt.
  final String title; //The title of the story, poll or job.
  final int descendants; //

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'] ?? '',
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
