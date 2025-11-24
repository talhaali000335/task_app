
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/activity_model.dart';

class ProfileController extends GetxController {
  
  var user = User(
    name: "Ahmar Tariq",
    handle: "@CrazyDriver007",
    bio: "Burn Tyres 🌀",
    igHandle: "IG: @ahmartariq",
    profileImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=200", // Placeholder
    coverImage: "https://images.unsplash.com/photo-1617788138017-80ad40651399?auto=format&fit=crop&q=80&w=1000", // Audi styling
    followers: 55,
    following: 100,
    connections: 145,
    xp: 115,
    totalXp: 200,
  ).obs;

  // Activity List
  var activities = <Activity>[
    Activity(
        title: "URBAN APEX",
        imageUrl: "https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&q=80&w=100",
        isActive: true,
        difficulty: "Hard",
        date: "02 Oct 2025",
        time: "01:38.53"),
    Activity(
        title: "URBAN APEX",
        imageUrl: "https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&q=80&w=100",
        isActive: true,
        difficulty: "Hard",
        date: "02 Oct 2025",
        time: "01:38.53"),
    Activity(
        title: "URBAN APEX",
        imageUrl: "https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&q=80&w=100",
        isActive: true,
        difficulty: "Hard",
        date: "02 Oct 2025",
        time: "01:38.53"),
    Activity(
        title: "URBAN APEX",
        imageUrl: "https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&q=80&w=100",
        isActive: true,
        difficulty: "Hard",
        date: "02 Oct 2025",
        time: "01:38.53"),
  ].obs;

  // Text Controllers for Editing
  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void onInit() {
    super.onInit();
    initializeControllers();
  }

  void initializeControllers() {
    nameController = TextEditingController(text: user.value.name);
    bioController = TextEditingController(text: "${user.value.bio}\n${user.value.igHandle}");
  }

  void updateProfile() {
    List<String> bioParts = bioController.text.split('\n');
    String newBio = bioParts.isNotEmpty ? bioParts[0] : "";
    String newIg = bioParts.length > 1 ? bioParts[1] : "";

    user.update((val) {
      val?.name = nameController.text;
      val?.bio = newBio;
      val?.igHandle = newIg;
    });
    
    Get.back(); 
    Get.snackbar(
      "Success", 
      "Profile Updated Successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: EdgeInsets.all(16)
    );
  }
}