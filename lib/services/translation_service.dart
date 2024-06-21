import 'package:get/get.dart';

// 다국어 지원을 위한 Translations 클래스
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'change_language': 'Change Language',
          'change_theme': 'Change Theme',
          // 설정
          'admin': 'Admin',
          'user': 'User',
          'sign_up': 'Sign Up',
          'email': 'Email',
          'password': 'Password',
          'admin_login': 'Admin Login',
          'not_member': 'Not a member?',
          'address': 'Address',
          'cofirm_password': 'Confirm Password',
          'create_account': 'Create Account',
          // 회원가입
          'login_message':
              'Enjoy the benefits quickly and easily with social login. 🎉',
          'kakao_login': 'Kakao Login',
          'google_login': 'Google Login',
          'social_login': 'Social Login',
          // 로그인
        },
        'ko_KR': {
          'hello': '안녕하세요',
          'change_language': '언어 변경',
          'change_theme': '테마 변경',
          'admin': '관리자',
          'user': '사용자',
          'sign_up': '회원가입',
          'email': '이메일',
          'password': '비밀번호',
          'admin_login': '관리자 로그인',
          'not_member': '회원이 아니신가요?',
          'address': '주소',
          'cofirm_password': '비밀번호 확인',
          'create_account': '계정 생성',
          'login_message': '쉽고 빠르게 소셜로그인으로 혜택을 마음껏 누려보세요. 🎉',
          'kakao_login': '카카오 로그인',
          'google_login': '구글 로그인',
          'social_login': '소셜 로그인',
        },
        'ja_JP': {
          'hello': 'こんにちは',
          'change_language': '言語を変更する',
          'change_theme': 'テーマを変更する',
          'admin': 'マネージャー',
          'user': 'ユーザー',
          'sign_up': '会員登録',
          'email': 'Eメール',
          'password': 'パスワード',
          'admin_login': 'マネージャー ログイン',
          'not_member': '会員ではありませんか?',
          'address': '住所',
          'cofirm_password': 'パスワード確認',
          'create_account': 'アカウントの作成',
          'login_message': '簡単かつ迅速にソーシャルログインで恩恵をお楽しみください。 🎉',
          'kakao_login': 'Kakaoログイン',
          'google_login': 'Googleログイン',
          'social_login': 'ソーシャルログイン',
        },
      };
}
