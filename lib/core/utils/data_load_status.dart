/// The status that's used for general state when calling api in bloc
enum DataLoadStatus {
  /// The initial status
  initial,

  /// The loading status
  loading,

  /// The refreshing status
  refreshing,

  /// The success status
  success,

  /// The failure status
  failure,
}
