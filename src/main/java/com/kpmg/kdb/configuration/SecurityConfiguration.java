package com.kpmg.kdb.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.header.writers.StaticHeadersWriter;


@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.sessionManagement()
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
                .expiredUrl("/loginform")
                .sessionRegistry(sessionRegistry());

        //HTTP Strict Transport Security (HSTS)
        http.headers().httpStrictTransportSecurity().includeSubDomains(true).maxAgeInSeconds(31536000);
        
        //X-Frame-Option Deny
        http.headers().frameOptions().sameOrigin();

        
        //Content-Security-Policy
        http.headers()
    		.addHeaderWriter(new StaticHeadersWriter("X-Content-Security-Policy","default-src 'self'"))
    		.addHeaderWriter(new StaticHeadersWriter("X-WebKit-CSP","default-src 'self'"));
        
        http.csrf().ignoringAntMatchers("/common/**");

    }

    // logout 후 login할 때 정상동작을 위함
    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }
}
