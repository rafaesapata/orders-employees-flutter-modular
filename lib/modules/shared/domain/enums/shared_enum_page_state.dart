enum SharedEnumPageState { loading, ready, error, success }

extension SharedEnumPageStateSetup on SharedEnumPageState {
  bool get isLoading => this == SharedEnumPageState.loading;
  bool get isReady => this == SharedEnumPageState.ready;
  bool get isError => this == SharedEnumPageState.error;
  bool get isSuccess => this == SharedEnumPageState.success;
}
