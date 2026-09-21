<cfparam name="form.otp" default="">
<script src="/CRMdui/scripts/alert.js"></script>

<cfif form.otp EQ session.resetOTP>

    <script>
        otpVerifiedSuccess();
        window.location = "passwordreset.cfm";
    </script>

<cfelse>

        invalidOtp();
        window.location = "passwordverifyotp.cfm";
    </script>

</cfif>