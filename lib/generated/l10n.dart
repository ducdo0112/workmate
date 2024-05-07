// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Let's enjoy gift`
  String get lets_enjoy_gift {
    return Intl.message(
      'Let\'s enjoy gift',
      name: 'lets_enjoy_gift',
      desc: '',
      args: [],
    );
  }

  /// `メールアドレス`
  String get email_address {
    return Intl.message(
      'メールアドレス',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `パスワードを忘れた場合`
  String get if_you_forget_your_password {
    return Intl.message(
      'パスワードを忘れた場合',
      name: 'if_you_forget_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Nhập thông tin đăng nhập`
  String get info_login {
    return Intl.message(
      'Nhập thông tin đăng nhập',
      name: 'info_login',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get register {
    return Intl.message(
      'Đăng ký',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `プライバシーポリシー`
  String get privacy_policy {
    return Intl.message(
      'プライバシーポリシー',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `利用規約`
  String get term_of_use {
    return Intl.message(
      '利用規約',
      name: 'term_of_use',
      desc: '',
      args: [],
    );
  }

  /// `と`
  String get and {
    return Intl.message(
      'と',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `お知らせ`
  String get notice {
    return Intl.message(
      'お知らせ',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `インターネット接続がありません。インターネット接続を確認してからもう一度お試しください。`
  String get no_connection_message {
    return Intl.message(
      'インターネット接続がありません。インターネット接続を確認してからもう一度お試しください。',
      name: 'no_connection_message',
      desc: '',
      args: [],
    );
  }

  /// `不明なエラー`
  String get unknown_error {
    return Intl.message(
      '不明なエラー',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `リロード`
  String get reload {
    return Intl.message(
      'リロード',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `パスワード確認`
  String get re_password {
    return Intl.message(
      'パスワード確認',
      name: 're_password',
      desc: '',
      args: [],
    );
  }

  /// `ニックネーム`
  String get name_account {
    return Intl.message(
      'ニックネーム',
      name: 'name_account',
      desc: '',
      args: [],
    );
  }

  /// `性別`
  String get sex {
    return Intl.message(
      '性別',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `お誕生月`
  String get birthday {
    return Intl.message(
      'お誕生月',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `お住まいの市町村`
  String get address {
    return Intl.message(
      'お住まいの市町村',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `利用規約`
  String get register_button {
    return Intl.message(
      '利用規約',
      name: 'register_button',
      desc: '',
      args: [],
    );
  }

  /// `アカウントを作成すると`
  String get when_you_create_an_account_text {
    return Intl.message(
      'アカウントを作成すると',
      name: 'when_you_create_an_account_text',
      desc: '',
      args: [],
    );
  }

  /// `と`
  String get and_text {
    return Intl.message(
      'と',
      name: 'and_text',
      desc: '',
      args: [],
    );
  }

  /// `利用規約`
  String get terms_of_service_text {
    return Intl.message(
      '利用規約',
      name: 'terms_of_service_text',
      desc: '',
      args: [],
    );
  }

  /// `プライバシポリシーに`
  String get privacy_policy_text {
    return Intl.message(
      'プライバシポリシーに',
      name: 'privacy_policy_text',
      desc: '',
      args: [],
    );
  }

  /// `同意したことになります。`
  String get you_agree_to_text {
    return Intl.message(
      '同意したことになります。',
      name: 'you_agree_to_text',
      desc: '',
      args: [],
    );
  }

  /// `アカウント登録`
  String get account_registration_text {
    return Intl.message(
      'アカウント登録',
      name: 'account_registration_text',
      desc: '',
      args: [],
    );
  }

  /// `KANNON COFFEE 松陰神社店`
  String get title_content_history_screen {
    return Intl.message(
      'KANNON COFFEE 松陰神社店',
      name: 'title_content_history_screen',
      desc: '',
      args: [],
    );
  }

  /// `2023年8月11日`
  String get date_content_history_screen {
    return Intl.message(
      '2023年8月11日',
      name: 'date_content_history_screen',
      desc: '',
      args: [],
    );
  }

  /// `4回目の来店でした。`
  String get content_history_screen {
    return Intl.message(
      '4回目の来店でした。',
      name: 'content_history_screen',
      desc: '',
      args: [],
    );
  }

  /// `インフルエンサー`
  String get influencer {
    return Intl.message(
      'インフルエンサー',
      name: 'influencer',
      desc: '',
      args: [],
    );
  }

  /// `割引クーポン`
  String get title_content_item_workmate {
    return Intl.message(
      '割引クーポン',
      name: 'title_content_item_workmate',
      desc: '',
      args: [],
    );
  }

  /// `クーポンGet`
  String get title_button_item_workmate {
    return Intl.message(
      'クーポンGet',
      name: 'title_button_item_workmate',
      desc: '',
      args: [],
    );
  }

  /// `有効期限：2023年8月11日`
  String get expiration_date {
    return Intl.message(
      '有効期限：2023年8月11日',
      name: 'expiration_date',
      desc: '',
      args: [],
    );
  }

  /// `当アプリのアカウント登録においては個人情報の提供は一切必要ありません。\n個人情報を登録しないようお願いします。`
  String get register_page_content_title {
    return Intl.message(
      '当アプリのアカウント登録においては個人情報の提供は一切必要ありません。\n個人情報を登録しないようお願いします。',
      name: 'register_page_content_title',
      desc: '',
      args: [],
    );
  }

  /// `ログインに使用するユーザーコードの入力してください。`
  String get register_user_code_page_content_title {
    return Intl.message(
      'ログインに使用するユーザーコードの入力してください。',
      name: 'register_user_code_page_content_title',
      desc: '',
      args: [],
    );
  }

  /// `ユーザーコード`
  String get register_user_code {
    return Intl.message(
      'ユーザーコード',
      name: 'register_user_code',
      desc: '',
      args: [],
    );
  }

  /// `半角英字、数字が使用できます。`
  String get register_content_user_code {
    return Intl.message(
      '半角英字、数字が使用できます。',
      name: 'register_content_user_code',
      desc: '',
      args: [],
    );
  }

  /// `次へ`
  String get next {
    return Intl.message(
      '次へ',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `ログインに使用するパスワードを入力してください。`
  String get register_password_title {
    return Intl.message(
      'ログインに使用するパスワードを入力してください。',
      name: 'register_password_title',
      desc: '',
      args: [],
    );
  }

  /// `アプリをより使いやすくするための項目を設定し\nてください。`
  String get register_add_account {
    return Intl.message(
      'アプリをより使いやすくするための項目を設定し\nてください。',
      name: 'register_add_account',
      desc: '',
      args: [],
    );
  }

  /// `お住まいの都道府県`
  String get you_live_prefectures {
    return Intl.message(
      'お住まいの都道府県',
      name: 'you_live_prefectures',
      desc: '',
      args: [],
    );
  }

  /// `年代(任意)`
  String get era {
    return Intl.message(
      '年代(任意)',
      name: 'era',
      desc: '',
      args: [],
    );
  }

  /// `年代`
  String get era_require {
    return Intl.message(
      '年代',
      name: 'era_require',
      desc: '',
      args: [],
    );
  }

  /// `招待コードをお持ちの方はご入力ください`
  String get add_Account_Register {
    return Intl.message(
      '招待コードをお持ちの方はご入力ください',
      name: 'add_Account_Register',
      desc: '',
      args: [],
    );
  }

  /// `招待コード(任意)`
  String get invitation_code_text {
    return Intl.message(
      '招待コード(任意)',
      name: 'invitation_code_text',
      desc: '',
      args: [],
    );
  }

  /// `男性`
  String get boy {
    return Intl.message(
      '男性',
      name: 'boy',
      desc: '',
      args: [],
    );
  }

  /// `女性`
  String get girl {
    return Intl.message(
      '女性',
      name: 'girl',
      desc: '',
      args: [],
    );
  }

  /// `回答しない`
  String get no_reply {
    return Intl.message(
      '回答しない',
      name: 'no_reply',
      desc: '',
      args: [],
    );
  }

  /// `携帯番号を入力してください。`
  String get register_mobile_number_text {
    return Intl.message(
      '携帯番号を入力してください。',
      name: 'register_mobile_number_text',
      desc: '',
      args: [],
    );
  }

  /// `例:08011112222`
  String get register_example {
    return Intl.message(
      '例:08011112222',
      name: 'register_example',
      desc: '',
      args: [],
    );
  }

  /// `電話番号は本人認証で使用するためで、\nデータとして保持することはありません。\n\n※通信料はお客様のご負担となります`
  String get register_content_mobile_number {
    return Intl.message(
      '電話番号は本人認証で使用するためで、\nデータとして保持することはありません。\n\n※通信料はお客様のご負担となります',
      name: 'register_content_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `SMSに認証コードを送る`
  String get register_button_phone_number_text {
    return Intl.message(
      'SMSに認証コードを送る',
      name: 'register_button_phone_number_text',
      desc: '',
      args: [],
    );
  }

  /// `***-****-{phoneNumber}にお送りした6桁の認証 番号を入力してください。`
  String register_sms_code_text(Object phoneNumber) {
    return Intl.message(
      '***-****-$phoneNumberにお送りした6桁の認証 番号を入力してください。',
      name: 'register_sms_code_text',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `1分たっても認証番号が届かない方へ`
  String get register_sms_content_text {
    return Intl.message(
      '1分たっても認証番号が届かない方へ',
      name: 'register_sms_content_text',
      desc: '',
      args: [],
    );
  }

  /// `電話番号を再入力する`
  String get register_input_phone_number {
    return Intl.message(
      '電話番号を再入力する',
      name: 'register_input_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `携帯番号`
  String get register_input_phone_number_text {
    return Intl.message(
      '携帯番号',
      name: 'register_input_phone_number_text',
      desc: '',
      args: [],
    );
  }

  /// `アプリの使い方`
  String get register_final_page {
    return Intl.message(
      'アプリの使い方',
      name: 'register_final_page',
      desc: '',
      args: [],
    );
  }

  /// `アプリを使う`
  String get register_final_page_button {
    return Intl.message(
      'アプリを使う',
      name: 'register_final_page_button',
      desc: '',
      args: [],
    );
  }

  /// `お一人様一回まで`
  String get times_for_user {
    return Intl.message(
      'お一人様一回まで',
      name: 'times_for_user',
      desc: '',
      args: [],
    );
  }

  /// `gift-taro`
  String get nick_name {
    return Intl.message(
      'gift-taro',
      name: 'nick_name',
      desc: '',
      args: [],
    );
  }

  /// `ホーム`
  String get history_page_title {
    return Intl.message(
      'ホーム',
      name: 'history_page_title',
      desc: '',
      args: [],
    );
  }

  /// `workmate`
  String get workmate_page_title {
    return Intl.message(
      'workmate',
      name: 'workmate_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Gift`
  String get login_header_workmate {
    return Intl.message(
      'Gift',
      name: 'login_header_workmate',
      desc: '',
      args: [],
    );
  }

  /// `CMN Gift`
  String get login_header_gif {
    return Intl.message(
      'CMN Gift',
      name: 'login_header_gif',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get user_code {
    return Intl.message(
      'email',
      name: 'user_code',
      desc: '',
      args: [],
    );
  }

  /// `アカウント情報`
  String get drawer_person {
    return Intl.message(
      'アカウント情報',
      name: 'drawer_person',
      desc: '',
      args: [],
    );
  }

  /// `Giftアプリの使い方`
  String get drawer_guide {
    return Intl.message(
      'Giftアプリの使い方',
      name: 'drawer_guide',
      desc: '',
      args: [],
    );
  }

  /// `お問い合わせ`
  String get drawer_email {
    return Intl.message(
      'お問い合わせ',
      name: 'drawer_email',
      desc: '',
      args: [],
    );
  }

  /// `ログアウト`
  String get drawer_logout {
    return Intl.message(
      'ログアウト',
      name: 'drawer_logout',
      desc: '',
      args: [],
    );
  }

  /// `完了`
  String get completed {
    return Intl.message(
      '完了',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `ショップクーポン`
  String get workmate_tab_page_header {
    return Intl.message(
      'ショップクーポン',
      name: 'workmate_tab_page_header',
      desc: '',
      args: [],
    );
  }

  /// `残り有効期間：`
  String get workmate_time_remain {
    return Intl.message(
      '残り有効期間：',
      name: 'workmate_time_remain',
      desc: '',
      args: [],
    );
  }

  /// `近くのショップ `
  String get near_shop_list {
    return Intl.message(
      '近くのショップ ',
      name: 'near_shop_list',
      desc: '',
      args: [],
    );
  }

  /// `来店履歴`
  String get visit_history_title {
    return Intl.message(
      '来店履歴',
      name: 'visit_history_title',
      desc: '',
      args: [],
    );
  }

  /// `アプリの使い方`
  String get guide_tab_page_title {
    return Intl.message(
      'アプリの使い方',
      name: 'guide_tab_page_title',
      desc: '',
      args: [],
    );
  }

  /// `画像を表示`
  String get view_image {
    return Intl.message(
      '画像を表示',
      name: 'view_image',
      desc: '',
      args: [],
    );
  }

  /// `全て見る`
  String get see_all_near_shop {
    return Intl.message(
      '全て見る',
      name: 'see_all_near_shop',
      desc: '',
      args: [],
    );
  }

  /// `いいね`
  String get nice {
    return Intl.message(
      'いいね',
      name: 'nice',
      desc: '',
      args: [],
    );
  }

  /// `プロフィール`
  String get profile {
    return Intl.message(
      'プロフィール',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `このインフルエンサーにいいねを送りますか？`
  String get influencer_confirm_message {
    return Intl.message(
      'このインフルエンサーにいいねを送りますか？',
      name: 'influencer_confirm_message',
      desc: '',
      args: [],
    );
  }

  /// `他のインフルエンサーにいいねが送れなくなります。`
  String get influencer_confirm_note {
    return Intl.message(
      '他のインフルエンサーにいいねが送れなくなります。',
      name: 'influencer_confirm_note',
      desc: '',
      args: [],
    );
  }

  /// `キャンセル`
  String get cancel {
    return Intl.message(
      'キャンセル',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `クーポン`
  String get workmate_detail_page_title {
    return Intl.message(
      'クーポン',
      name: 'workmate_detail_page_title',
      desc: '',
      args: [],
    );
  }

  /// `取得済み`
  String get buy {
    return Intl.message(
      '取得済み',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `提供するショップで、クーポンのサービスを受けてください。`
  String get buy_workmate_explain {
    return Intl.message(
      '提供するショップで、クーポンのサービスを受けてください。',
      name: 'buy_workmate_explain',
      desc: '',
      args: [],
    );
  }

  /// `必須項目です`
  String get require_not_empty {
    return Intl.message(
      '必須項目です',
      name: 'require_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `本当にログアウトしますか?`
  String get confirm_exit {
    return Intl.message(
      '本当にログアウトしますか?',
      name: 'confirm_exit',
      desc: '',
      args: [],
    );
  }

  /// `アカウント情報`
  String get account_info_text {
    return Intl.message(
      'アカウント情報',
      name: 'account_info_text',
      desc: '',
      args: [],
    );
  }

  /// `ギフトたろー`
  String get name_account_content_text {
    return Intl.message(
      'ギフトたろー',
      name: 'name_account_content_text',
      desc: '',
      args: [],
    );
  }

  /// `お住まい`
  String get residence_text {
    return Intl.message(
      'お住まい',
      name: 'residence_text',
      desc: '',
      args: [],
    );
  }

  /// `東京都千代田区`
  String get residence_address_text {
    return Intl.message(
      '東京都千代田区',
      name: 'residence_address_text',
      desc: '',
      args: [],
    );
  }

  /// `アカウントを解約する`
  String get cancel_your_account_text {
    return Intl.message(
      'アカウントを解約する',
      name: 'cancel_your_account_text',
      desc: '',
      args: [],
    );
  }

  /// `変更`
  String get change_text {
    return Intl.message(
      '変更',
      name: 'change_text',
      desc: '',
      args: [],
    );
  }

  /// `ギフたろー`
  String get gift_taro_text {
    return Intl.message(
      'ギフたろー',
      name: 'gift_taro_text',
      desc: '',
      args: [],
    );
  }

  /// `東京都`
  String get prefectures_content_text {
    return Intl.message(
      '東京都',
      name: 'prefectures_content_text',
      desc: '',
      args: [],
    );
  }

  /// `千代田区`
  String get city_of_residence_content_text {
    return Intl.message(
      '千代田区',
      name: 'city_of_residence_content_text',
      desc: '',
      args: [],
    );
  }

  /// `インフルエンサー一覧をみる`
  String get go_to_influencer_list {
    return Intl.message(
      'インフルエンサー一覧をみる',
      name: 'go_to_influencer_list',
      desc: '',
      args: [],
    );
  }

  /// `アカウントを削除しますか?`
  String get confirm_delete_account {
    return Intl.message(
      'アカウントを削除しますか?',
      name: 'confirm_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `ご利用ありがとうございました。`
  String get thank_message {
    return Intl.message(
      'ご利用ありがとうございました。',
      name: 'thank_message',
      desc: '',
      args: [],
    );
  }

  /// `いいねを送ろう！`
  String get send_a_like_title {
    return Intl.message(
      'いいねを送ろう！',
      name: 'send_a_like_title',
      desc: '',
      args: [],
    );
  }

  /// `お店を紹介してくれたインフルエンサーや好きなインフルエンサーに\n「いいね」を送ろう`
  String get send_a_like_content {
    return Intl.message(
      'お店を紹介してくれたインフルエンサーや好きなインフルエンサーに\n「いいね」を送ろう',
      name: 'send_a_like_content',
      desc: '',
      args: [],
    );
  }

  /// `次回から表示しない`
  String get do_not_show_next_time {
    return Intl.message(
      '次回から表示しない',
      name: 'do_not_show_next_time',
      desc: '',
      args: [],
    );
  }

  /// `お店のNFCシールにタッチしてね`
  String get guide_when_tap_workmate_list {
    return Intl.message(
      'お店のNFCシールにタッチしてね',
      name: 'guide_when_tap_workmate_list',
      desc: '',
      args: [],
    );
  }

  /// `おすすめのショップ`
  String get history_near_shop_list_title {
    return Intl.message(
      'おすすめのショップ',
      name: 'history_near_shop_list_title',
      desc: '',
      args: [],
    );
  }

  /// `アカウントを登録して\nお得なクーポンを\nゲットしよう！\n`
  String get workmate_view_only_suggest_title {
    return Intl.message(
      'アカウントを登録して\nお得なクーポンを\nゲットしよう！\n',
      name: 'workmate_view_only_suggest_title',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get check_workmate {
    return Intl.message(
      'OK',
      name: 'check_workmate',
      desc: '',
      args: [],
    );
  }

  /// `選択しない`
  String get not_select {
    return Intl.message(
      '選択しない',
      name: 'not_select',
      desc: '',
      args: [],
    );
  }

  /// `アプリの使い方`
  String get how_to_use {
    return Intl.message(
      'アプリの使い方',
      name: 'how_to_use',
      desc: '',
      args: [],
    );
  }

  /// `使用済となりますがよろしいですか？`
  String get confirm_open_detail_workmate {
    return Intl.message(
      '使用済となりますがよろしいですか？',
      name: 'confirm_open_detail_workmate',
      desc: '',
      args: [],
    );
  }

  /// `有効期限が切れています`
  String get workmate_expired {
    return Intl.message(
      '有効期限が切れています',
      name: 'workmate_expired',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
