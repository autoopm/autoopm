package org.ssssssss.magicboot.provider;

import cn.dev33.satoken.exception.DisableServiceException;
import org.springframework.stereotype.Component;
import org.ssssssss.magicapi.core.context.RequestEntity;
import org.ssssssss.magicapi.core.interceptor.ResultProvider;
import org.ssssssss.magicapi.core.model.JsonBean;

@Component
public class ExceptionResultProvider implements ResultProvider {

	@Override
	public Object buildResult(RequestEntity requestEntity, int code, String message, Object data) {
		long timestamp = System.currentTimeMillis();
        return new JsonBean<>(code, message, data, (int) (timestamp - requestEntity.getRequestTime()));
	}

	@Override
	public Object buildException(RequestEntity requestEntity, Throwable throwable) {
		if(throwable.getCause() instanceof DisableServiceException){
			return buildResult(requestEntity, 500, "此账号已被临时封禁，请联系管理员");
		}
		return buildResult(requestEntity, 500, "系统内部出现错误");
	}
}
