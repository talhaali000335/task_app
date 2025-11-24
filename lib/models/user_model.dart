
class User {
  String name;
  String handle;
  String bio;
  String igHandle;
  String profileImage;
  String coverImage;
  int followers;
  int following;
  int connections;
  int xp;
  int totalXp;

  User({
    required this.name,
    required this.handle,
    required this.bio,
    required this.igHandle,
    required this.profileImage,
    required this.coverImage,
    required this.followers,
    required this.following,
    required this.connections,
    required this.xp,
    required this.totalXp,
  });
}