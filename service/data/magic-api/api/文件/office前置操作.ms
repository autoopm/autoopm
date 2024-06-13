{
  "properties" : { },
  "id" : "e1380722a6f442f6b1380fb5cb245806",
  "script" : null,
  "groupId" : "fbe74c5bc9f04c308679a525a09005a6",
  "name" : "office前置操作",
  "createTime" : null,
  "updateTime" : 1718288307774,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/preUrl",
  "method" : "GET",
  "parameters" : [ {
    "name" : "documentUrl",
    "value" : "2024-06-10%2F37af42bf7f604791b6ae5c9c7bc4b357.xlsx",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ {
    "name" : "token",
    "value" : "fbd216e7-a6a3-4823-93b8-c25395646605",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 200,\n    \"message\": \"success\",\n    \"data\": {\n        \"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkb2N1bWVudCI6eyJ1cmwiOiJodHRwOi8vMTkyLjE2OC4xMDAuMTM0OjkwMDAvYXV0b28vMjAyNC0wNi0xMCUyNTJGMzdhZjQyYmY3ZjYwNDc5MWI2YWU1YzljN2JjNGIzNTcueGxzeD9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPWF1dG9vJTJGMjAyNDA2MTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNjEzVDA4MzE1NlomWC1BbXotRXhwaXJlcz02MDQ4MDAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JlgtQW16LVNpZ25hdHVyZT0zNzk2NmMwMzliZDg3MmI0ZWRlNmViZmE0NWFkMjNhODQ2ZTg1ZWQyN2JiNjE4MDA0NjUyN2Q3ZTg4MWRkZTI1In0sImVkaXRvckNvbmZpZyI6eyJ1c2VyIjp7fX0sImV2ZW50cyI6e319.Uemd04kQ010w1X5wCJcvJ691zTVP0PzKTJZtFJre9PE\",\n        \"url\": \"http://192.168.100.134:9000/autoo/2024-06-10%252F37af42bf7f604791b6ae5c9c7bc4b357.xlsx?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=autoo%2F20240613%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240613T083156Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=37966c039bd872b4ede6ebfa45ad23a846e85ed27bb6180046527d7e881dde25\"\n    },\n    \"timestamp\": 1718267516766,\n    \"executeTime\": 108\n}",
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "200",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "success",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "token",
        "value" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkb2N1bWVudCI6eyJ1cmwiOiJodHRwOi8vbG9jYWxob3N0OjkwMDAvYXV0b28vMjAyNC0wNi0xMCUyNTJGMzdhZjQyYmY3ZjYwNDc5MWI2YWU1YzljN2JjNGIzNTcueGxzeD9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPWF1dG9vJTJGMjAyNDA2MTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNjEzVDA4MjM1OVomWC1BbXotRXhwaXJlcz02MDQ4MDAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JlgtQW16LVNpZ25hdHVyZT1lNDI1NjBjNTA3NDFiMjQzNTg0NzhiYTM0ZmRlNDA1MzViZDU2OGM5NjIyMjQxNGY4ZTBhNmNjYzE5N2I0NDkxIn0sImVkaXRvckNvbmZpZyI6eyJ1c2VyIjp7fX0sImV2ZW50cyI6e319.AlSTE17dTnRUQf5gH2nbLOe15ctTx8HVEftfz1uzw4E",
        "description" : "",
        "required" : false,
        "dataType" : "String",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      }, {
        "name" : "url",
        "value" : "http://localhost:9000/autoo/2024-06-10%252F37af42bf7f604791b6ae5c9c7bc4b357.xlsx?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=autoo%2F20240613%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240613T082359Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=e42560c50741b24358478ba34fde40535bd568c96222414f8e0a6ccc197b4491",
        "description" : "",
        "required" : false,
        "dataType" : "String",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1718267039802",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "192",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
import org.ssssssss.magicboot.utils.MinioUtil;
import cn.hutool.jwt.JWTUtil;
import log

var secret = "KrGjwbMl00gy70BYQvyi"
var config = {
    "document": {
        "fileType": documentFileType,
        "title": documentTitle,
        "key": documentKey,
        "url": documentUrl
    },
  //  "documentType": documentType,
    "editorConfig": {
        "mode": editorConfigMode,
        "callbackUrl": editorConfigCustomizationCallbackUrl,
        "lang": editorConfigLang,
        "user": {
            "id": editorConfigUserId,
            "name": editorConfigUserName
        },
    },
    "events": {
        "onDocumentReady": eventsOnDocumentReady
    }
};

var token = JWTUtil.createToken(config, secret.getBytes())
return {
    token: token,
}
