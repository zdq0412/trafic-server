package com.jxqixin.trafic.config;
import com.alibaba.fastjson.JSON;
import com.jxqixin.trafic.model.JsonResult;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
/**
 * ajax未登陆请求，返回json信息
 */
@Component
public class UnauthorizedEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        JsonResult result = new JsonResult(false,"用户未登陆");
        httpServletResponse.setContentType("text/json;charset=utf-8");
        httpServletResponse.setHeader("Access-Control-Allow-Origin", "*");
        httpServletResponse.getWriter().write(JSON.toJSONString(result));
    }
}
