$(function() {
    // Model number changeover check
    $("#txtModelNo").focusout(function() {
        var userModelNo = $(this).val();
        var hiddenValue = $("#chkChangeoverModel");
        var alertMessage = $("#model-changeover-alert");
        $.ajax({
            context: $(this),
            url: "jobs_model_checker.asp",
            type: "POST",
            data: "user_model_no=" + userModelNo,
            success: function(data) {
                alertMessage.hide();
                if (data === "0") {
                    alertMessage.hide();
                    hiddenValue.prop("checked", false);
                } else if (data === "1") {
                    alertMessage.show();
                    hiddenValue.prop("checked", true);
                }
            },
            error: function(data) {
                console.log("Error: I was not able to find out if this Model No is a changeover item or not.");
            }
        });
    })

    // Serial number highlighting
    $("#txtSerialNo").change(function() {
        var inputTextbox = $(this);
        var userSerialNo = $(this).val();
        var alertMessage = $("#serial-alert");
        $.ajax({
            context: $(this),
            url: "jobs_serial_checker.asp",
            type: "GET",
            data: "user_serial_no=" + userSerialNo,
            success: function(data) {
                inputTextbox.removeClass("alert-error alert-success");
                alertMessage.hide();
                if (data === "0") {
                    inputTextbox.addClass("alert-error");
                    alertMessage.show();
                } else if (data === "1") {
                    inputTextbox.addClass("alert-success");
                    alertMessage.hide();
                }
            },
            error: function(data) {
                console.log("Error: I was not able to check the validity of the Serial No against the lookup table.");
            }
        });
    });
});