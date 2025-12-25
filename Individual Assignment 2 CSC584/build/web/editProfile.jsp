<%-- 
    Document   : editProfile
    Created on : Dec 21, 2025, 9:09:43 PM
    Author     : nur azwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Student Profile</title>
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
                padding: 20px;
            }

            .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: white;
                padding: 35px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(137, 207, 240, 0.2), 
                            0 5px 15px rgba(255, 182, 193, 0.15);
                border: 1px solid rgba(255, 255, 255, 0.5);
                position: relative;
            }

            .container::before {
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

            .form-container {
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            label::before {
                content: '✏️';
                font-size: 12px;
            }

            input[type="text"],
            input[type="email"],
            input[type="number"] {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e6f7ff;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s;
                background-color: rgba(248, 251, 255, 0.8);
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="number"]:focus {
                outline: none;
                border-color: #FFB6C1;
                box-shadow: 0 0 0 3px rgba(255, 182, 193, 0.2);
                background-color: white;
            }

            .required {
                color: #FF69B4;
                font-weight: bold;
            }

            .submit-btn {
                width: 100%;
                padding: 14px;
                background: linear-gradient(45deg, #4CAF50, #45a049);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 10px;
                letter-spacing: 0.5px;
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
                background: linear-gradient(45deg, #45a049, #3d8b40);
            }

            .submit-btn:active {
                transform: translateY(0);
            }

            .action-container {
                text-align: center;
                margin-top: 30px;
                padding-top: 25px;
                border-top: 1px solid rgba(224, 247, 255, 0.8);
                display: flex;
                gap: 15px;
                justify-content: center;
            }

            .action-btn {
                display: inline-block;
                padding: 12px 25px;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s;
                font-size: 15px;
                min-width: 140px;
                text-align: center;
            }

            .cancel-btn {
                color: #89CFF0;
                border: 2px solid #89CFF0;
                background-color: white;
            }

            .cancel-btn:hover {
                background: linear-gradient(45deg, #89CFF0, #FFB6C1);
                color: white;
                border-color: transparent;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(137, 207, 240, 0.3);
            }

            .field-info {
                font-size: 12px;
                color: #888;
                margin-top: 5px;
                font-style: italic;
                padding-left: 20px;
            }

            .readonly-field {
                padding: 12px 15px;
                background-color: #f5f5f5;
                border: 2px solid #e6f7ff;
                border-radius: 8px;
                color: #777;
                font-size: 14px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%
            String student_id = request.getParameter("student_id");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles;create=true", "app", "app");

                ps = conn.prepareStatement("SELECT * FROM profile WHERE student_id = ?");
                ps.setString(1, student_id);
                rs = ps.executeQuery();
                
                if (rs.next()) {
        %>
        
        <div class="container">
            <h2>Edit Student Profile</h2>
            
            <div class="form-container">
                <form action="UpdateProfileServlet" method="post">
                    <input type="hidden" name="student_id" value="<%= rs.getString("student_id") %>">
                    
                    <div class="form-group">
                        <label for="student_id">Student ID</label>
                        <div class="readonly-field">
                            <%= rs.getString("student_id") %>
                        </div>
                        <div class="field-info">Student ID cannot be changed</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="name">Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" 
                               value="<%= rs.getString("name") %>" required 
                               placeholder="Enter full name">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" 
                               value="<%= rs.getString("email") %>" required 
                               placeholder="Enter email address">
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" 
                               value="<%= rs.getString("phone") != null ? rs.getString("phone") : "" %>" 
                               placeholder="e.g., 012-3456789">
                    </div>
                    
                    <div class="form-group">
                        <label for="programme">Programme/Course</label>
                        <input type="text" id="programme" name="programme" 
                               value="<%= rs.getString("programme") != null ? rs.getString("programme") : "" %>" 
                               placeholder="e.g., Computer Science">
                    </div>
                    
                    <div class="form-group">
                        <label for="semester">Semester <span class="required">*</span></label>
                        <input type="number" id="semester" name="semester" 
                               value="<%= rs.getInt("semester") %>" required 
                               min="1" max="8" placeholder="1-8">
                    </div>
                    
                    <div class="form-group">
                        <label for="hobby">Hobby/Interest</label>
                        <input type="text" id="hobby" name="hobby" 
                               value="<%= rs.getString("hobby") != null ? rs.getString("hobby") : "" %>" 
                               placeholder="e.g., Programming, Sports, Music">
                    </div>

                    <button type="submit" class="submit-btn">Update Profile</button>
                </form>
            </div>

            <div class="action-container">
                <a href="viewProfiles.jsp" class="action-btn cancel-btn">Cancel</a>
            </div>
        </div>
        
        <%
                } else {
        %>
        <div class="container">
            <h2>Profile Not Found</h2>
            <div style="text-align: center; padding: 40px; color: #888;">
                <p>Profile with ID <%= student_id %> not found.</p>
                <a href="viewProfiles.jsp" style="color: #89CFF0; text-decoration: none; font-weight: 600;">Back to Profiles</a>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="container">
            <h2>Error</h2>
            <div style="text-align: center; padding: 40px; color: #FF6B6B;">
                <p>An error occurred while loading the profile.</p>
                <p><%= e.getMessage() %></p>
                <a href="viewProfiles.jsp" style="color: #89CFF0; text-decoration: none; font-weight: 600;">Back to Profiles</a>
            </div>
        </div>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                var form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        var name = document.getElementById('name').value.trim();
                        var email = document.getElementById('email').value.trim();
                        var semester = document.getElementById('semester').value;
                        
                        if (!name) {
                            alert('Name is required');
                            e.preventDefault();
                            return false;
                        }
                        
                        if (!email) {
                            alert('Email is required');
                            e.preventDefault();
                            return false;
                        }
                        
                        if (!semester || semester < 1 || semester > 8) {
                            alert('Semester must be between 1 and 8');
                            e.preventDefault();
                            return false;
                        }
                        
                        return true;
                    });
                }
            });
        </script>
    </body>
</html>