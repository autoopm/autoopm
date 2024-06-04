package org.ssssssss.magicboot.model;

import org.ssssssss.magicapi.core.model.JsonBean;

public enum StatusCode {

    CERTIFICATE_EXPIRED(402, "凭证已过期"),
    FORBIDDEN(403, "禁止访问");

    StatusCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    private int code;

    private String message;

    public JsonBean json(){
        return new JsonBean<>(this.code, this.message);
    }

}
