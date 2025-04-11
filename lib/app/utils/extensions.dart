extension Mathdo on num {
  String translateNumberToBengali() {
    const Map<String, String> numberMap = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };

    // Convert the number to a string and replace each digit
    return toString().split('').map((char) {
      return numberMap[char] ?? char; // Replace if found, otherwise keep original
    }).join();
  }
}