<cfparam name="form.newpassword" default="">
<cfparam name="form.confirmpassword" default="">
<script src="/CRMdui/scripts/alert.js"></script>
<cfif form.newpassword NEQ form.confirmpassword>

    <script>
        passwordMismatch();
        window.location = "passwordreset.cfm";
    </script>

<cfelse>

    <!-- Encrypt Password -->
    <cfset encryptedPassword =
            hash(form.newpassword,"SHA-256")>

    <cfquery datasource="#application.datasource#">

        UPDATE users
        SET password =
            <cfqueryparam
                value="#encryptedPassword#"
                cfsqltype="cf_sql_varchar">

        WHERE username =
            <cfqueryparam
                value="#session.resetUsername#"
                cfsqltype="cf_sql_varchar">

    </cfquery>
      <!-- ================= LOG DATA (IMPORTANT) ================= -->
    <cfset logData = {
        action_type = "Password reset",
        description = "#session.resetUsername# reset their password"
    }>

    <!-- ================= INCLUDE LOGGER ================= -->
    <cfinclude template="logfile.cfm">

    <!-- Clear Sessions -->
    <cfset structDelete(session,"resetOTP")>
    <cfset structDelete(session,"resetEmail")>
    <cfset structDelete(session,"resetUsername")>

    <script>
        passwordUpdatedSuccess();
        window.location = "/CRMdui/views/loginform.cfm";
    </script>

</cfif>