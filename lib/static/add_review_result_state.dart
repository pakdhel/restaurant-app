sealed class AddReviewResultState {}

class AddReviewNoneState extends AddReviewResultState {}

class AddReviewLoadingState extends AddReviewResultState {}

class AddReviewSuccessState extends AddReviewResultState {}

class AddReviewErrorState extends AddReviewResultState {
  final String error;
  AddReviewErrorState(this.error);
}
