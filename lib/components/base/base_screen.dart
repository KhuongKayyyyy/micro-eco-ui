import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@immutable
abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        /// 화면 라이프사이클
        useEffect(() {
          onInit(context);
          return () => onDispose(context);
        }, []);

        // 웹 환경에서 화면 너비 제한
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 770),
          child: Scaffold(
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: buildAppBar(context),
            body: wrapWithSafeArea
                ? SafeArea(
                    top: setTopSafeArea,
                    bottom: setBottomSafeArea,
                    child: buildBody(context),
                  )
                : buildBody(context),
            backgroundColor:
                backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            bottomNavigationBar: buildBottomNavigationBar(context),
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButton: buildFloatingActionButton,
          ),
        );
      },
    );
  }

  /// 앱바 구성
  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// Body 구성
  @protected
  Widget buildBody(BuildContext context);

  /// 하단 네비게이션 바 구성
  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// 플로팅 액션 버튼 위치 설정
  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  /// 플로팅 액션 버튼 구성
  @protected
  Widget? get buildFloatingActionButton => null;

  /// 화면의 배경색 설정
  @protected
  Color? get backgroundColor => null;

  /// 키보드가 나타날 때 화면 크기 조정 설정
  @protected
  bool get resizeToAvoidBottomInset => true;

  /// 바디 확장 설정
  @protected
  bool get extendBody => false;

  /// 앱바 뒤로 바디가 확장될 수 있는지 설정
  @protected
  bool get extendBodyBehindAppBar => false;

  /// SafeArea 사용 여부
  @protected
  bool get wrapWithSafeArea => true;

  /// SafeArea 상단 설정
  @protected
  bool get setTopSafeArea => true;

  /// SafeArea 하단 설정
  @protected
  bool get setBottomSafeArea => true;

  /// 뷰모델
  @protected
  T get viewModel => controller;

  /// 화면이 생성될 때 호출
  @protected
  void onInit(BuildContext context) {}

  /// 화면이 사라질 때 호출
  @protected
  void onDispose(BuildContext context) {}

  /// 컨트롤러 초기화 체크
  @protected
  void checkControllerReady() {
    assert(
      Get.isRegistered<T>(),
      'GetX: $T 컨트롤러가 초기화되지 않았습니다. $runtimeType 화면을 표시하기 전에 먼저 Get.put<$T>()을 호출하세요.',
    );
  }
}
