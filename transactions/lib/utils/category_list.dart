class Category {
  int categoryId;
  String categoryName;

  Category({
    required this.categoryId,
    required this.categoryName
  });

  static List<Category> getIncomeCategoryList() {
    return [
      Category(categoryId: 4, categoryName: 'INCOME'),
      Category(categoryId: 5, categoryName: 'WAGE')
    ];
  }

  static List<Category> getExpenseCategoryList() {
    return [
      Category(categoryId: 1, categoryName: 'FOOD'),
      Category(categoryId: 2, categoryName: 'TRANSPORTATION'),
      Category(categoryId: 3, categoryName: 'SHOPPING')
    ];
  }
}