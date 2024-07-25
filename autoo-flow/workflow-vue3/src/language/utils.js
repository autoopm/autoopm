export default {
    /**
     * 语言类型
     */
    languageTypes: {
        "cn": "简体中文",
        "en": "English",
        "tc": "繁體中文",
    },

    /**
     * 替换(*)遍历
     * @param text
     * @param objects
     * @returns {*}
     */
    replaceArgumentsLanguage(text, objects) {
        let j = 1;
        while (text.indexOf("(*)") !== -1) {
            if (typeof objects[j] === "object") {
                text = text.replace("(*)", "");
            } else {
                text = text.replace("(*)", objects[j]);
            }
            j++;
        }
        return text;
    },

    /**
     * 译文转义
     * @param val
     * @returns {string|*}
     */
    replaceEscape(val) {
        if (!val || val == '') {
            return '';
        }
        return val.replace(/\(\*\)/g, "~%~").replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&').replace(/~%~/g, '(.*?)');
    },

    // 获取参数
    getParams(paraName) {
        var url = document.location.toString();
        var arrObj = url.split("?");
        if (arrObj.length > 1) {
            var arrPara = arrObj[1].split("&");
            var arr;
            for (var i = 0; i < arrPara.length; i++) {
                arr = arrPara[i].split("=");
                if (arr != null && arr[0] == paraName) {
                    return arr[1];
                }
            }
            return "";
        }else {
            return "";
        }
    },

    /**
     * 获取语言
     * @returns {string}
     */
    getLanguage() {
        let lang;
        if(!this.getParams('lang')){
            lang = window.localStorage.getItem("__language:type__")
            if (typeof lang === "string" && typeof this.languageTypes[lang] !== "undefined") {
                return lang;
            }
        }
        let navLang = (this.getParams('lang') || (window.navigator.language || navigator.userLanguage) + "").toLowerCase();
        switch (navLang) {
            case "zh":
            case "cn":
            case "zh-cn":
                lang = 'cn'
                break;
            case "zh-tw":
            case "zh-tr":
            case "zh-hk":
            case "zh-cnt":
            case "zh-cht":
                lang = 'tc'
                break;
            default:
                if (typeof this.languageTypes[navLang] !== "undefined") {
                    lang = navLang
                }
                break;
        }
        window.localStorage.setItem("__language:type__", lang)
        return lang
    }
}
