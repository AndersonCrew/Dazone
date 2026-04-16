part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final DataLoadStatus? status;
  final SplashNavigation? navigation;

  const SplashState({this.status = DataLoadStatus.initial, this.navigation});

  SplashState copyWith({DataLoadStatus? status, SplashNavigation? navigation}) {
    return SplashState(
      status: status,
      navigation: navigation ?? this.navigation,
    );
  }

  @override
  List<Object?> get props => [status, navigation];
}
