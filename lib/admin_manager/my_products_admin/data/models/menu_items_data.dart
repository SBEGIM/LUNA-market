class MenuItemsData {
  final String title;
  final String url;

  MenuItemsData({required this.title, required this.url});
}

class MenuItems {
  static final List<MenuItemsData> items = [itemsAddProduct, itemsAddVideo];
  static final List<MenuItemsData> items2 = [itemsAddProduct, itemsAddVideo];

  static final itemsAddProduct = MenuItemsData(
      title: 'Добавить товар', url: 'assets/icons/add_product.svg');
  static final itemsAddVideo =
      MenuItemsData(title: 'Добавить видео', url: 'assets/icons/add_video.svg');
}
