<%-- 
    Document   : viewProfiles
    Created on : Dec 21, 2025, 7:20:42 PM
    Author     : nur azwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>View Student Profiles</title>
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
                max-width: 1200px;
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
                background: linear-gradient(90deg, #89CFF0, #FFB6C1, #89CFF0);
                background-size: 200% 100%;
                border-radius: 15px 15px 0 0;
                animation: gradientShift 3s ease infinite;
            }

            @keyframes gradientShift {
                0% {
                    background-position: 0% 50%;
                }
                100% {
                    background-position: 100% 50%;
                }
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

            .search-container {
                background: linear-gradient(45deg, #f8fdff, #fff8fb);
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 30px;
                border: 2px solid #e6f7ff;
            }

            .search-form {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .search-input {
                flex: 1;
                padding: 12px 15px;
                border: 2px solid #e6f7ff;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s;
                background-color: white;
            }

            .search-input:focus {
                outline: none;
                border-color: #FFB6C1;
                box-shadow: 0 0 0 3px rgba(255, 182, 193, 0.2);
            }

            .search-btn {
                padding: 12px 25px;
                background: linear-gradient(45deg, #89CFF0, #FFB6C1);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                white-space: nowrap;
            }

            .search-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 182, 193, 0.3);
                background: linear-gradient(45deg, #7BC4E9, #FFA7B6);
            }

            .clear-btn {
                padding: 10.5px 20px;
                color: #89CFF0;
                border: 2px solid #89CFF0;
                border-radius: 8px;
                background-color: white;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
                display: inline-block;
                white-space: nowrap;
            }

            .clear-btn:hover {
                background: linear-gradient(45deg, #89CFF0, #FFB6C1);
                color: white;
                border-color: transparent;
                transform: translateY(-2px);
            }

            .table-container {
                overflow-x: auto;
                margin-bottom: 30px;
                border-radius: 10px;
                border: 1px solid #e6f7ff;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                min-width: 800px;
            }

            th {
                background: #ffb6c1db;
                color: white;
                padding: 15px;
                font-weight: 600;
                font-size: 14px;
                position: sticky;
                top: 0;
                text-transform: uppercase;
            }

            th:first-child {
                border-radius: 10px 0 0 0;
            }

            th:last-child {
                border-radius: 0 10px 0 0;
            }
            
            thead th {
                text-align: center;
            }

            td {
                padding: 12px 15px;
                border-bottom: 1px solid #f0f8ff;
                color: #555;
                font-size: 14px;
                text-align: center;
            }

            tr:nth-child(even) {
                background-color: #f9fdff;
            }

            tr:hover {
                background-color: #f0f8ff;
                transform: translateY(-1px);
                transition: all 0.2s;
                box-shadow: 0 2px 5px rgba(137, 207, 240, 0.1);
            }

            .action-links {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
                justify-content: center;
            }

            .action-btn {
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s;
                display: inline-block;
                text-align: center;
                min-width: 60px;
            }

            .edit-btn {
                background: linear-gradient(45deg, #4CAF50, #45a049);
                color: white;
                border: none;
            }

            .edit-btn:hover {
                background: linear-gradient(45deg, #45a049, #3d8b40);
                transform: translateY(-2px);
                box-shadow: 0 3px 8px rgba(76, 175, 80, 0.3);
            }

            .delete-btn {
                background: linear-gradient(45deg, #FF6B6B, #ff5252);
                color: white;
                border: none;
            }

            .delete-btn:hover {
                background: linear-gradient(45deg, #ff5252, #ff3838);
                transform: translateY(-2px);
                box-shadow: 0 3px 8px rgba(255, 107, 107, 0.3);
            }

            .no-data {
                text-align: center;
                padding: 40px;
                color: #888;
                font-size: 16px;
                background: linear-gradient(45deg, #f8fdff, #fff8fb);
                border-radius: 10px;
                margin: 20px 0;
            }

            .action-container {
                text-align: center;
                margin-top: 30px;
                padding-top: 25px;
                border-top: 1px solid rgba(224, 247, 255, 0.8);
            }

            .back-btn {
                display: inline-block;
                padding: 12px 30px;
                background: linear-gradient(45deg, #89CFF0, #FFB6C1);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s;
            }

            .back-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 182, 193, 0.3);
                background: linear-gradient(45deg, #7BC4E9, #FFA7B6);
            }

            .profile-count {
                text-align: right;
                color: #666;
                font-size: 14px;
                margin-bottom: 10px;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>All Student Profiles</h2>
            
            <div class="search-container">
                <form method="get" class="search-form">
                    <input type="text" name="keyword" class="search-input" 
                           placeholder="Search by Student ID or Name" 
                           value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
                    <button type="submit" class="search-btn">Search</button>
                    <a href="viewProfiles.jsp" class="clear-btn">Clear</a>
                </form>
            </div>
            
            <%
                String keyword = request.getParameter("keyword");
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int profileCount = 0;
                
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles;create=true", "app", "app");

                    String sql;
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        sql = "SELECT * FROM profile WHERE LOWER(student_id) LIKE LOWER(?) OR LOWER(name) LIKE LOWER(?) ORDER BY name";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, "%" + keyword.trim() + "%");
                        ps.setString(2, "%" + keyword.trim() + "%");
                    } else {
                        sql = "SELECT * FROM profile ORDER BY name";
                        ps = conn.prepareStatement(sql);
                    }

                    rs = ps.executeQuery();
            %>
            
            <div class="profile-count">
                <% 
                    // Count results
                    ResultSet countRs = null;
                    try {
                        String countSql = keyword != null && !keyword.trim().isEmpty() 
                            ? "SELECT COUNT(*) FROM profile WHERE LOWER(student_id) LIKE LOWER(?) OR LOWER(name) LIKE LOWER(?)"
                            : "SELECT COUNT(*) FROM profile";
                        PreparedStatement countPs = conn.prepareStatement(countSql);
                        if (keyword != null && !keyword.trim().isEmpty()) {
                            countPs.setString(1, "%" + keyword.trim() + "%");
                            countPs.setString(2, "%" + keyword.trim() + "%");
                        }
                        countRs = countPs.executeQuery();
                        if (countRs.next()) {
                            profileCount = countRs.getInt(1);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                Showing <%= profileCount %> profile(s)
                <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                    for "<%= keyword %>"
                <% } %>
            </div>
            
            <div class="table-container">
                <% if (profileCount > 0) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Programme</th>
                            <th>Semester</th>
                            <th>Hobby</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                        <tr>
                            <td><%= rs.getString("student_id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone") != null ? rs.getString("phone") : "-" %></td>
                            <td><%= rs.getString("programme") != null ? rs.getString("programme") : "-" %></td>
                            <td>Semester <%= rs.getInt("semester") %></td>
                            <td><%= rs.getString("hobby") != null ? rs.getString("hobby") : "-" %></td>
                            <td>
                                <div class="action-links">
                                    <a href="editProfile.jsp?student_id=<%= rs.getString("student_id") %>" 
                                       class="action-btn edit-btn">Edit</a>
                                    <a href="DeleteProfileServlet?student_id=<%= rs.getString("student_id") %>"
                                       onclick="return confirm('Are you sure you want to delete this profile?');"
                                       class="action-btn delete-btn">Delete</a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="no-data">
                    <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                        No profiles found for "<%= keyword %>"
                    <% } else { %>
                        No student profiles found. <a href="index.html">Add a new profile</a>
                    <% } %>
                </div>
                <% } %>
            </div>
            
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            
            <div class="action-container">
                <a href="index.html" class="back-btn">Add New Profile</a>
            </div>
        </div>
    </body>
</html>