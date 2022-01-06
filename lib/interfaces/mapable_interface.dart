abstract class MapableInterface {
  MapableInterface();
  MapableInterface.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap() => {};
}
