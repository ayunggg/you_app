class Interest {
  int? id;
  String? interest;

  Interest({
    this.id,
    this.interest,
  });

  factory Interest.fromJson(Map<String, dynamic> json) =>
      Interest(interest: json['interests']);

  Map<String, dynamic> toJson() {
    return {
      "interest": interest,
    };
  }

  // TODO: implement props
  List<Object?> get props => [
        id,
        interest,
      ];
}
