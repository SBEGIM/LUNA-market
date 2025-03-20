class Constants {
  const Constants._();

  static $NetworkAssetsCommon get common => const $NetworkAssetsCommon();
}

class $NetworkAssetsCommon {
  const $NetworkAssetsCommon();

  /// DEV: https://cdn.shopify.com/shopifycloud/shopify/assets/no-image-2048-5e88c1b20e087fb7bbe9a3771824e743c244f437e4f8ba93bbf7b11b53f7824c_600x600.gif
  String get notFoundImage =>
      'https://cdn.shopify.com/shopifycloud/shopify/assets/no-image-2048-5e88c1b20e087fb7bbe9a3771824e743c244f437e4f8ba93bbf7b11b53f7824c_600x600.gif';

  /// DEV: https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png
  String get noImageAvailable =>
      'https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png';
}
