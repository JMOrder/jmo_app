class BottomNavigationState {
  int currentIndex;
  int previousIndex;

  BottomNavigationState() {
    this.currentIndex = 0;
    this.previousIndex = 0;
  }

  void to(int nextIndex) {
    this.previousIndex = this.currentIndex;
    this.currentIndex = nextIndex;
  }
}
