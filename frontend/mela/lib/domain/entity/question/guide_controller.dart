class GuideController{
  final String title;
  // final void Function() handler;
  final String guide;

  bool isCalled = false;
  GuideController({
    required this.guide, required this.title});

  void changeState(){
    if (!isCalled) {
      isCalled = true;
    }
  }

  void resetState(){
    isCalled = false;
  }
}