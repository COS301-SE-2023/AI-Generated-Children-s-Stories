package com.fullstackfox.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Controller;

// import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication
@EnableJpaRepositories("com.fullstackfox.repositories")
@EntityScan("com.fullstackfox")
public class AiChildrensBookStoriesApplication {

	public static void main(String[] args) {
		SpringApplication.run(AiChildrensBookStoriesApplication.class, args);
	}
}
