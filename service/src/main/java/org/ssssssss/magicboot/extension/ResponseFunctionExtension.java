package org.ssssssss.magicboot.extension;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.ssssssss.magicapi.core.context.RequestContext;
import org.ssssssss.magicapi.core.servlet.MagicHttpServletRequest;
import org.ssssssss.magicapi.modules.servlet.ResponseModule;
import org.ssssssss.script.annotation.Comment;
import org.ssssssss.script.functions.ExtensionMethod;

import java.io.IOException;

@Component
public class ResponseFunctionExtension implements ExtensionMethod {

    @Override
	public Class<?> support() {
		return ResponseModule.class;
	}

	private HttpServletResponse getResponse() {
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		if (requestAttributes instanceof ServletRequestAttributes) {
			return ((ServletRequestAttributes) requestAttributes).getResponse();
		}
		return null;
	}

    @Comment("转发")
	public ResponseModule.NullValue dispatcher(ResponseModule responseModule, String url) throws ServletException, IOException {
		MagicHttpServletRequest magicHttpServletRequest = RequestContext.getHttpServletRequest();
		HttpServletRequest request = magicHttpServletRequest.getRequest();
		request.getRequestDispatcher(url).forward(request, getResponse());
		return responseModule.end();
	}

}
