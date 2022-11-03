
class basketOrderDTO {
  
  final ProductDTO product;
  final BasketDTO basket;

  const basketOrderDTO({
    required this.product,
    required this.basket,
  });

}

class ProductDTO{
  final int id;
  final int shop_id;
  final String name;
  final int compound;
  final int courier_price;

  const ProductDTO({
    required this.id,
    required this.shop_id,
    required this.name,
    required this.compound,
    required this.courier_price,
});
}


class BasketDTO{
  final int price_courier;
  final int price;
  final int basket_id;
  final int basket_count;
  final String basket_color;
  final String basket_size;
  final String shop_name;
  final List<String> address;

  const BasketDTO({
    required this.price_courier,
    required this.price,
    required this.basket_id,
    required this.basket_count,
    required this.basket_color,
    required this.basket_size,
    required this.shop_name,
    required this.address,
});

}