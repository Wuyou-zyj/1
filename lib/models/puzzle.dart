/// pieces : {"existing":["http://tohsaka.cloud/img/picture_2_1.png","http://tohsaka.cloud/img/picture_2_2.png","http://tohsaka.cloud/img/picture_2_3.png","http://tohsaka.cloud/img/picture_2_4.png",null,null,null,null,"http://tohsaka.cloud/img/picture_2_9.png","http://tohsaka.cloud/img/picture_2_10.png","http://tohsaka.cloud/img/picture_2_11.png","http://tohsaka.cloud/img/picture_2_12.png","http://tohsaka.cloud/img/picture_2_13.png","http://tohsaka.cloud/img/picture_2_14.png","http://tohsaka.cloud/img/picture_2_15.png","http://tohsaka.cloud/img/picture_2_16.png"],"unfinished":["http://tohsaka.cloud/img/picture_2_5.png","http://tohsaka.cloud/img/picture_2_6.png","http://tohsaka.cloud/img/picture_2_7.png","http://tohsaka.cloud/img/picture_2_8.png"]}
/// name : "苏州桃花坞年画"
/// id : 2
/// completed : false
/// introduction : "桃花坞年画源于宋代的雕版印刷工艺，由绣像图演变而来，到明代发展成为民间艺术流派，清代雍正、乾隆年间为鼎盛时期，每年出产的桃花坞木版年画达百万张以上。桃花坞年画的印刷兼用着色和彩套版，构图对称、丰满，色彩绚丽，常以紫红色为主调表现欢乐气氛，基本全用套色制作，刻工、色彩和造型具有精细秀雅的江南地区民间艺术风格，主要表现吉祥喜庆、民俗生活、戏文故事、花鸟蔬果和驱鬼避邪等中国民间传统审美内容。民间画坛称之为姑苏版。\n2006年5月20日，该遗产经国务院批准列入第一批国家级非物质文化遗产名录。"

class PuzzleDataList{
  List<PuzzleData?>? puzzleList;
  PuzzleDataList.fromJson(dynamic json){
    if(json is List){
      puzzleList=[];
      for (var element in json) {
        puzzleList?.add(PuzzleData.fromJson(element));
      }
    }
  }
}

class PuzzleData {

  PuzzleData({
      this.pieces, 
      this.name, 
      this.id, 
      this.completed, 
      this.introduction,
  this.picture});

  PuzzleData.fromJson(dynamic json) {
    pieces = json['pieces'] != null ? Pieces.fromJson(json['pieces']) : null;
    picture = json['picture'];
    name = json['name'];
    id = json['id'];
    completed = json['completed'];
    introduction = json['introduction'];
  }
  Pieces? pieces;
  String? name;
  num? id;
  bool? completed;
  String? introduction;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pieces != null) {
      map['pieces'] = pieces?.toJson();
    }
    map['name'] = name;
    map['id'] = id;
    map['completed'] = completed;
    map['introduction'] = introduction;
    return map;
  }

}

/// existing : ["http://tohsaka.cloud/img/picture_2_1.png","http://tohsaka.cloud/img/picture_2_2.png","http://tohsaka.cloud/img/picture_2_3.png","http://tohsaka.cloud/img/picture_2_4.png",null,null,null,null,"http://tohsaka.cloud/img/picture_2_9.png","http://tohsaka.cloud/img/picture_2_10.png","http://tohsaka.cloud/img/picture_2_11.png","http://tohsaka.cloud/img/picture_2_12.png","http://tohsaka.cloud/img/picture_2_13.png","http://tohsaka.cloud/img/picture_2_14.png","http://tohsaka.cloud/img/picture_2_15.png","http://tohsaka.cloud/img/picture_2_16.png"]
/// unfinished : ["http://tohsaka.cloud/img/picture_2_5.png","http://tohsaka.cloud/img/picture_2_6.png","http://tohsaka.cloud/img/picture_2_7.png","http://tohsaka.cloud/img/picture_2_8.png"]

class Pieces {
  Pieces({
      this.existing, 
      this.unfinished,});

  Pieces.fromJson(dynamic json) {
    existing = json['existing'] != null ? json['existing'].cast<String?>() : [];
    unfinished = json['unfinished'] != null ? json['unfinished'].cast<String?>() : [];
  }
  List<String?>? existing;
  List<String?>? unfinished;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['existing'] = existing;
    map['unfinished'] = unfinished;
    return map;
  }

}