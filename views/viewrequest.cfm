cfm
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

<!-- JAVASCRIPT -->
<script src="/CRMdui/scripts/viewrequest.js"></script>


<!-- =========================================================
     SUCCESS MESSAGES
     ========================================================= -->

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


<!-- =========================================================
     PAGE TITLE
     ========================================================= -->

<h2>Requests Data</h2>


<!-- =========================================================
     TOP BAR
     ========================================================= -->

<div class="top-bar">


    <!-- DEPARTMENT FILTER -->

    <form
        method="post"
        action="index.cfm?fuse=viewrequest"
        class="search-form">

        <select
            name="searchDepartment"
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


        <input
            type="submit"
            value="Filter"
            class="search-btn">

    </form>


    <!-- PDF BUTTON -->

    <div class="pdf-btn">

        <cfoutput>

            <a
                href="index.cfm?fuse=downloadreport&department=#URLEncodedFormat(form.searchDepartment)#"
                target="_blank">

                <span style="color:white;">
                    VIEW PDF
                </span>

            </a>

        </cfoutput>

    </div>

</div>


<!-- =========================================================
     REQUEST TABLE
     ========================================================= -->

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


                <!-- =================================================
                     ID
                     ================================================= -->

                <td>

                    <span class="id-badge id-badge-#request_id MOD 6#">

                        #request_id#

                    </span>

                </td>


                <!-- =================================================
                     TITLE
                     ================================================= -->

                <td>

                    #Title#

                </td>


                <!-- =================================================
                     DEPARTMENT
                     ================================================= -->

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


                <!-- =================================================
                     DESCRIPTION
                     ================================================= -->

                <td>

                    #Description#

                </td>


                <!-- =================================================
                     ACTIONS
                     ================================================= -->

                <td class="action-buttons">


                    <!-- UPDATE BUTTON -->

                    <button
                        type="button"
                        class="update-btn request-update-btn"

                        data-request-id="#request_id#"

                        data-title="#encodeForHTMLAttribute(Title)#"

                        data-department="#encodeForHTMLAttribute(Department)#"

                        data-description="#encodeForHTMLAttribute(Description)#"

                        onclick="openUpdateModal(this)">

                        UPDATE

                    </button>


                    <!-- DELETE BUTTON -->

                    <a
                        class="delete-btn"

                        href="index.cfm?fuse=deletevalidation&id=#request_id#"

                        onclick="return confirm('Are you sure you want to delete this request?')">

                        DELETE

                    </a>


                </td>

            </tr>

        </cfoutput>


    <cfelse>


        <tr>

            <td
                colspan="5"
                style="text-align:center;">

                No requests found

            </td>

        </tr>


    </cfif>

</table>


<!-- =========================================================
     PAGINATION
     ========================================================= -->

<div
    class="pagination"
    id="pagination">
</div>


<br>


<!-- HOME BUTTON -->

<cfinclude template="/CRMdui/includes/homebutton.cfm">


<!-- PAGINATION JAVASCRIPT -->

<script src="/CRMdui/scripts/pagination.js"></script>


<!-- =========================================================
     UPDATE MODAL
     ========================================================= -->

<div
    id="updateModal"
    class="update-modal-overlay">


    <div class="update-modal">


        <!-- MODAL HEADER -->

        <div class="update-modal-header">

            <h2>
                Edit Request
            </h2>


            <button
                type="button"
                class="modal-close-btn"
                onclick="closeUpdateModal()">

                &times;

            </button>

        </div>


        <!-- =====================================================
             UPDATE FORM
             ===================================================== -->

        <form
            action="index.cfm?fuse=updatevalidation"
            method="post"
            class="update-modal-form">


            <!-- REQUEST ID -->

            <input
                type="hidden"
                id="modal_request_id"
                name="request_id">


            <!-- TITLE -->

            <label for="modal_title">

                Title

            </label>


            <input
                type="text"
                id="modal_title"
                name="Title"
                required>


            <!-- DEPARTMENT -->

            <label for="modal_department">

                Department

            </label>


            <select
                id="modal_department"
                name="Department"
                required>

                <option value="">

                    -- Select Department --

                </option>

                <option value="HR">

                    HR

                </option>

                <option value="Finance">

                    Finance

                </option>

                <option value="IT">

                    IT

                </option>

                <option value="Marketing">

                    Marketing

                </option>

            </select>


            <!-- DESCRIPTION -->

            <label for="modal_description">

                Description

            </label>


            <textarea
                id="modal_description"
                name="Description"
                required></textarea>


            <!-- MODAL BUTTONS -->

            <div class="update-modal-actions">


                <button
                    type="button"
                    class="modal-cancel-btn"
                    onclick="closeUpdateModal()">

                    Cancel

                </button>


                <button
                    type="submit"
                    class="modal-update-btn">

                    Update

                </button>


            </div>

        </form>

    </div>

</div>


</body>

</html>

