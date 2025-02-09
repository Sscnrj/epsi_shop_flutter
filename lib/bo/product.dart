final listProducts = [
  Product(
    id: 1,
    title: "Bilboquet",
    description:
        "Jeu d'adresse et d'agilité, le bilboquet est un jeu traditionnel où une boule en bois, suspendue par une cordelette, doit être rattrapée par un pic en bois.",
    category: "Informatique",
    image: "assets/images/bilboquet.jpg",
    price: 2699.99,
  ),
  Product(
    id: 2,
    title: "Boomerang",
    description: "Jeu pour célibataire australien",
    category: "Chaussures",
    image: "assets/images/boomerang.jpg",
    price: 149.99,
  ),
  Product(
    id: 3,
    title: "Diabolo",
    description: "Jeu pour saltimbanque",
    category: "Téléphonie",
    image: "assets/images/diabolo.jpg",
    price: 1299.99,
  ),
  Product(
    id: 4,
    title: "Table à manger en chêne",
    description: "Table en bois massif pour 6 personnes, style contemporain",
    category: "Mobilier",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 899.99,
  ),
  Product(
    id: 5,
    title: "Machine à café Delonghi",
    description: "Machine à café automatique avec broyeur à grains intégré",
    category: "Électroménager",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 599.99,
  ),
  Product(
    id: 6,
    title: "PlayStation 5",
    description: "Console de jeu nouvelle génération avec manette DualSense",
    category: "Gaming",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 499.99,
  ),
  Product(
    id: 7,
    title: "Canapé d'angle convertible",
    description:
        "Canapé en tissu gris avec méridienne gauche et coffre de rangement",
    category: "Mobilier",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 1299.99,
  ),
  Product(
    id: 8,
    title: "Robot aspirateur Roomba",
    description:
        "Robot aspirateur intelligent avec cartographie et contrôle via smartphone",
    category: "Électroménager",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 449.99,
  ),
  Product(
    id: 9,
    title: "Apple Watch Series 9",
    description: "Montre connectée avec GPS et cellular, boîtier 45mm",
    category: "Accessoires",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 499.99,
  ),
  Product(
    id: 10,
    title: "Télévision Samsung QLED 65\"",
    description: "TV 4K UHD Smart TV avec processeur Neural Quantum",
    category: "TV & Home Cinéma",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 1799.99,
  ),
  Product(
    id: 11,
    title: "Vélo électrique Specialized",
    description: "Vélo urbain électrique avec autonomie de 80km",
    category: "Sport",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 2499.99,
  ),
  Product(
    id: 12,
    title: "Appareil photo Sony A7 IV",
    description:
        "Appareil photo hybride plein format 33MP avec objectif 28-70mm",
    category: "Photo",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    price: 2899.99,
  ),
];

class Product {
  String title;
  String description;
  int id;
  String category;
  String image;
  num price;

  Product({
    required this.title,
    required this.description,
    required this.id,
    required this.category,
    required this.image,
    required this.price,
  });

  String getPrice() => "${price.toStringAsFixed(2)}€";

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'id': this.id,
      'category': this.category,
      'image': this.image,
      'price': this.price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      description: map['description'] as String,
      id: map['id'] as int,
      category: map['category'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
    );
  }
}
