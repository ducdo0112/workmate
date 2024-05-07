class ErrorCodeMessage {
  static getErrorCodeMessage({required int? errorCode}) {
    switch(errorCode) {
      case 401:
        return '認証に失敗しました';
      case 409:
        return '既に使⽤されているユーザーコードです。';
      case 412:
        return '予期しないエラーが発⽣しました。';
      case 422:
        return '予期しないエラーが発⽣しました。';
      case 440:
        return '有効期間が切れました。電話番号を再入力してください。';
      default:
        return '予期しないエラーが発⽣しました。';
    }
  }
}