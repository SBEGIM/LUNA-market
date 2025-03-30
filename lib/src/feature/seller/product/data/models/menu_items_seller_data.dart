class MenuItemsSellerData {
  final String title;
  final String url;

  MenuItemsSellerData({required this.title, required this.url});
}

class MenuItems {
  static final List<MenuItemsSellerData> items = [
    itemsAddProduct,
    itemsAddVideo
  ];
  static final List<MenuItemsSellerData> items2 = [
    itemsAddProduct,
    itemsAddVideo
  ];

  static final itemsAddProduct = MenuItemsSellerData(
      title: 'Добавить товар', url: 'assets/icons/add_product.svg');
  static final itemsAddVideo = MenuItemsSellerData(
      title: 'Добавить видео', url: 'assets/icons/add_video.svg');
}
