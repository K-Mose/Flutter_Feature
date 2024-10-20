String messageConverter() {
  String STX = String.fromCharCode(2);
  String ETX = String.fromCharCode(3);
  String CR = String.fromCharCode(13);
  String FS = String.fromCharCode(28);

  String tempStr = "";

  String request_msg = "";
  request_msg = request_msg + STX;                                        // STX
  request_msg = request_msg + "MS";                                       // 거래구분
  request_msg = request_msg + "01";                                       // 업무구분
  request_msg = request_msg + "0420";                                     // 전문구분
  request_msg = request_msg + "N";                                        // 거래형태
  request_msg = request_msg + "DPT0TEST03";                              // 단말기번호 (테스트 단말기 번호/ 실제 단말기 번호는 대리점,KSNET영업부에 문의하세요)
  request_msg = request_msg + "    ";                                     // 업체정보. 그냥 space로 채우셔도 되지만, 가능한 가맹점을 나타낼 수 있으면 더 좋습니다.
  request_msg = request_msg + "000000000000";                             // 전문일련번호. 숫자로 아무거나 쓰셔도 되지만 가능한 거래 할 때마다 000001~999999까지의 일련번호를 발생시켜 주세요.
  request_msg = request_msg + " ";                                        // Pos Entry Mode
  request_msg = request_msg + ""; // txtVanTR.Text                              // 거래고유번호
  request_msg = request_msg + "                    ";                     // 암호화하지않은 카드번호
  request_msg = request_msg + " ";                                        // 암호화여부
  request_msg = request_msg + "################";                         // SW모델번호
  request_msg = request_msg + "################";                         // CAT or Reader 모델번호
  request_msg = request_msg + "                                        "; // 암호화정보
  request_msg = request_msg + "KSVTR                                ";    // 카드번호(Track2 Data)
  request_msg = request_msg + FS;                                         // FS
  request_msg = request_msg + "00";                                       // 할부개월수(원승인 할부개월과 동일하게 구성)
  request_msg = request_msg + "000000001004";                             // 총금액(원승인금액과 동일하게 구성)
  request_msg = request_msg + "000000000000";                             // 봉사료(원승인금액과 동일하게 구성)
  request_msg = request_msg + "000000000000";                             // 세금(원승인금액과 동일하게 구성)
  request_msg = request_msg + "000000000000";                             // 공급금액(원승인금액과 동일하게 구성)
  request_msg = request_msg + "000000000000";                             // 면세금액(원승인금액과 동일하게 구성)
  request_msg = request_msg + "  ";                                       // WorkingKey Index
  request_msg = request_msg + "                ";                         // 비밀번호
  request_msg = request_msg + ""; // "txtAuthNum.Text";                            // 원거래승인번호
  request_msg = request_msg + ""; // """txtAuthDate.Text";                           // 원거래승인일자
  request_msg = request_msg + tempStr.padLeft(163, ' ');                  // 사용자정보~DCC
  request_msg = request_msg + "X";                                        // 전자서명유무
  request_msg = request_msg + ETX;                                        // ETX
  request_msg = request_msg + CR;                                         // CR

  return request_msg;
}