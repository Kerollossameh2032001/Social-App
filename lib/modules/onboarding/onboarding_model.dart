class OnBoardingModel {
  String title;
  String body;
  String image;

  OnBoardingModel({
    required this.title,
    required this.body,
    required this.image,
  });
}

List<OnBoardingModel> pagesContents = [
  OnBoardingModel(
    title: "Social App",
    body: "Welcome in Social app, Register and communicate with friends",
    image: 'assets/images/social1.png',
  ),
  OnBoardingModel(
    title: "Interested",
    body: "Our Social app offers you a lot of interesting things to spent your time and enjoy in your spare time",
    image: 'assets/images/social2.png',
  ),
  OnBoardingModel(
    title: "Editing",
    body: "You can edit your user_profile, and update your information in an easy way",
    image: 'assets/images/social3.png',
  ),
  OnBoardingModel(
    title: "Our Services",
    body: "Also you can add an funny posts and chat with your friends and make a new friends",
    image: 'assets/images/social12.png',
  ),

  OnBoardingModel(
    title: "Notification ",
    body: "You will also receive the notification to learn about new messages",
    image: 'assets/images/social4.png',
  ),
  OnBoardingModel(
    title: "REGISTER",
    body: "Welcome to our little family, register and enjoy with us",
    image: 'assets/images/social11.png',
  ),
];
