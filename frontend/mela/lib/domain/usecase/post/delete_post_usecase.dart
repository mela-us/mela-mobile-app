import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/post/post.dart';
import 'package:mela/domain/repository/post/post_repository.dart';

class DeletePostUseCase extends UseCase<int, Post> {
  final PostRepository _postRepository;

  DeletePostUseCase(this._postRepository);

  @override
  Future<int> call({required params}) {
    return _postRepository.delete(params);
  }
}
