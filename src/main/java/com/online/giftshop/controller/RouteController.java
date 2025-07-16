package com.online.giftshop.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RouteController {

    // Catch-all for client-side routes (e.g., /dashboard, /login)
    @RequestMapping(value = { "/", "/{path:[^\\.]*}", "/**/{path:[^\\.]*}" })
    public String redirect() {
        return "forward:/index.html";
    }
}

