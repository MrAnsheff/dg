import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(fromJson)
      : id = fromJson['id'],
        deleted = fromJson['deleted'],
        type = fromJson['type'],
        by = fromJson['by'] ?? '',
        time = fromJson['time'],
        text = fromJson['text'] ?? '',
        dead = fromJson['dead'],
        parent = fromJson['parent'],
        kids = fromJson['kids'] == null ? []: fromJson['kids'],
        url = fromJson['url'],
        score = fromJson['score'],
        title = fromJson['title'],
        descendants = fromJson['descendants'];

  ItemModel.fromDb(fromDb)
      : id = fromDb['id'],
        deleted = fromDb['deleted'] == 1,
        type = fromDb['type'],
        by = fromDb['by'],
        time = fromDb['time'],
        text = fromDb['text'],
        dead = fromDb['dead'] == 1,
        parent = fromDb['parent'],
        kids = json.decode(fromDb['kids']),
        url = fromDb['url'],
        score = fromDb['score'],
        title = fromDb['title'],
        descendants = fromDb['descendants'];
  
  Map<String, dynamic> toMapForDb(){
    return {
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
      "deleted": deleted ?? 0,
      "dead": dead ?? 0,
      "kids": json.encode(kids)
    };
    
  }

}
