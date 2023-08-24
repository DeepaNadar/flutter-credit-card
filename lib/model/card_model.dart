class CardModel {
  final String category;
  final String name;
  final String cardExpiration;
  final String cardHolder;
  final String cardNumber;
  final String id;

  CardModel({
    required this.category,
    required this.name,
    required this.cardExpiration,
    required this.cardHolder,
    required this.cardNumber,
    required this.id,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      category: json['category'],
      name: json['name'],
      cardExpiration: json['cardExpiration'],
      cardHolder: json['cardHolder'],
      cardNumber: json['cardNumber'],
      id: json['id'],
    );
  }

  factory CardModel.newCardForApi({
    required String category,
    required String name,
    required String cardExpiration,
    required String cardHolder,
    required String cardNumber,
  }) {
    return CardModel(
      category: category,
      name: name,
      cardExpiration: cardExpiration,
      cardHolder: cardHolder,
      cardNumber: cardNumber,
      id: 'dummy_id',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "cardExpiration": cardExpiration,
      "cardHolder": cardHolder,
      "cardNumber": cardNumber,
      "category": category,
    };
  }
}
