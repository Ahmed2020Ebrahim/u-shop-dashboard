class AppEnum {
  AppEnum._();
}

/// OrderStatus enum
enum OrderStatus { pending, processing, shipped, delivered, cancelled }

/// media dropdown section s
enum MediaDropdownSectons { folders, bannars, brands, categories, products, users }

///image type
enum ImageType { asset, network, memory }

///BannerActivationPathes
enum BannerActivationPathes { selectPath, home, store, brands, favorites, search, categories, profile, card }

/// ProductType
enum ProductType { single, variable }

//product visibility
enum ProductVisibility { published, hidden }

//payment methos
enum PaymentMethods { payMob, payPal, masterCard, googlePay, applePay, payStack, visa, creditCard }
