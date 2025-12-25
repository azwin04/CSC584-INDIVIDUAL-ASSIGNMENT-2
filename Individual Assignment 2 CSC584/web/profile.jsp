<%-- 
    Document   : profile
    Created on : Dec 21, 2025, 7:19:37 PM
    Author     : nur azwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.ProfileBean" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Profile Saved Successfully</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Arial', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #e0f7ff 0%, #ffe6f2 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .profile-container {
                width: 100%;
                max-width: 500px;
                background-color: white;
                padding: 35px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(137, 207, 240, 0.2), 
                            0 5px 15px rgba(255, 182, 193, 0.15);
                border: 1px solid rgba(255, 255, 255, 0.5);
                position: relative;
            }

            .profile-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(to right, #89CFF0, #FFB6C1);
                border-radius: 15px 15px 0 0;
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
                padding-bottom: 15px;
                background: linear-gradient(to right, #89CFF0, #FFB6C1);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-size: 28px;
                position: relative;
            }

            h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 25%;
                width: 50%;
                height: 3px;
                background: linear-gradient(to right, #89CFF0, #FFB6C1);
                border-radius: 2px;
            }

            .success-message {
                text-align: center;
                padding: 15px;
                background: linear-gradient(45deg, #e8f7ff, #fff0f5);
                border-radius: 8px;
                margin-bottom: 25px;
                color: #4CAF50;
                font-weight: 600;
                border-left: 4px solid #4CAF50;
            }

            .profile-details {
                margin-bottom: 30px;
            }

            .profile-field {
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #f0f8ff;
                position: relative;
            }

            .field-label {
                display: block;
                margin-bottom: 6px;
                color: #555;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
            }

            .field-label::before {
                content: '✓';
                color: #FF69B4;
                font-size: 14px;
                font-weight: bold;
            }

            .field-value {
                color: #333;
                font-size: 16px;
                padding: 8px 12px;
                background-color: #f9fdff;
                border-radius: 6px;
                border-left: 3px solid #89CFF0;
                display: inline-block;
                width: 100%;
            }

            .action-links {
                text-align: center;
                margin-top: 30px;
                padding-top: 25px;
                border-top: 1px solid rgba(224, 247, 255, 0.8);
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .action-btn {
                display: inline-block;
                padding: 12px 25px;
                border-radius: 8px;
                font-weight: 600;
                text-decoration: none;
                text-align: center;
                transition: all 0.3s;
                font-size: 15px;
            }

            .btn-primary {
                background: linear-gradient(45deg, #89CFF0, #FFB6C1);
                color: white;
                border: none;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 182, 193, 0.3);
                background: linear-gradient(45deg, #7BC4E9, #FFA7B6);
            }

            .btn-secondary {
                color: #89CFF0;
                border: 2px solid #89CFF0;
                background-color: white;
            }

            .btn-secondary:hover {
                background: linear-gradient(45deg, #89CFF0, #FFB6C1);
                color: white;
                border-color: transparent;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(137, 207, 240, 0.3);
            }
        </style>
    </head>
    <body>
        <%
            ProfileBean profile = (ProfileBean) request.getAttribute("profile");
            String successMessage = (String) request.getAttribute("successMessage");
        %>
        
        <div class="profile-container">
            <h2>Profile Saved Successfully!</h2>
            
            <% if (successMessage != null) { %>
                <div class="success-message">
                    <%= successMessage %>
                </div>
            <% } %>
            
            <div class="profile-details">
                <div class="profile-field">
                    <span class="field-label">Student ID</span>
                    <div class="field-value"><%= profile.getStudent_id() %></div>
                </div>
                
                <div class="profile-field">
                    <span class="field-label">Full Name</span>
                    <div class="field-value"><%= profile.getName() %></div>
                </div>
                
                <div class="profile-field">
                    <span class="field-label">Email Address</span>
                    <div class="field-value"><%= profile.getEmail() %></div>
                </div>
                
                <% if (profile.getPhone() != null && !profile.getPhone().isEmpty()) { %>
                    <div class="profile-field">
                        <span class="field-label">Phone Number</span>
                        <div class="field-value"><%= profile.getPhone() %></div>
                    </div>
                <% } %>
                
                <% if (profile.getProgramme() != null && !profile.getProgramme().isEmpty()) { %>
                    <div class="profile-field">
                        <span class="field-label">Programme/Course</span>
                        <div class="field-value"><%= profile.getProgramme() %></div>
                    </div>
                <% } %>
                
                <div class="profile-field">
                    <span class="field-label">Current Semester</span>
                    <div class="field-value">Semester <%= profile.getSemester() %></div>
                </div>
                
                <% if (profile.getHobby() != null && !profile.getHobby().isEmpty()) { %>
                    <div class="profile-field">
                        <span class="field-label">Hobby/Interest</span>
                        <div class="field-value"><%= profile.getHobby() %></div>
                    </div>
                <% } %>
            </div>
            
            <div class="action-links">
                <a href="index.html" class="action-btn btn-primary">Add New Profile</a>
                <a href="viewProfiles.jsp" class="action-btn btn-secondary">View All Profiles</a>
            </div>
        </div>
    </body>
</html>