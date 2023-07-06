package com.fullstackfox.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
@ComponentScan(basePackages = "com.fullstackfox.controllers")
@ComponentScan(basePackages = "com.fullstackfox.entities")
@ComponentScan(basePackages = "com.fullstackfox.requests")
@ComponentScan(basePackages = "com.fullstackfox.services")
@ComponentScan(basePackages = "com.fullstackfox.repositories")
public class OpenApiConfig {
    @Bean
    public OpenAPI usersMicroserviceOpenAPI() {
        return new OpenAPI()
                .info(new Info().title("Your API Title")
                                 .description("Your API Description")
                                 .version("1.0"));
    }
}
