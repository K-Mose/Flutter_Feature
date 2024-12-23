# Flutter Feature

Flutter 프로젝트를 진행하면서 필요한 사전학습 및 개인 공부 공간입니다. 


**프로젝트 생성 팁**
```cmd
# 도메인 지정 생성 --org com.example
$ flutter create --org com.mose.kim my_project
## => 생성된 도메인 - com.mose.kim.my_project

# 플랫폼 지정 생성. --platforms=[android,ios,web,windows,macos,linux]
# 전부 default로 생성되어 사용할 플랫폼을 지정하는 것이 좋다.
$ flutter create my_project --platforms=android, ios
## => 생성된 플랫폼 - android, ios
```



### Android Studio 업데이트에 따른 gradle versioning
`BUG! exception in phase 'semantic analysis' in source unit '_BuildScript_' Unsupported class file major version xx`

1. [Android Java Gradle migration gudie](https://docs.flutter.dev/release/breaking-changes/android-java-gradle-migration-guide) 확인
2. [Gradle Java/Kotlin Compatibility](https://docs.gradle.org/current/userguide/compatibility.html#java) 확인
3. [Android Studio Grable 플러그인 출시노트](https://developer.android.com/build/releases/gradle-plugin?buildsystem=ndk-build&hl=ko#updating-gradle) 확인

**Android Gradle 플러그인과 Android 스튜디오 호환성**을 확인하면 Android Stduio 버전에 따른 필요한 Gradle 버전이 표시된다.

![image](https://github.com/user-attachments/assets/1abe5b9a-6f94-463c-bc23-e494e7ded72f)
![image](https://github.com/user-attachments/assets/fdfcb0de-fe87-44ef-9d22-7db5b527b5a1)

지금 가장 최신버전인 LadyBug 사용 시 아래 버전이 필요하다.
- Gradle Version: 8.7 이상
- kotlin 1.9.22 이상
- jdk: 22 이상

1. `settings.gradle`에서 plugin을 업데이트 한다.
  ```gradle
plugins {
    id 'com.android.application' version '8.7.0' apply false
    id 'com.android.library' version '8.7.0' apply false
    id 'org.jetbrains.kotlin.android' version '2.0.20' apply false
}
  ```
2. cmd로 gradle을 업그레이드 후 `gradle-wrapper.properties`의 `distributionUrl`을 변경한다. 
  ```
cd android
# windows
.\gradlew.bat wrapper --gradle-version=8.7
# mac/linux
./gradlew wrapper --gradle-version=8.7
  ```
```gradle
# in gradle-wrapper.properties
distributionUrl = https\://services.gradle.org/distributions/gradle-8.7-bin.zip
```
3.  JDK 22버전 이상 다운로드 후 SDK 설정을 한다.
![image](https://github.com/user-attachments/assets/46c7212b-393c-40e6-9496-55f996ae63f0)
4. `flutter run` 또는 shift + F10 으로 앱을 실행한다.


### Dart 3.0 mirgration 오류
`A problem occurred configuring project ':package_name'.`
해당 패키지가 2.x 버전으로 최신 gradle 버전과 호환이 안돼 나오는 오류로 보인다. <br>
패키지를 dart 3.x와 호환되는 버전으로 업그레이드 하거나 해당 패키지의 `build.gradle` 파일에서 `namespace`를 직접 지정해준다. <br>

**오류 내용**
```
A problem occurred configuring project ':package_name'.
> Could not create an instance of type com.android.build.api.variant.impl.LibraryVariantBuilderImpl.
   > Namespace not specified. Specify a namespace in the module's build file: C:\Users\%your_name%\AppData\Local\Pub\Cache\hosted\pub.dev\package_name-version\android\build.gradle.
```
위에 나오 `build.gradle`파일을 열고 `namespace`를 지정해준다. 
```
android {
    if (project.android.hasProperty("namespace")) {
      namespace = "com.example.packagename" // 파일 맨 위에 group에 나온 package name을 복붙
    }
}
```
