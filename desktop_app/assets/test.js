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