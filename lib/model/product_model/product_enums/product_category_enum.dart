enum ProductCategory {
  electronics('assets/images/category_icons/electronics.svg'),
  fashion('assets/images/category_icons/fashion.svg'),
  home('assets/images/category_icons/home.svg'),
  sports('assets/images/category_icons/sports.svg'),
  health('assets/images/category_icons/health.svg'),
  books('assets/images/category_icons/books.svg'),
  automotive('assets/images/category_icons/automotive.svg'),
  other('assets/images/category_icons/others.svg');

  final String iconPath;
  const ProductCategory(this.iconPath);
}
