
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  _buildTextField(
                    "Full Name",
                    controller.nameController,
                    Icons.person,
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    "Bio",
                    controller.bioController,
                    Icons.email,
                    maxLines: 3,
                  ),
                 SizedBox(height: 300.h,),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateProfile();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250.r),
                        ),
                      ),
                      child: Text(
                        "UPDATE",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(controller.user.value.coverImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.4),
          ),
        ),
        // Nav Icons
        Positioned(
          top: 50.h,
          left: 20.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 28.sp),
          ),
        ),
        Positioned(
          top: 50.h,
          right: 20.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.close, color: Colors.white, size: 28.sp),
          ),
        ),
        Positioned(
          bottom: -50.h, // Half out
          left: 20.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                tag: 'profilePic',
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFF121212),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundImage: NetworkImage(controller.user.value.profileImage),
                  ),
                ),
              ),
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_upward, color: Colors.white, size: 30.sp),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController textController, IconData icon, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: Colors.black, size: 16.sp),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(label, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                  TextField(
                    controller: textController,
                    maxLines: maxLines,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}