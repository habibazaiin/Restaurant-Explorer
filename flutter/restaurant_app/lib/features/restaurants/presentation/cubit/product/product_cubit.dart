import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit({required this.getProductsUseCase})
      : super(const ProductInitial());

  Future<void> loadProducts(int restaurantId) async {
    emit(const ProductLoading());
    try {
      final products = await getProductsUseCase(restaurantId);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}