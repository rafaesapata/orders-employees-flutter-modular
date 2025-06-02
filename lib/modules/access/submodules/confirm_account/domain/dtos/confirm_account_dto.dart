class ConfirmAccountDTO {
  final String code;

  ConfirmAccountDTO({required this.code});

  Map<String, dynamic> get toMap => {
        'code': code,
      };
}
