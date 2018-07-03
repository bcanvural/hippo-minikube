package com.example.demo;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication implements ApplicationRunner {

    Logger log = LoggerFactory.getLogger(DemoApplication.class);

    private String uuid;

    @RequestMapping("/")
    String answer(){
        String response = "Back-atcha from: " + uuid;
        log.info(response);
        return response;
    }

    @RequestMapping("/information")
    String information(){
        return "Information endpoint invoked";
    }

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @Override
    public void run(final ApplicationArguments args) {
        uuid = UUID.randomUUID().toString();
    }
}
