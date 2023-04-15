class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Workout Plans and Period Tracking',
      image: 'assets/fem_1.jpg',
      description:
          "This app offers customized workout plans based on the user's fitness level and goals. Users can choose from a variety of workout routines, including cardio, strength training, and flexibility exercises"),
  UnbordingContent(
      title: 'Personalized Meal Planning',
      image: 'assets/fem_3.jpg',
      // image: 'images/delevery.svg',
      description:
          "This app allows users to create a personalized meal plan based on their fitness goals and dietary restrictions. Users can select from a variety of healthy recipes and create a meal plan that fits their lifestyle"),
  // UnbordingContent(
  //     title: 'Nutrition Tracking',
  //     image: 'assets/images/gym3.jpg',
  //     // image: 'images/reward.svg',
  //     description:
  //         "This gym app includes a feature that allows users to track their daily nutrition intake. Users can log their meals and snacks and view a breakdown of their macronutrients (carbohydrates, proteins, and fats) and micronutrients (vitamins and minerals) intake"),
];
