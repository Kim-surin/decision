package com.kpmg.kdb;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class) 
@ImportResource("classpath*:config/applicationContext.xml")
public class KdbApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(KdbApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		System.out.println("========================================= KPMG Application Starting ========================================");
		return application.sources(KdbApplication.class);
	}

}
