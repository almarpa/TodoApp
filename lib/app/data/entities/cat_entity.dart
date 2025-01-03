class Cat {
  final String fact;
  final int length;

  const Cat({required this.fact, required this.length});

  static Cat fromJson(Map<String, dynamic> json) =>
      Cat(fact: json['fact'], length: json['length']);

  Map<String, dynamic> toJson() => {
        'fact': fact,
        'length': length,
      };
}
