import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_module_profile_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/client_show_image_list_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/client_show_list_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_cabinet_widget.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../chat/presentation/chat_page.dart';
import '../../../my_order/presentation/ui/my_order_page.dart';
import '../../../profile/data/presentation/ui/edit_profile_page.dart';
import '../widgets/bonus_page.dart';

@RoutePage()
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // --- State Variables ---
  bool isAuthUser = false;
  final _box = GetStorage();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  CityModel? city;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    city = _loadCity();
    // Check if user is authorized ('1' means active/authorized)
    isAuthUser = _box.read('active') == '1';
  }

  CityModel? _loadCity() {
    final data = GetStorage().read('city');
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return CityModel.fromJson(Map<String, dynamic>.from(data));
  }

  /// Handles image selection from Camera or Gallery
  Future<void> _handleImageSelection(bool fromCamera) async {
    final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
    final image = await _picker.pickImage(source: source);

    if (image != null) {
      debugPrint('Selected image: ${image.path}');
      setState(() {
        _image = image;
      });
    }
  }

  /// Shows the dialog to choose image source
  void _onAvatarTap() {
    showClientImageOptions(context, false, 'Изменить фото профиля', (value) async {
      if (value == 'image') {
        final bool? isCamera = await showAccountAlert(
          context,
          title: 'Изменить фото',
          message: 'Выберите источник',
          mode: AccountAlertMode.confirm,
          cancelText: 'Галерея',
          primaryText: 'Камера',
          primaryColor: Colors.red,
        );

        if (!mounted || isCamera == null) return;
        _handleImageSelection(isCamera);
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _onChangeCabinetTap() {
    showRolePicker(context, isAuthUser ? 'change_cabinet' : 'auth_user');
  }

  Future<void> _onProfileDataTap() async {
    if (!isAuthUser) {
      // Logout logic
      GetStorage().remove('token');
      BlocProvider.of<AppBloc>(context).add(const AppEvent.exiting());
    } else {
      // Navigate to Edit Profile
      final data = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfilePage(
            firstName: _box.read('first_name'),
            lastName: _box.read('last_name'),
            surName: _box.read('sur_name'),
            phone: _box.read('phone') ?? '',
            gender: _box.read('gender') ?? '',
            birthday: _box.read('birthday') ?? '',
            email: _box.read('email') ?? '',
          ),
        ),
      );

      if (data != null) {
        setState(() {});
      }
    }
  }

  void _onSupportTap() {
    final List<String> options = ['Whats App', 'Telegram', 'Email'];
    showModuleProfile(context, 'Техподдержка', options, (value) {
      const url = "https://t.me/LUNAmarketAdmin";
      switch (value) {
        case 'Whats App':
        case 'Telegram':
        case 'Email':
          launch(url, forceSafariVC: false);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // --- 1. Header Section (Profile info or Welcome screen) ---
          _DrawerHeader(
            isAuthUser: isAuthUser,
            city: city,
            imageFile: _image,
            box: _box,
            onAvatarTap: _onAvatarTap,
            onChangeCabinetTap: _onChangeCabinetTap,
          ),

          // --- 2. Action Buttons (Bonus, Order, Chat) - Only for auth users ---
          if (isAuthUser) const _ActionButtons(),

          // --- 3. Menu Options List ---
          // Removed fixed height to fix scrolling issues
          _MenuOptionsList(
            isAuthUser: isAuthUser,
            onProfileDataTap: _onProfileDataTap,
            onSupportTap: _onSupportTap,
          ),
        ],
      ),
    );
  }
}

/// Widget for the top part of the drawer.
/// Displays user info if authenticated, or a welcome banner if not.
class _DrawerHeader extends StatelessWidget {
  final bool isAuthUser;
  final CityModel? city;
  final XFile? imageFile;
  final GetStorage box;
  final VoidCallback onAvatarTap;
  final VoidCallback onChangeCabinetTap;

  const _DrawerHeader({
    required this.isAuthUser,
    required this.city,
    required this.imageFile,
    required this.box,
    required this.onAvatarTap,
    required this.onChangeCabinetTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isAuthUser) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            // Avatar
            SizedBox(
              height: 100,
              width: 100,
              child: GestureDetector(
                onTap: onAvatarTap,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.kAlpha12,
                      child: CircleAvatar(
                        radius: 59.5,
                        backgroundColor: AppColors.kGray200,
                        backgroundImage: imageFile != null
                            ? FileImage(File(imageFile!.path))
                            : NetworkImage(
                                'https://lunamarket.ru/storage/${box.read('avatar')}',
                              ) as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        Assets.icons.sellerCameraIcon.path,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              '${box.read('first_name') ?? ''} ${box.read('last_name') ?? ''}',
              style: AppTextStyles.size18Weight600,
            ),
            const SizedBox(height: 4),
            // City
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  city?.city ?? 'Алматы',
                  style: AppTextStyles.size14Weight500.copyWith(
                    color: const Color(0xff959595),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Change Cabinet Button
            InkWell(
              onTap: onChangeCabinetTap,
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  border: Border.all(color: const Color(0xffEDEDED), width: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.icons.backClientIcon.path,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 5),
                    Text('Сменить кабинет', style: AppTextStyles.size16Weight500),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      );
    } else {
      // Unauthenticated Header
      return Container(
        height: 462,
        padding: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
            transform: GradientRotation(4.2373),
            colors: [Color(0xFFAD32F8), Color(0xFF3275F8)],
          ),
          color: AppColors.mainPurpleColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              height: 258,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.kLightBlackColor.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileAvatar(box),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Добро пожаловать!',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 320,
                        child: Text(
                          'Войдите или зарегистрируйтесь, чтобы открыть весь функционал',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.categoryTextStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 22 / 16,
                            color: AppColors.kGray200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DefaultButton(
                text: 'Начать',
                press: onChangeCabinetTap,
                color: AppColors.kLightBlackColor,
                backgroundColor: AppColors.kWhite,
                textStyle: AppTextStyles.aboutTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProfileAvatar(GetStorage box) {
    final String? avatar = box.read('avatar');
    final String? name = box.read('name');

    final bool isAuthorized =
        avatar != null && avatar != 'null' && name != null && name != 'Не авторизированный';

    return isAuthorized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(120),
            child: Image.network(
              'https://lunamarket.ru/storage/$avatar',
              height: 94,
              width: 94,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            height: 94,
            width: 94,
            padding: isAuthorized ? EdgeInsets.zero : const EdgeInsets.all(29.5),
            decoration: BoxDecoration(
              color: AppColors.kWhite.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(51),
            ),
            child: Image(
              image: AssetImage(Assets.icons.accountHead.path),
              fit: isAuthorized ? BoxFit.cover : BoxFit.contain,
              alignment: Alignment.center,
            ),
          );
  }
}

/// Widget for the row of action buttons (Bonus, Orders, Chat)
class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      margin: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BonusUserPage()),
              );
            },
            child: Image.asset(
              Assets.icons.profileClientBonusIcon.path,
              height: 82,
              width: 114,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrderPage()),
              );
            },
            child: Image.asset(
              Assets.icons.profileClientOrderIcon.path,
              height: 82,
              width: 114,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
            child: Image.asset(
              Assets.icons.profileClientChatIcon.path,
              height: 82,
              width: 114,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for the list of menu options at the bottom
class _MenuOptionsList extends StatelessWidget {
  final bool isAuthUser;
  final VoidCallback onProfileDataTap;
  final VoidCallback onSupportTap;

  const _MenuOptionsList({
    required this.isAuthUser,
    required this.onProfileDataTap,
    required this.onSupportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Removed fixed height: MediaQuery.of(context).size.height
      // This allows the container to size itself based on content, fixing scroll issues.
      margin: EdgeInsets.only(top: isAuthUser ? 0 : 16),
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          if (isAuthUser)
            _ProfileMenuItem(
              onTap: onProfileDataTap,
              title: 'Мои данные',
              iconPath: Assets.icons.sellerProfileDataIcon.path,
            ),

          _ProfileMenuItem(
            onTap: () {
              context.router.push(AddressRoute());
            },
            title: 'Cохраненные адреса',
            iconPath: Assets.icons.locationProfileIcon.path,
          ),

          _ProfileMenuItem(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
            title: 'LUNA market',
            iconPath: Assets.icons.about.path,
          ),

          _ProfileMenuItem(
            onTap: onSupportTap,
            title: 'Техподдержка',
            iconPath: Assets.icons.supportCenter.path,
          ),

          _ProfileMenuItem(
            onTap: () => showClientSettingOptions(context, isAuthUser, 'Настройки', () {}),
            title: 'Настройки',
            count: 4,
            iconPath: Assets.icons.settingIcon.path,
          ),
          
          // Add some bottom padding for better scrolling experience
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Helper widget for a single menu item
class _ProfileMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final int? count;

  const _ProfileMenuItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16, left: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(iconPath, height: 40, width: 40),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTextStyles.size16Weight600.copyWith(color: const Color(0xFF3A3A3C)),
                ),
              ],
            ),
            if (count == null)
              SizedBox(
                width: 8,
                height: 14,
                child: Image.asset(Assets.icons.defaultArrowForwardIcon.path),
              )
            else
              Row(
                children: [
                  Text(
                    '$count',
                    style: AppTextStyles.size16Weight400.copyWith(color: const Color(0xFF3A3A3C)),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 8,
                    height: 14,
                    child: Image.asset(Assets.icons.defaultArrowForwardIcon.path),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
