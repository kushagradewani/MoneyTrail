package com.grownited.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalController {

    @ModelAttribute
    public void setActivePage(Model model, HttpServletRequest request) {

        String uri = request.getRequestURI(); // e.g., /categoryList
        String page = uri.substring(uri.lastIndexOf("/") + 1); // categoryList

        if(page.equals("") || page.equals("/")) {
            page = "dashboard";
        }

        switch(page) {
            case "index.html":
                page = "dashboard";
                break;
            case "404.html":
                page = "404";
                break;
            case "blank.html":
                page = "blank";
                break;
            case "login":
            case "signin":
                page = "login";
                break;
            case "signup":
                page = "signup";
                break;
            default:
                // keep page as-is
        }

        model.addAttribute("activePage", page);
    }
}