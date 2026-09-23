
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Activity Logs</title>

    <link rel="stylesheet" href="/CRMdui/css/viewlogs.css">
    <link rel="stylesheet" href="/CRMdui/css/pagination.css">

</head>

<body>

<div class="container">

    <h2>Activity Logs</h2>

    <!-- TABLE -->
    <table id="Table">

        <thead>
            <tr>
                <th>Log ID</th>
                <th>User ID</th>
                <th>Username</th>
                <th>Action</th>
                <th>Description</th>
                <th>Created At</th>
            </tr>
        </thead>

        <tbody>

        <cfif structKeyExists(data, "logs") AND data.logs.recordCount GT 0>

            <cfoutput query="data.logs">

                <tr>

                    <!-- LOG ID -->
                    <td>
                        <span class="log-badge log-id-#(log_id MOD 8)#">
                            #log_id#
                        </span>
                    </td>

                    <!-- USER ID -->
                    <td>
                        <span class="log-badge user-id-#(user_id MOD 8)#">
                            #user_id#
                        </span>
                    </td>

                    <!-- USERNAME -->
                    <td>

                        <cfset usernameKey = 0>

                        <cfloop from="1"
                                to="#Len(username)#"
                                index="charIndex">

                            <cfset usernameKey =
                                usernameKey +
                                Asc(Mid(username, charIndex, 1))>

                        </cfloop>

                        <cfset usernameColor = usernameKey MOD 8>

                        <span class="log-badge username-#usernameColor#">
                            #username#
                        </span>

                    </td>

                    <!-- ACTION -->
                    <td>

                        <cfif LCase(Trim(action_type)) EQ "create">

                            <span class="log-badge action-create">
                                #action_type#
                            </span>

                        <cfelseif LCase(Trim(action_type)) EQ "update">

                            <span class="log-badge action-update">
                                #action_type#
                            </span>

                        <cfelseif LCase(Trim(action_type)) EQ "delete">

                            <span class="log-badge action-delete">
                                #action_type#
                            </span>

                        <cfelseif LCase(Trim(action_type)) EQ "login">

                            <span class="log-badge action-login">
                                #action_type#
                            </span>

                        <cfelseif LCase(Trim(action_type)) EQ "logout">

                            <span class="log-badge action-logout">
                                #action_type#
                            </span>

                        <cfelse>

                            <cfset actionKey = 0>

                            <cfloop from="1"
                                    to="#Len(action_type)#"
                                    index="charIndex">

                                <cfset actionKey =
                                    actionKey +
                                    Asc(Mid(action_type, charIndex, 1))>

                            </cfloop>

                            <cfset actionColor = actionKey MOD 8>

                            <span class="log-badge username-#actionColor#">
                                #action_type#
                            </span>

                        </cfif>

                    </td>

                    <!-- DESCRIPTION -->
                    <td>
                        #description#
                    </td>

                    <!-- CREATED AT -->
                    <td>
                        #created_at#
                    </td>

                </tr>

            </cfoutput>

        <cfelse>

            <tr>
                <td colspan="6" style="text-align:center;">
                    No logs found
                </td>
            </tr>

        </cfif>

        </tbody>

    </table>

    <!-- PAGINATION -->
    <div class="pagination" id="pagination"></div>

</div>

<!-- HOME BUTTON -->
<div class="home-button">
    <cfinclude template="/CRMdui/includes/homebutton.cfm">
</div>

<!-- JS PAGINATION -->
<script src="/CRMdui/scripts/pagination.js"></script>

</body>
</html>

