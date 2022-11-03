
class basketOrderDTO {

  final ProductDTO? product;
  final BasketDTO? basket;

  const basketOrderDTO({
    required this.product,
    required this.basket,
  });

}

class ProductDTO{
  final int? id;
  final int? shop_id;
  final String? name;
  final int? compound;
  final int? courier_price;
  final int? price;

  const ProductDTO({
     this.id,
     this.shop_id,
     this.name,
     this.compound,
     this.courier_price,
     this.price,
});
}


class BasketDTO{
  final int? price_courier;
  final int? price;
  final int? basket_id;
  final int? basket_count;
  final String? basket_color;
  final String? basket_size;
  final String? shop_name;
  final List<String>? address;

  const BasketDTO({
    this.price_courier,
    this.price,
    this.basket_id,
    this.basket_count,
    this.basket_color,
    this.basket_size,
    this.shop_name,
    this.address,
});

}