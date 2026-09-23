<cfdocument
 format="PDF"
 name="pdfContent">

<html>

<head>
<meta charset="UTF-8">

<link
    rel="stylesheet"
    type="text/css"
    href="/CRMdui/css/downloadreport.css">
</head>

<body>
<div class="report-container">

    <div class="report-header">

        <h2 class="report-title">
            Requests PDF Report
        </h2>

        <p class="report-subtitle">
            Customer request details and department information
        </p>

    </div>

    <cfif data.getRequests.recordCount GT 0>

        <table class="report-table">

            <thead>

                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Department</th>
                    <th>Description</th>
                </tr>

            </thead>

            <tbody>

                <cfoutput query="data.getRequests">

                    <tr>

                        <td>
                            <span class="request-id">
                                #request_id#
                            </span>
                        </td>

                        <td>
                            <span class="request-title">
                                #Title#
                            </span>
                        </td>

                        <td>
                            <span class="department-badge">
                                #Department#
                            </span>
                        </td>

                        <td>
                            <span class="request-description">
                                #Description#
                            </span>
                        </td>

                    </tr>

                </cfoutput>

            </tbody>

        </table>

    <cfelse>

        <div class="no-data">
            No requests found for the selected department.
        </div>

    </cfif>

</div>


</body>

</html>

</cfdocument>

<cfheader
 name="Content-Disposition"
 value="inline; filename=Request_Report.pdf">

<cfcontent
 type="application/pdf"
 variable="#pdfContent#"
 reset="true">
