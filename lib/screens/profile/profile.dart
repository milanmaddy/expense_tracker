// profile_controller.dart
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';
import 'package:teen_tigada/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final themeController = Get.find<ThemeController>();
  final userController = Get.find<UserController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor = isDark ? AppColors.blackBackground : AppColors.backgroundFill;
      final cardColor = isDark ? AppColors.darkSurface : Colors.white;
      final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
      final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;

      return Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            // Gradient Background
            Container(
              height: size.height * 0.22,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: isDark
                      ? [AppColors.blackBackground, AppColors.blueDarkPrimary]
                      : [AppColors.royalBlue, AppColors.bluePrimary],
                ),
              ),
            ),

            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Header
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OutfitText(
                                  text: "Your Profile",
                                  fontSize: isSmall ? 24 : 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 4),
                                OutfitText(
                                  text: "Personalize your profile",
                                  fontSize: isSmall ? 14 : 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {
                                // Settings action
                              },
                              borderRadius: BorderRadius.circular(12),
                              splashColor: Colors.white.withOpacity(0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: isSmall ? 22 : 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Profile Content
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Profile Picture with Animation
                            const SizedBox(height: 30),
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: _buildProfilePicture(isDark, isSmall),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // User Name
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: OutfitText(
                                text: userController.currentUser.value.name ?? 'User',
                                fontSize: isSmall ? 24 : 28,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Member Since
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: OutfitText(
                                  text: "Flutter Developer",
                                  fontSize: isSmall ? 12 : 13,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Profile Info Card
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: _buildProfileInfo(
                                  isDark,
                                  cardColor,
                                  textColor,
                                  subTextColor,
                                  isSmall,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Edit Profile Button
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomButton(
                                  text: "Edit Profile",
                                  onTap: () {
                                    // Navigate to edit profile
                                  },
                                  borderRadius: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProfilePicture(bool isDark, bool isSmall) {
    final user = userController.currentUser.value;
    final radius = isSmall ? 80.0 : 100.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer gradient ring
        Container(
          width: radius * 2.02 + 12,
          height: radius * 2.02 + 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [AppColors.blueDarkPrimary, AppColors.blackBackground]
                  : [AppColors.bluePrimary, AppColors.royalBlue],
            ),
          ),
        ),

        // White ring
        CircleAvatar(
          radius: radius + 2.5,
          backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        ),

        // Profile Image
        CircleAvatar(
          radius: radius,
          backgroundImage: user.profileUrl != null
              ? NetworkImage(user.profileUrl!)
              : null,
          child: user.profileUrl == null
              ? Icon(
            Icons.person,
            size: radius,
            color: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
          )
              : null,
        ),

        // Edit Button with Splash Effect
        Positioned(
          right: 0,
          bottom: isSmall ? 20 : 25,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [AppColors.blueDarkPrimary, AppColors.blackBackground]
                      : [AppColors.bluePrimary, AppColors.royalBlue],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary)
                        .withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Handle profile picture edit
                    _showImagePickerDialog();
                  },
                  borderRadius: BorderRadius.circular(100),
                  splashColor: Colors.white.withOpacity(0.3),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: isSmall ? 22 : 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(
      bool isDark,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      bool isSmall,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutfitText(
              text: "Personal Information",
              fontSize: isSmall ? 18 : 20,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            const SizedBox(height: 24),
            _buildInfoRow(
              icon: Icons.person_outline,
              label: "Name",
              value: userController.currentUser.value.name ?? 'N/A',
              isDark: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
              isSmall: isSmall,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.email_outlined,
              label: "Email",
              value: userController.currentUser.value.email ?? 'N/A',
              isDark: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
              isSmall: isSmall,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.phone_outlined,
              label: "Phone",
              value: userController.currentUser.value.phoneNumber ?? 'N/A',
              isDark: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
              isSmall: isSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    required Color textColor,
    required Color subTextColor,
    required bool isSmall,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Edit specific field
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary)
            .withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: isSmall ? 20 : 22,
                  color: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutfitText(
                      text: label,
                      fontSize: isSmall ? 12 : 13,
                      fontWeight: FontWeight.w500,
                      color: subTextColor,
                    ),
                    const SizedBox(height: 4),
                    OutfitText(
                      text: value,
                      fontSize: isSmall ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: subTextColor.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    final isDark = themeController.isDarkMode.value;
    final userController = Get.find<UserController>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            OutfitText(
              text: "Change Profile Picture",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
            ),

            const SizedBox(height: 16),

            // Horizontal List of Static Images
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: userController.profileOptions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 25),
                itemBuilder: (context, index) {
                  final url = userController.profileOptions[index];
                  return GestureDetector(
                    onTap: () {
                      // userController.updateProfilePicture(url);
                      Get.back();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.1)
                              : AppColors.bluePrimary,
                          width: 2.5,
                        ),
                      ),
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Camera Option
            _buildImageOption(
              icon: Icons.camera_alt_rounded,
              title: "Take Photo",
              onTap: () {
                Get.back();
                // Implement camera functionality
              },
              isDark: isDark,
            ),

            const SizedBox(height: 12),

            // Gallery Option
            _buildImageOption(
              icon: Icons.photo_library_rounded,
              title: "Choose from Gallery",
              onTap: () {
                Get.back();
                // Implement gallery functionality
              },
              isDark: isDark,
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? (isDark ? AppColors.redDarkError : AppColors.redError)
        : (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              OutfitText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
