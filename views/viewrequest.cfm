
<!-- DEFAULT VALUE -->
<cfparam name="form.searchDepartment" default="All Departments">

<!-- GET DATA FROM CONTROLLER -->
<cfset getDepartments = data.getDepartments>
<cfset getRequests = data.getRequests>

<!DOCTYPE html>
<html>
<head>
    <title>View Requests</title>
    <link rel="stylesheet" href="/CRMdui/css/viewrequeststyle.css">
</head>

<body>

<script src="/CRMdui/scripts/viewrequest.js"></script>

<cfif structKeyExists(url, "status")>

    <cfif url.status EQ "deleted">
        <script>
            deleteSuccess();
        </script>
    </cfif>

    <cfif url.status EQ "updated">
        <script>
            updateSuccess();
        </script>
    </cfif>

</cfif>

<h2>Requests Data</h2>

<!-- TOP BAR -->
<div class="top-bar">

    <!-- DROPDOWN FILTER -->
    <form method="post"
          action="index.cfm?fuse=viewrequest"
          class="search-form">

        <select name="searchDepartment"
                class="department-dropdown">

            <option value="All Departments">
                All departments
            </option>

            <cfoutput query="getDepartments">

                <option
                    value="#Department#"

                    <cfif form.searchDepartment EQ Department>
                        selected
                    </cfif>>

                    #Department#

                </option>

            </cfoutput>

        </select>

        <input type="submit"
               value="Filter"
               class="search-btn">

    </form>

    <div class="pdf-btn">

        <cfoutput>

            <a
                href="index.cfm?fuse=downloadreport&department=#URLEncodedFormat(form.searchDepartment)#"
                target="_blank">

                <span style="color: white;">VIEW PDF</span>

            </a>

        </cfoutput>

    </div>

</div>

<!-- TABLE -->
<table id="Table">

    <tr>
        <th>ID</th>
        <th>TITLE</th>
        <th>DEPARTMENT</th>
        <th>DESCRIPTION</th>
        <th>ACTIONS</th>
    </tr>

    <cfif getRequests.recordCount GT 0>

        <cfoutput query="getRequests">

            <tr>

                <!-- ID BADGE -->
                <td>

                    <span class="id-badge id-badge-#request_id MOD 6#">
                        #request_id#
                    </span>

                </td>

                <td>
                    #Title#
                </td>

                <!-- DEPARTMENT BADGE -->
                <td>

                    <cfif LCase(Trim(Department)) EQ "finance">

                        <span class="department-badge department-finance">
                            #Department#
                        </span>

                    <cfelseif LCase(Trim(Department)) EQ "hr">

                        <span class="department-badge department-hr">
                            #Department#
                        </span>

                    <cfelseif LCase(Trim(Department)) EQ "marketing">

                        <span class="department-badge department-marketing">
                            #Department#
                        </span>

                    <cfelseif LCase(Trim(Department)) EQ "it">

                        <span class="department-badge department-it">
                            #Department#
                        </span>

                    <cfelse>

                        <span class="department-badge department-default">
                            #Department#
                        </span>

                    </cfif>

                </td>

                <td>
                    #Description#
                </td>

                <td class="action-buttons">

                    <a class="update-btn"
                       href="index.cfm?fuse=updateform&id=#request_id#">
                        UPDATE
                    </a>

                    <a class="delete-btn"
                       href="index.cfm?fuse=deletevalidation&id=#request_id#"
                       onclick="return confirm('Are you sure you want to delete this request?')">
                        DELETE
                    </a>

                </td>

            </tr>

        </cfoutput>

    <cfelse>

        <tr>

            <td colspan="5" style="text-align:center;">
                No requests found
            </td>

        </tr>

    </cfif>

</table>

<div class="pagination" id="pagination"></div>

<br>

<cfinclude template="/CRMdui/includes/homebutton.cfm">

<script src="/CRMdui/scripts/pagination.js"></script>

</body>
</html>
