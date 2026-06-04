var oUtil = {
    doc: document || window.document || document.all,
    isArray: function (o) {
        if (Object.prototype.toString.call(o) == "[object Array]") {
            return true;
        } else {
            return false;
        }
    },
    isBoolean: function (o) {
        return typeof o === 'boolean';
    },
    isFunction: function (o) {
        return typeof o === 'function';
    },
    isHTMLElement: function (o) {
        if (this.isObject(o) || this.isFunction(o)) {
            if (o.nodeName) {
                return true;
            }
        }
        return false;
    },
    isNull: function (o) {
        return o === null || this.trim(o) === "" || typeof o === 'undefined' || this.trim(o) === "undefined";
    },
    isNumber: function (o) {
        return typeof o === 'number' && isFinite(o);
    },
    isObject: function (o) {
        return (o && (typeof o === 'object' || L.isFunction(o))) || false;
    },
    isString: function (o) {
        return typeof o === 'string';
    },
    isUndefined: function (o) {
        return typeof o === 'undefined';
    },
    isValue: function (o) {
        var L = this;
        return (L.isObject(o) || L.isString(o) || L.isNumber(o) || L.isBoolean(o));
    },
    ltrim: function (s) {
        if (!this.isString(s)) {
            return null;
        }
        return s.replace(/\s*((\S+\s*)*)/, "$1");
    },
    rtrim: function (s) {
        if (!this.isString(s)) {
            return null;
        }
        return s.replace(/((\s*\S+)*)\s*/, "$1");
    },
    trim: function (s) {
        if (!this.isString(s)) {
            return null;
        }
        return this.ltrim(this.rtrim(s));
    },
    isEmpty: function (o) {
        if ((typeof o != "undefiend") && (o.length > 0)) {
            return false;
        } else {
            return true;
        }
    }
};

function makeKeyWord(keyWord, likeKey) {
    if (false) {
        if (likeKey == "C") {
            keyWord = "%" + keyWord + "%";
        } else if (likeKey == "S") {
            keyWord = keyWord + "%";
        } else if (likeKey == "E") {
            keyWord = "%" + keyWord;
        }
    }
    return keyWord;
}

function replaceAll(str, exStr, chStr) {
	if(!oUtil.isNull(str)){
		return str.split(exStr).join(chStr);
	}	
}

function makeStringParameter(sObject, bEncoding) {
    var sParamDelimeter = "&";
    var sValueDelimeter = "=";
    if (bEncoding == null) {
        bEncoding = false;
    }
    var arrParam = new Array();
    var sKey;
    var svalue;
    for (var key in sObject) {
        if (key in sObject.constructor.prototype) {
            continue;
        }
        var value = sObject[key];
        if (bEncoding) {
            sKey = encodeURIComponent(key);
            svalue = encodeURIComponent(value);
        } else {
            sKey = key;
            svalue = value;
        }
        arrParam.push(sKey + sValueDelimeter + svalue);
    }
    var returnValue = arrParam.join(sParamDelimeter);
    
    return returnValue;
};

function findPosX(obj) {
    var curleft = 0;
    if (obj.offsetParent)
        while (1) {
            curleft += obj.offsetLeft;
            if (!obj.offsetParent) break;
            obj = obj.offsetParent;
        } else if (obj.x) curleft += obj.x;
    return curleft;
}

function findPosY(obj) {
    var curtop = 0;
    if (obj.offsetParent)
        while (1) {
            curtop += obj.offsetTop;
            if (!obj.offsetParent) break;
            obj = obj.offsetParent;
        } else if (obj.y) curtop += obj.y;
    return curtop;
}



function IsPositiveInt(string) {
    if (string == "") return false;
    else
        for (var i = 0; i < string.length; i++)
            if (isNaN(parseInt(string.charAt(i)))) return false; 
    return true;
}

