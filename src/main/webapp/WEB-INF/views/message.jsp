<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
    String message = (String) request.getAttribute("message");
    if (message != null) {
        message = message.trim().replaceAll("\\s+", " "); 

        boolean isError = message.toLowerCase().matches(".*(failed|error|incorrect|invalid|try|not authorized|does not exist).*");
        String color = isError ? "red" : "green"; 
%>
        <span style="color: <%= color %>;"><%= message %></span>
<%
    }
%>



