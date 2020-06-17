package com.jxqixin.trafic.config;
import com.jxqixin.trafic.handler.CustomizeAuthenticationFailHandler;
import com.jxqixin.trafic.handler.CustomizeAuthenticationSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.web.cors.CorsUtils;
@Configuration
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	@Qualifier("userInfoService")
	private UserDetailsService userInfoService;
	@Autowired
	private CustomizeAuthenticationFailHandler customizeAuthenticationFailHandler;
	@Autowired
	private CustomizeAuthenticationSuccessHandler customizeAuthenticationSuccessHandler;
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		// 设置默认的加密方式（强hash方式加密）
		return new BCryptPasswordEncoder();
	}

	@Autowired
	public AuthenticationEntryPoint authenticationEntryPoint;
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.formLogin().successHandler(customizeAuthenticationSuccessHandler)
				.failureHandler(customizeAuthenticationFailHandler);
		http.authorizeRequests().anyRequest().authenticated()
		.and().csrf().disable().cors();
		http.headers().frameOptions().sameOrigin();
		//解决跨域访问问题
		ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry = http.authorizeRequests(); 
		//registry.requestMatchers(CorsUtils::isPreFlightRequest).permitAll();//让Spring security放行所有preflight
//		registry.antMatchers("/**").permitAll();
		http.exceptionHandling().authenticationEntryPoint(authenticationEntryPoint);
	}
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userInfoService)
				.passwordEncoder(new BCryptPasswordEncoder());
	}
}
