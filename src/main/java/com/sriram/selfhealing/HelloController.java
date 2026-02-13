package com.sriram.selfhealing;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class HelloController {
    @GetMapping("/")
    public String home() {
        return "Self-Healing Java Microservice is Running!";
    }
}