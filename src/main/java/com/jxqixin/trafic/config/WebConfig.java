package com.jxqixin.trafic.config;

import com.jxqixin.trafic.interceptors.AuthencationInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@Configuration
public class WebConfig extends WebMvcConfigurationSupport {
    @Autowired
    private AuthencationInterceptor authencationInterceptor;

    @Value("${uploadFile.urlMapping}")
    private String urlMapping;
    @Value("${uploadFile.resourceLocation}")
    private String resourceLocation;
    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(urlMapping).addResourceLocations("file:"+resourceLocation);
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/static/","classpath:/resources/",
                        "classpath:/public/");
        super.addResourceHandlers(registry);
    }
    @Override
    protected void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowCredentials(true)
                .allowedMethods("GET", "POST", "DELETE", "PUT")
                .maxAge(3600);
    }


    @Override
    protected void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authencationInterceptor).addPathPatterns("/**").excludePathPatterns("/login","/logout");
    }
}