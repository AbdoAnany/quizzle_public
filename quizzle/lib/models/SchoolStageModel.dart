class SchoolStageModel {
  late int id;
  late String name;
  late String des;
  late  String image;
  late int color;
  late String type;
  late List<SchoolStageModel> studyYearLevel;

  SchoolStageModel(
      {required this.id,required this.name, required this.des, required this.image,required  this.color, required this.type,this.studyYearLevel=const []});

  SchoolStageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    des = json['des'];
    image = json['image'];
    color = json['color'];
    type = json['type'];
    studyYearLevel = json['studyYearLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['des'] = this.des;
    data['image'] = this.image;
    data['color'] = this.color;
    data['type'] = this.type;
    data['studyYearLevel'] = this.studyYearLevel.map((e) => e.toJson()).toList();
    return data;
  }
}
