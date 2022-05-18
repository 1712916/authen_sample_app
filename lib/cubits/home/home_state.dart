import '../../data/data.dart';
import '../cubits.dart';


class HomeState extends BaseState implements Copyable<HomeState> {
  final ProfileModel? profileModel;

  HomeState({
    LoadStatus? loadStatus,
    this.profileModel,
  }) : super(loadStatus: loadStatus);

  @override
  List<Object?> get props => [loadStatus, profileModel];

  @override
  HomeState copy() {
    return this;
  }

  @override
  HomeState copyWith({LoadStatus? loadStatus, ProfileModel? profileModel}) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}