

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_screen.dart';
import '../models/activity_model.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 50.h), 
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo(),
                      SizedBox(height: 15.h),
                      _buildIgnitionStats(),
                      SizedBox(height: 15.h),
                      _buildConnectionRow(),
                      SizedBox(height: 20.h),
                      _buildActivityList(),
                      SizedBox(height: 100.h), 
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Floating Bottom Navigation and FAB
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(),
          ),
          Positioned(
            bottom: 85.h,
            right: 20.w,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Image Container
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
            image: DecorationImage(
              image: NetworkImage(controller.user.value.coverImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      
        Container(
          height: 220.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.3), Colors.transparent],
            ),
          ),
        ),
        // Top Icons
        Positioned(
          top: 50.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15.r,
                child: Icon(Icons.question_mark_rounded, size: 12.sp, color: Colors.black),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2F40),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Text("10 TICKETS", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                        SizedBox(width: 5.w),
                        Icon(Icons.confirmation_number, color: Colors.blueAccent, size: 14.sp),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  // Icon(Icons.hexagon_outlined, color: Colors.white, size: 28.sp),
                   CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 18.r,
                child: Icon(Icons.hexagon_outlined ,size: 14.sp, color: Colors.white),
              )
                ],
              )
            ],
          ),
        ),
        // Profile Avatar
        Positioned(
          bottom: -40.h,
          left: 20.w,
          child: Hero(
            tag: 'profilePic',
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: const BoxDecoration(
                color: Color(0xFF121212), // Match background to create "cutout" effect
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 45.r,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(controller.user.value.profileImage),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.user.value.name.toUpperCase(),
                      style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      controller.user.value.handle,
                      style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  controller.user.value.bio,
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.blue[200]),
                ),
                Text(
                  controller.user.value.igHandle,
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white70),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                controller.initializeControllers(); // Reset texts before editing
                Get.to(() => EditProfileScreen());
              },
              child: Icon(Icons.edit, color: Colors.grey, size: 20.sp),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.person_outline, color: Colors.white, size: 16.sp),
            SizedBox(width: 4.w),
            Text(controller.user.value.followers.toString(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
            SizedBox(width: 15.w),
             Icon(Icons.person_outline, color: Colors.white, size: 16.sp),
            SizedBox(width: 4.w),
            Text(controller.user.value.following.toString(), style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          ],
        )
      ],
    ));
  }

  Widget _buildIgnitionStats() {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.redAccent, size: 20.sp),
              SizedBox(width: 5.w),
              Text("IGNITION", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("XP", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
              Obx(() => Text("${controller.user.value.xp}/${controller.user.value.totalXp}", style: TextStyle(color: Colors.grey, fontSize: 12.sp))),
            ],
          ),
          SizedBox(height: 8.h),
          // Custom Progress Bar
          Stack(
            children: [
              Container(
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              Obx(() => Container(
                height: 12.h,
                width: 300.w * (controller.user.value.xp / controller.user.value.totalXp),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              )),
              Positioned(
                right: 5,
                top: 0,
                bottom: 0,
                child: Row(
                  children: List.generate(4, (index) => Icon(Icons.chevron_right, size: 12.sp, color: Colors.white12)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildConnectionRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar Stack
                    SizedBox(
                      height: 30.h,
                      width: 80.w,
                      child: Stack(
                        children: [
                          _buildMiniAvatar(0, Colors.blue),
                          _buildMiniAvatar(15, Colors.green),
                          _buildMiniAvatar(30, Colors.red),
                          Positioned(left: 45, bottom: 5, child: Text("145", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp))),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text("Connections", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                  ],
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PURCHASES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    SizedBox(height: 5.h),
                    Text("View your Purchases", style: TextStyle(color: Colors.grey, fontSize: 10.sp)),
                  ],
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildMiniAvatar(double left, Color color) {
    return Positioned(
      left: left,
      child: CircleAvatar(
        radius: 12.r,
        backgroundColor: color,
        child: Icon(Icons.person, size: 15.sp, color: Colors.white),
      ),
    );
  }

  Widget _buildActivityList() {
    return Obx(() => Column(
      children: controller.activities.cast<Activity>().map((activity) => _buildActivityCard(activity)).toList(),
    ));
  }

  Widget _buildActivityCard(Activity activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(image: NetworkImage(activity.imageUrl), fit: BoxFit.cover),
              border: Border.all(color: Colors.white24)
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.grey, size: 12.sp),
                    Text(" Active ", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                    Icon(Icons.local_fire_department, color: Colors.red, size: 12.sp),
                    Text(" ${activity.difficulty}", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  ],
                ),
                Text(activity.date, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
              ],
            ),
          ),
          Text(activity.time, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70.h,
      color: Colors.black, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home_outlined, color: Colors.grey, size: 28.sp),
          Icon(Icons.leaderboard_outlined, color: Colors.grey, size: 28.sp),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10
            ),
            child: Icon(Icons.location_on_outlined, color: Colors.white, size: 28.sp),
          ),
          Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 28.sp),
          // User mini avatar
          CircleAvatar(
            radius: 14.r,
            backgroundImage: NetworkImage(controller.user.value.profileImage),
          )
        ],
      ),
    );
  }
}