function CheckLeapYear(intYear) {
    if (((intYear % 4 == 0) && !(intYear % 100 == 0)) || (intYear % 400 == 0)) return true;
    else return false;
}

function CheckDateValidation(string) {
    var errCode = -1;
    if (string.length != 8 || !IsPositiveInt(string)) errCode = -1;
    else {
        errCode = 1;
        var yyyy = parseInt(string.substring(0, 4), 10);
        var mm = parseInt(string.substring(4, 6), 10);
        var dd = parseInt(string.substring(6, 8), 10);
        if (yyyy == 0 || mm == 0 || dd == 0 || mm > 12 || dd > 31) errCode = 0;
        else if (mm == 2) {
            if (CheckLeapYear(yyyy)) {
                if (dd > 29) errCode = 0;
            } else {
                if (dd > 28) errCode = 0;
            }
        } else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) errCode = 0;
    }
    if (errCode == 1) {
        return true;
    } else if (errCode == -1) {
        return false;
    } else return false;
}

function CheckDateValidationYYYYMM(string) {
    var errCode = -1;
    if (string.length != 6 || !IsPositiveInt(string)) errCode = -1;
    else {
        errCode = 1;
        var yyyy = parseInt(string.substring(0, 4), 10);
        var mm = parseInt(string.substring(4, 6), 10);
        if (yyyy == 0 || mm == 0 || mm > 12) errCode = 0;
    }
    if (errCode == 1) {
        return true;
    } else if (errCode == -1) {
        return false;
    }
}

function charByteSize(ch) {
    if (ch == null || ch.length == 0) {
        return 0;
    }
    var charCode = ch.charCodeAt(0);
    if (charCode <= 0x00007F) {
        return 1;
    } else if (charCode <= 0x0007FF) {
        return 2;
    } else if (charCode <= 0x00FFFF) {
        return 3;
    } else {
        return 4;
    }
}

function isHangul(value) {
    var rgEx = /^[\uac00-\ud7a3]*$/g;
    var checker = rgEx.exec(value);
    if (checker) {
        return true;
    } else {
        return false;
    }
}

function stringByteSize(str) {
    if (str == null || str.length == 0) {
        return 0;
    }
    var size = 0;
    for (var i = 0; i < str.length; i++) {
        size += charByteSize(str.charAt(i));
    }
    return size;
}

