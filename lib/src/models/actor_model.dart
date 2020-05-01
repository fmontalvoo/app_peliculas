class ActorModel {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  ActorModel({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "gender": gender,
        "id": id,
        "name": name,
        "order": order,
        "profile_path": profilePath,
      };

  getProfilePath() {
    if (profilePath != null)
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png';
  }
}
