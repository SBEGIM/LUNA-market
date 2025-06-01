import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_statet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import '../../auth/bloc/edit_blogger_cubit.dart';
// import '../../auth/bloc/edit_blogger_statet.dart';

class ReqirectProfilePage extends StatefulWidget {
  final String title;
  ReqirectProfilePage({required this.title, Key? key}) : super(key: key);

  @override
  State<ReqirectProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectProfilePage> {
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final iinController = TextEditingController();
  final socialNetworkController = TextEditingController();
  final emailController = TextEditingController();
  final reapatPasswordController = TextEditingController();
  final checkController = TextEditingController();

  final _box = GetStorage();
  bool change = false;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _obscureText = true;
  bool _obscureTextRepeat = true;

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  void _initializeControllers() {
    nameController.text = _box.read('blogger_name') ?? '';
    phoneController.text = _box.read('blogger_phone') ?? '';
    nickNameController.text = _box.read('blogger_nick_name') ?? '';
    iinController.text = _box.read('blogger_iin') != 'null'
        ? (_box.read('blogger_iin') ?? '')
        : '';
    socialNetworkController.text = _box.read('blogger_social_network') ?? '';
    emailController.text = _box.read('blogger_email') ?? '';
    checkController.text = _box.read('blogger_invoice') != 'null'
        ? (_box.read('blogger_invoice') ?? '')
        : '';
  }

  Future<void> _getImage() async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${widget.title}',
          style: AppTextStyles.appBarTextStyle,
        ),
      ),
      body: BlocConsumer<EditBloggerCubit, EditBloggerState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Get.back(result: 'ok');
          }
        },
        builder: (context, state) {
          if (state is InitState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // _buildProfileHeader(),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: widget.title == 'Оснавная информация',
                            child: Column(children: [
                              _buildFormField(
                                controller: nameController,
                                label: 'Имя и фамилия',
                              ),
                              _buildFormField(
                                controller: iinController,
                                label: 'ИИН',
                                keyboardType: TextInputType.number,
                              ),
                              _buildFormField(
                                controller: checkController,
                                label: 'Счёт',
                              ),
                            ])),
                        Visibility(
                          visible: widget.title == 'Социальные сети',
                          child: Column(
                            children: [
                              _buildFormField(
                                controller: nickNameController,
                                label: 'Никнейм',
                              ),
                              _buildFormField(
                                controller: socialNetworkController,
                                label: 'Ссылка на соц сеть',
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.title == 'Контактные данные',
                          child: Column(
                            children: [
                              _buildFormField(
                                controller: phoneController,
                                label: 'Телефон',
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskFormatter],
                              ),
                              _buildFormField(
                                controller: emailController,
                                label: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              _buildPasswordField(
                                controller: passwordController,
                                label: 'Пароль',
                                obscureText: _obscureText,
                                onToggle: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              _buildPasswordField(
                                controller: reapatPasswordController,
                                label: 'Подтвердите пароль',
                                obscureText: _obscureTextRepeat,
                                onToggle: () {
                                  setState(() {
                                    _obscureTextRepeat = !_obscureTextRepeat;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomSheet: _buildSaveButton(context),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_image == null) {
                Get.defaultDialog(
                  title: "Изменить фото",
                  middleText: '',
                  textConfirm: 'Камера',
                  textCancel: 'Галерея',
                  titlePadding: const EdgeInsets.only(top: 40),
                  onConfirm: () {
                    change = true;
                    _getImage();
                  },
                  onCancel: () {
                    change = false;
                    _getImage();
                  },
                );
              }
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.kGray200,
                  backgroundImage: _box.read('blogger_avatar') != null
                      ? NetworkImage(
                          "https://lunamarket.ru/storage/${_box.read('blogger_avatar')}")
                      : const AssetImage('assets/icons/profile2.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt,
                        size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickNameController.text.isNotEmpty
                      ? nickNameController.text
                      : 'Никнейм не найден',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kGray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  emailController.text.isNotEmpty ? emailController.text : '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.kGray500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: const InputDecoration.collapsed(hintText: ''),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: onToggle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainPurpleColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () async {
          if (nameController.text.isNotEmpty ||
              nickNameController.text.isNotEmpty) {
            if (passwordController.text == reapatPasswordController.text) {
              final edit = BlocProvider.of<EditBloggerCubit>(context);
              await edit.edit(
                nameController.text,
                nickNameController.text,
                phoneController.text,
                passwordController.text,
                iinController.text,
                checkController.text,
                _image?.path,
                '',
                emailController.text,
                socialNetworkController.text,
              );
            }
          }
        },
        child: const Text(
          'Сохранить',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
