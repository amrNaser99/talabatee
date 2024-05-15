import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';

class GetCategoriesUseCase {
  final OrderRepo orderRepo;

  GetCategoriesUseCase({required this.orderRepo});

  Future<List<Categories>> execute() async {
    return orderRepo.getCategories();
  }
}