function formatInteger(number) {
    if (oUtil.isNull(number)) return "";
    var num = number.toString().split(".");
    num[0] = num[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return num[0];
}

function formatNumber(number) {
    if (oUtil.isNull(number)) return "";
    var num = number.toString().split(".");
    num[0] = num[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return num.join(".");
}

function formatFloat(number, precision) {
    if (oUtil.isNull(number)) return "";
    var num = number.toString().split(".");
    var str1 = formatNumber(num[0]);
    var str2 = "";
    for (var i = 0; i < precision; i++) {
        if (oUtil.isNull(num[1])) {
            str2 += "0";
        } else {
            var p = num[1].charAt(i);
            if (!oUtil.isNull(p)) {
                str2 += p;
            } else {
                str2 += "0";
            }
        }
    }
    if (oUtil.isNull(str2)) {
        return str1;
    }
    return str1 + "." + str2;
}

function formatDate(value, delim) {
    if (oUtil.isNull(value)) return "";
    var d = null;
    if (value.tryNumber()) {
        if (value.length == 6) {
            d = value.substr(0, 4);
            d += delim + value.substr(4, 2);
        } else if (value.length == 8) {
            d = value.substr(0, 4);
            d += delim + value.substr(4, 2);
            d += delim + value.substr(6, 2);
        }
    }
    if (oUtil.isNull(d)) {
        d = value;
    }
    return d;
}

function nullToString(value) {
    if (oUtil.isNull(value)) return "";
    else return value;
}

function changImage(obj, path) {
    obj.src = path;
}

function getMaxDataLength(data, textId) {
    var maxData = data[0][textId].length;
    for (var i = 0; i < data.length; i++) {
        var char = data[i][textId];
        var size = getStringPixelWidth(char);
        if (maxData < size) {
            maxData = size;
        }
    }
    return maxData;
}

function getStringPixelWidth(string_value) {
	if(oUtil.isNull(string_value)) return;
	
    var ascii_code;
    var string_value_length = string_value.length;
    var character;
    var character_width = 0;
    var total_width = 0;
    var special_char_size = 9;
    var multibyte_char_size = 14;
    var base_char_start = 32;
    var base_char_end = 127;
    var ascii_char_size = Array(5, 5, 5, 7, 7, 10, 9, 5, 6, 6, 7, 7, 5, 7, 5, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 5, 5, 9, 7, 9, 7, 12, 9, 9, 10, 9, 9, 8, 10, 9, 3, 7, 9, 8, 11, 10, 10, 9, 10, 9, 9, 9, 9, 9, 10, 9, 9, 9, 7, 11, 7, 7, 7, 5, 8, 8, 8, 8, 8, 3, 8, 8, 3, 3, 7, 3, 11, 8, 8, 8, 8, 5, 8, 3, 8, 7, 10, 8, 8, 8, 7, 7, 7, 10, 7);
    for (var i = 0; i < string_value_length; i++) {
        character = string_value.substring(i, (i + 1));
        ascii_code = character.charCodeAt(0);
        if (ascii_code < base_char_start) {
            character_width = special_char_size;
        } else if (ascii_code <= base_char_end) {
            idx = ascii_code - base_char_start;
            character_width = ascii_char_size[idx];
        } else if (ascii_code > base_char_end) {
            character_width = multibyte_char_size;
        }
        total_width += character_width;
    }
    return total_width;
}

function setCookie(name, value, path, domain, secure, expires) {
    if (typeof (expires) == "undefined" || expires == null) {
        expires = new Date();
        expires.setMonth(expires.getMonth() + 1);
    }
    document.cookie = name + "=" + escape(value) + ((expires) ? "; expires=" + expires.toGMTString() : "") + ((path) ? "; path=" + path : "") + ((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
}

function getCookie(name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while (i < clen) {
        var j = i + alen;
        if (document.cookie.substring(i, j) == arg) return getCookieVal(j);
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0) break;
    }
    return null;
}

function getCookieVal(offset) {
    var endstr = document.cookie.indexOf(";", offset);
    if (endstr == -1) endstr = document.cookie.length;
    return unescape(document.cookie.substring(offset, endstr));
}

// textarea <br>, &nbsp 변환
// atom
function setTextareaConvert(str) {
  str = str.replace(/\n/gi, "<br>"); 
  str = str.replace(/ /gi,"&nbsp;");

  return str;
}

function getTextareaConvert(str) {
  str = str.replace(/<br>/gi, "\n"); 
  str = str.replace(/&nbsp;/gi," ");
  return str;
}


/**
 * Json Array의 중복을 제거합니다. 
 * @param arr
 * @returns
 */
function arrUnique(arr) {
    var cleaned = [];
    arr.forEach(function(itm) {
        var unique = true;
        cleaned.forEach(function(itm2) {
            if (_.isEqual(itm, itm2)) unique = false;
        });
        if (unique)  cleaned.push(itm);
    });
    return cleaned;
}

/**
 * Json 의 값을 검색함
 * ex) getObjects(TestObj, 'id', 'A'); // Returns an array of matching objects
 * @param obj
 * @param key
 * @param val
 * @returns
 */
function getObjects(obj, key, val) {
    var objects = [];
    for (var i in obj) {
        if (!obj.hasOwnProperty(i)) continue;
        if (typeof obj[i] == 'object') {
            objects = objects.concat(getObjects(obj[i], key, val));
        } else if (i == key && obj[key] == val) {
            objects.push(obj);
        }
    }
    return objects;
}


/**
 * 화면에서 키보드로 백스페이스 및 F5, Ctrl+r키 막기, ESC Key 누르면 Dailog창 닫기
 * @param e 키보드 이벤트 객체
 
$(this).keydown(function (e) {
    var components = ["text", "textarea", "combobox", "password"];
    var breakYn = false;
   
    for(var i = 0; i < components.length; i++) {
        if(components[i] == event.srcElement.type) {
            breakYn = true;
        }
    }
    
    
    // F5(116), Esc(27), Alt(18), Ctrl+N(78), Ctrl+R(82), backspace(8), 
    if(!breakYn) {
        //if(event.keyCode == 116) {
        //    event.keyCode = 505;
        //    event.cancelBubble = true;        
        //    event.returnValue =false;
        //}
        if(event.ctrlKey && (event.keyCode == 78 || event.keyCode ==82)) {
            return false;
        }
        if(event.keyCode == 8) {
            return false;
        }
        if(event.keyCode == 122) {
            event.keyCode = 505;
            event.cancelBubble = true;        
            event.returnValue =false;
        }
        if(event.keyCode == 27) {
            return false;
        }
        if (event.keyCode == 505) {
            return false;
        }
    }
});
*/
//$(window).load(function() { // window 로드후에 실행됨
//    if (typeof (window["fncOnload"]) == "function") {
//        // 함수호출
//            window["fncOnload"]();
//    }
//});

var windowControlClass = function() {
    this.defaultModalStyle = "center:yes;help:no;resizable:no;status:no;scroll:no;";
    this.defaultSimpleStyle = "status=no,resizable=no,scrollbars=no,status=no,toolbar=no,titlebar=no";
    
    this.Modal = function (sUrl,oParams,arrRect,sFeatures) {
        var sLeft = arrRect[0].toString().trim();
        var sTop = arrRect[1].toString().trim();
        var sWidth = arrRect[2].toString().trim();
        var sHeight = arrRect[3].toString().trim();

        var sRect = "";
        sRect += (sWidth.isEmpty()) ? "" : "dialogWidth:" + sWidth + ";";
        sRect += (sHeight.isEmpty()) ? "" : "dialogHeight:" + sHeight + ";";
        sRect += (sLeft.isEmpty()) ? "" : "dialogLeft:" + sLeft + ";";
        sRect += (sTop.isEmpty()) ? "" : "dialogTop:" + sTop + ";";

        sFeatures = sRect + sFeatures;
        
        var urlAndData = sUrl.split("?");
        var url = urlAndData[0];
        var dataList;
        var inDataSetYn = "N";
        var blankUrl = "/origin/inDataSetBlankPopup.do";
        var param = "";
        if(urlAndData.length > 1) {
            dataList = urlAndData[1].split("&");
            for(var i=0; i < dataList.length; i++) {
                var data = dataList[i].split("=");
                var key;
                var value;
                if(data.length > 1) {
                    key = data[0];
                    value = data[1];
                }
                if(key == "inDataSet") {
                    inDataSetYn = "Y";
                } else {
                    param += "&" + key + "=" + value;
                }
            }
            param = param.substring(1, param.length);
            param += "&"+ "realUrl="+url;
        }

        if(inDataSetYn == "Y") {
            var oReturnValue = window.showModalDialog(blankUrl + "?" + param,oParams,"" + sFeatures);
        } else {
            var oReturnValue = window.showModalDialog(sUrl,oParams,"" + sFeatures);
        }
        
        return oReturnValue;
    };
    
    this.Modaless = function (sUrl,oParams,arrRect,sFeatures) {
        var sLeft = arrRect[0].toString().trim();
        var sTop = arrRect[1].toString().trim();
        var sWidth = arrRect[2].toString().trim();
        var sHeight = arrRect[3].toString().trim();
        
        var sRect = "";
        sRect += (sWidth.isEmpty()) ? "" : "dialogWidth:" + sWidth + ";";
        sRect += (sHeight.isEmpty()) ? "" : "dialogHeight:" + sHeight + ";";
        sRect += (sLeft.isEmpty()) ? "" : "dialogLeft:" + sLeft + ";";
        sRect += (sTop.isEmpty()) ? "" : "dialogTop:" + sTop + ";";

        sFeatures = sRect + sFeatures;
        
        var oReturnValue = window.showModelessDialog(sUrl,oParams,"" + sFeatures);
        
        return oReturnValue;
    };
    
    this.DownloadFile = function (sUrl,sFileName) {
        sUrl = sUrl.nullValueEx("");
        sFileName = sFileName.nullValueEx("");
        
        if (sUrl.isEmpty()) {
            return false;
        }
        
        var sAction = "/origin/framework/controller/downloadFile.do";
        var sMethod = "post";
        var sTarget = "_self";
        var sFormId = "temporaryForm";
        
        var sFileNameId = "fileName";
        var sOriginalFileNameId = "originalFileName";
        
        oForm = document.createElement("<form></form>");
        oForm.id = sFormId;
        oForm.method = sMethod;
        oForm.action = sAction;
        oForm.target = sTarget;
        
        var oParam1 = document.createElement("<input type='hidden' name='" + sFileNameId + "'>");
        oParam1.value = sUrl;
        oForm.appendChild(oParam1);
        
        var oParam2 = document.createElement("<input type='hidden' name='" + sOriginalFileNameId + "'>");
        oParam2.value = sFileName;
        oForm.appendChild(oParam2);
        
        document.body.appendChild(oForm);
        
        oForm.submit();
        
        oForm.parentNode.removeChild(oForm);
        oForm = null;
        
        return true;
    };
    
    this.DownloadDBFile = function (sCooCertifyNo,sVendorCode,sDivisionCode,sFileName) {
        sFileName = sFileName.nullValueEx("");
        
        sDivisionCode = sDivisionCode.nullValueEx("");
        sVendorCode = sVendorCode.nullValueEx("");
        sCooCertifyNo = sCooCertifyNo.nullValueEx("");
        
        var sAction = "/origin/compliance/coomgt/selectExtCooCertifyFile.do";
        var sMethod = "post";
        var sTarget = "_self";
        var sFormId = "temporaryForm";
        
        var sFileNameId = "fileName";
        var sOriginalFileNameId = "originalFileName";
        
        oForm = document.createElement("<form></form>");
        oForm.id = sFormId;
        oForm.method = sMethod;
        oForm.action = sAction;
        oForm.target = sTarget;
        
        var oParam1 = document.createElement("<input type='hidden' name='COO_CERTIFY_NO'>");
        oParam1.value = sCooCertifyNo;
        oForm.appendChild(oParam1);

        var oParam3 = document.createElement("<input type='hidden' name='VENDOR_CODE>");
        oParam3.value = sVendorCode;
        oForm.appendChild(oParam3);
        
        var oParam4 = document.createElement("<input type='hidden' name='DIVISION_CODE'>");
        oParam4.value = sDivisionCode;
        oForm.appendChild(oParam4);
        
        var oParam5 = document.createElement("<input type='hidden' name='FILE_NAME'>");
        oParam5.value = sFileName;
        oForm.appendChild(oParam5);
        /*
        var oParam2 = document.createElement("<input type='hidden' name='" + sOriginalFileNameId + "'>");
        oParam2.value = sFileName;
        oForm.appendChild(oParam2);
        */
        document.body.appendChild(oForm);
        
        oForm.submit();
        
        oForm.parentNode.removeChild(oForm);
        oForm = null;
        
        return true;
    };
    
    this.DownloadEdocDBFile = function (sReferenceId,sVendorCode,sDivisionCode,sFileName, sDataUrl) {
        sFileName = sFileName.nullValueEx("");
        sReferenceId = sReferenceId.nullValueEx("");
        
        var sAction = sDataUrl;
        var sMethod = "post";
        var sTarget = "_self";
        var sFormId = "temporaryForm";
        
        var sFileNameId = "fileName";
        var sOriginalFileNameId = "originalFileName";
        
        oForm = document.createElement("<form></form>");
        oForm.id = sFormId;
        oForm.method = sMethod;
        oForm.action = sAction;
        oForm.target = sTarget;
        var oParam1 = document.createElement("<input type='hidden' name='REFERENCE_ID'>");
        oParam1.value = sReferenceId;
        oForm.appendChild(oParam1);

        var oParam2 = document.createElement("<input type='hidden' name='COPY_FILE_NAME'>");
        oParam2.value = sFileName;
        oForm.appendChild(oParam2);

        document.body.appendChild(oForm);
        
        oForm.submit();
        
        oForm.parentNode.removeChild(oForm);
        oForm = null;
        
        return true;
    };
    
    this.Post = function (sUrl,sParams,sTarget,bEncoded) {
        sUrl = sUrl.nullValueEx("");
        sParams = sParams.nullValueEx("");
        //sTarget = sTarget.nullValueEx("").emptyValue("_self");
        bEncoded = bEncoded.nullValueEx(true);
        
        if (sUrl.isEmpty()) {
            return false;
        }
        
        var sAction = sUrl;
        var sMethod = "post";
        
        var oForm;
        oForm = document.createElement("form");
        oForm.method = sMethod;
        oForm.action = sAction;
        oForm.target = sTarget;
        
        var arrParam = sParams.split("&");
        
        for(var i = 0;i < arrParam.length;i++) {
            var arrKeyValue = arrParam[i].split("=");
            var oHidden = document.createElement("input");
            oHidden.type = "hidden";
            if (bEncoded) {
                oHidden.name = decodeURIComponent(arrKeyValue[0]);
                oHidden.value = decodeURIComponent(arrKeyValue[1]);
            }
            else {
                oHidden.name = arrKeyValue[0];
                oHidden.value = arrKeyValue[1];
            }
            
            oForm.appendChild(oHidden);
        }
        
        document.body.appendChild(oForm);
        
        oForm.submit();
        
        return true;
    };
    
    this.ShowMessage = function (sMessage) {
        alert(sMessage);
    };
    
    this.ShowInfomation = function (sMessage) {
        alert(sMessage);
    };
    
    this.ShowError = function (sMessage) {
        alert("ERROR:" + CHARS.CR + sMessage);
    };
    
    this.Wait = function (bWait) {
        bWait = bWait.nullValueEx(false);

        var sDivId = "divWait";
        var oDiv = document.getElementById(sDivId);

        if (true == bWait) {
            if (isNullOrUndefined(oDiv)) {
                oDiv = document.createElement("div");
                oDiv.id = sDivId;
                document.body.appendChild(oDiv);
            }
            
            document.body.style.cursor = "wait"
        }
        else if (!isNullOrUndefined(oDiv)) {
            oDiv.parentNode.removeChild(oDiv);
            document.body.style.cursor = "default";
        }
        
        return;
    };
    
    this.DelayedCall = function (iMiliSec,func,arrParam) {
        iMiliSec = iMiliSec.nullValueEx(100);
        
        if (isNullOrUndefined(arrParam) || !isArray(arrParam)) {
            arrParam = [];
        }
        
        var funcBinded = Function.prototype.bind.apply(func,[null].concat(arrParam));
        window.setTimeout(funcBinded,iMiliSec);
    };
    
    this.DoWait = function (func) {
        WINDOW.Wait(true);
        var funcWait = function () { func.apply(this,arguments.toArray()); WINDOW.Wait(false); };
        WINDOW.DelayedCall(100,funcWait,arguments.toArray().slice(1));
    };
    
    
    
};

var WINDOW = new windowControlClass();