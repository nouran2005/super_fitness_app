enum Status { initial, loading, success, error }

class Resource<T> {
  final Status status;
  final T? data;
  final String? error;

  const Resource._({
    required this.status,
    this.data,
    this.error,
  });

  factory Resource.initial() =>
      const Resource._(status: Status.initial);

  factory Resource.loading() =>
      const Resource._(status: Status.loading);

  factory Resource.success(T data) =>
      Resource._(status: Status.success, data: data);

  factory Resource.error(String error) =>
      Resource._(status: Status.error, error: error);

  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
}