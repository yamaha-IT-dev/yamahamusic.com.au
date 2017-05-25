/* This script and many more are available free online at
The JavaScript Source!! http://javascript.internet.com
Created by: Jim Stiles | www.jdstiles.com */
function startCalc() {
    interval = setInterval("calc()",100);
}

function calc() {
    labour = document.form_update_job.txtLabour.value;
    parts = document.form_update_job.txtParts.value;
    travelHours = document.form_update_job.txtTravelHours.value;
    travelRate = document.form_update_job.txtTravelRate.value;
    travelTotal = 0;

    if (travelHours != 0 && travelRate != 0) {
        travelTotal = (travelHours * travelRate);
    }

    document.form_update_job.txtGST.value = (labour * 0.1) + (parts * 0.1) + (travelTotal * 0.1);

    gst = document.form_update_job.txtGST.value;
    document.form_update_job.txtTotal.value = (labour * 1) + (parts * 1) + (travelTotal * 1) + (gst * 1);
}

function stopCalc() {
    clearInterval(interval);
}