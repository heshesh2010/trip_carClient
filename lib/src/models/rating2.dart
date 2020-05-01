class Rate {
  int id;
  String review;
  double rate;
  int userId;
  String foodId;
  String createdAt;
  String updatedAt;
  String message;
  Rate({
    this.id,
    this.review,
    this.rate,
    this.userId,
    this.foodId,
    this.createdAt,
    this.updatedAt,
  });

  factory Rate.fromMap(Map<String, dynamic> json) => Rate(
        id: json["id"],
        review: json["review"],
        rate: json["rate"],
        userId: json["user_id"],
        foodId: json["food_id"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "review": review,
        "rate": rate,
        "food_id": foodId,
      };
}
