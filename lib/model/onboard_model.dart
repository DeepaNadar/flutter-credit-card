class onBoardModel{
  final String img;
  final String heading;
  final String description;

  onBoardModel({
    required this.img,
    required this.heading,
    required this.description,
  });

}

final boardArrayList=[
  onBoardModel(
    img: "assets/images/onBoarding1.png", 
    heading: "Your Wallet's New Best Friend", 
    description: "Welcome to a smarter way to handle your finances."
    ),
    onBoardModel(
    img: "assets/images/onBoarding2.png", 
    heading: "Elevate Your Financial Strategy", 
    description: "Simplify Money Management and Financial Wellness at Your Fingertips"
    ),
    onBoardModel(
    img: "assets/images/onBoarding3.png", 
    heading: "Experience Financial Harmony", 
    description: "Revolutionize Your Money Journey and Step into a Brighter Financial Future."
    ),
];