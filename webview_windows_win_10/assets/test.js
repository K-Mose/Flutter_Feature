console.log("start app");

// SEND DATA TO FLUTTER
function sendDataToFlutter() {
    var successJson = {
                "status": "success",
                "data": {
                  "message": "API request successful.",
                  "result": {
                    "packet": "123456",
                    "status": "asdasd"
                  }
                }
              }
    window.chrome.webview.postMessage(successJson);
}

function sendErrorMessageToFlutter() {
    var errorJson = {
                      "status": "error",
                      "error": {
                        "code": 404,
                        "message": "Resource not found."
                      }
                    }
    window.chrome.webview.postMessage(errorJson);
}
// LISTEN DATA FROM FLUTTER
window.chrome.webview.addEventListener('message', function(e) {
 alert("messagereceived: " + JSON.stringify(e.data));
});

'{'+
'  "name": "PrintReceipt"'+
'  "data": {'+
'    "wating_number": "1",'+
'    "receipt_number": "0123456789",'+
'    "brand": "상호명",'+
'    "business_number": "1234567890",'+
'    "phone": "02-1234-5678",'+
'    "president": "대표",'+
'    "address": "주소",'+
'    "table_number": "1",'+
'    "menu": ['+
'      {'+
'        "name": "메뉴이름",'+
'        "quantity": 1,'+
'        "price": 10000,'+
'        "discount": 0,'+
'      },'+
'      {'+
'        "name": "메뉴이름",'+
'        "quantity": 1,'+
'        "price": 9000,'+
'        "discount": 1000,'+
'      }'+
'    ],'+
'    "total": "19,000",'+
'    "charge": "담당자",'+
'    "approval": "승인번호",'+
'    "bottom": "하단문구",'+
'  }'+
'}'

let msg = '{'+
'  "name": "PRINT_RECEIPT",'+
'  "data": {'+
'    "waiting_number": "1",'+
'    "receipt_number": "0123456789",'+
'    "brand": "상호명",'+
'    "business_number": "1234567890",'+
'    "phone": "02-1234-5678",'+
'    "president": "대표",'+
'    "address": "주소",'+
'    "table_number": "1",'+
'    "menu": ['+
'      {'+
'        "name": "메뉴이름",'+
'        "quantity": 1,'+
'        "price": 10000,'+
'        "discount": 0'+
'      },'+
'      {'+
'        "name": "메뉴이름",'+
'        "quantity": 1,'+
'        "price": 9000,'+
'        "discount": 1000'+
'      }'+
'    ],'+
'    "cost": "18,100",'+
'    "vat": "1,900",'+
'    "service": "0",'+
'    "total": "19,000",'+
'    "charge": "담당자",'+
'    "approval": "승인번호",'+
'    "bottom": "하단문구 안녕하세요. [newline]스마트오더를 이용해주시는 사용자 분들께 2023년 9월 18일 진행된 정기 업데이트 내역 및 변동 사항을 안내드립니다.[newline]국회에 제출된 법률안 기타의 의안은 회기중에 의결되지 못한 이유로 폐기되지 아니한다. 다만, 국회의원의 임기가 만료된 때에는 그러하지 아니하다. 누구든지 체포 또는 구속을 당한 때에는 즉시 변호인의 조력을 받을 권리를 가진다. [newline]다만, 형사피고인이 스스로 변호인을 구할 수 없을 때에는 법률이 정하는 바에 의하여 국가가 변호인을 붙인다.[newline]의무교육은 무상으로 한다. 재의의 요구가 있을 때에는 국회는 재의에 붙이고, 재적의원과반수의 출석과 출석의원 3분의 2 이상의 찬성으로 전과 같은 의결을 하면 그 법률안은 법률로서 확정된다."'+
'  }'+
'}'