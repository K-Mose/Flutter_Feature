# dll_test

### KSCAT DLL 연동 테스트
---
**Import DLL**

Flutter에서 dll을 import 하기 전 C# 예시 코드에서 dll을 분석한다. (혹은 dll을 디컴파일해서 분석한다.)
```c#
[DllImport(@"ksnetcomm.dll")]
public static extern int KSCATApproval(byte[] responseTelegram, string ip, int port, string requestTelegram, int RequestLen, int option);
```

혹은 개발 가이드를 본다. 개발에 필요한 함수는 승인 요청을 테스트하기 위해서 `Ksnetcomm.dll`의 `KSCATApproval`뿐이다.
<br>
![image](https://github.com/user-attachments/assets/956d4d0d-3fe4-481a-9097-a733226f4ea4)

나온**파라미터**에 따라서 타입을 지정한다. 
```dart
typedef KSCATApprovalFunc = ffi.Long Function(
    ffi.Pointer<ffi.Uint8>,
    ffi.Pointer<Utf8>,
    ffi.Int32,
    ffi.Pointer<Utf8>,
    ffi.Int32,
    ffi.Int32,
);
typedef KSCATApproval = int Function(
    ffi.Pointer<ffi.Uint8>,
    ffi.Pointer<Utf8>,
    int,
    ffi.Pointer<Utf8>,
    int,
    int,
);
```
ffi의 `lookupFunction`을 사용하기 위해서 `KSCATApprovalFunc`과 `KSCATApproval` 2개로 정의했고, `KSCATApprovalFunc`은 C function, `KSCATApproval`은 Dart function 이다.



```dart
  late KSCATApproval _kscatApproval;

  void setUpFFI() {
    final libPath = path.join(Directory.current.path, "ksnetcomm.dll");
    final lib = ffi.DynamicLibrary.open(libPath);
    _kscatApproval = lib.lookupFunction<KSCATApprovalFunc, KSCATApproval>('KSCATApproval');
  }
```
위와 같이 `ffi`로 DLL의 함수를 읽어 Dart Type으로 저장한다.





### Ref.
1. [KSNET 자료실](https://www.ksnet.co.kr/Bbs/Details/?id=2672&ci=PDS)
   - Flutter에서는 64bit만 지원하여 64bit의 dll은 따로 요청이 필요하다
