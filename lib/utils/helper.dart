class MyHelper{
  static String mapStringToImage(String input){
    String name = "";

    switch(input){
      case "sn":
        name = "snow";
        break;
      case "lr":
        name = "rain";
        break;
      case "lc":
        name = "cloud";
        break;
      case "hc":
        name = "sun";
        break;
      case "c":
        name = "sun";
        break;
      case "hr":
        name = "clear";
        break;
      case "t":
        name = "thunder";
        break;
      default:
        name  = "clear";
    }
    return name;
  }
}