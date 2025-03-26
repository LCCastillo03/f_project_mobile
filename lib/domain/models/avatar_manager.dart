class AvatarManager {
  // Private constructor
  AvatarManager._privateConstructor();

  // The single instance
  static final AvatarManager _instance = AvatarManager._privateConstructor();

  // Factory constructor to return the instance
  factory AvatarManager() => _instance;
  
  List<String> getAvatarPaths() {
    return List.generate(5, (index) => 'assets/images/avatars/avatar-$index.jpeg');
  }
}