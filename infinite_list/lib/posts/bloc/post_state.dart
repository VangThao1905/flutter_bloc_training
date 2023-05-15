import 'package:equatable/equatable.dart';
import 'package:infinite_list/posts/models/post.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  const PostState(
      {required this.status, required this.posts, required this.hasReachedMax});

  PostState copyWith(
      {PostStatus? status, List<Post>? posts, bool? hasReachedMax}) {
    return PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax];
}
