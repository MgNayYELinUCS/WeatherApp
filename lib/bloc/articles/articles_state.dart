part of 'articles_bloc.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();
}

class ArticlesInitial extends ArticlesState {
  @override
  List<Object> get props => [];
}
