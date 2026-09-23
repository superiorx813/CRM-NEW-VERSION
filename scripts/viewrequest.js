function deleteSuccess() {
    alert("Request Deleted Successfully!");
}

function updateSuccess() {
    alert("Request Updated Successfully!");
}

// =========================================================
// UPDATE MODAL
// =========================================================

function openUpdateModal(button) {

    const requestId =
        button.getAttribute("data-request-id");

    const title =
        button.getAttribute("data-title");

    const department =
        button.getAttribute("data-department");

    const description =
        button.getAttribute("data-description");


    // SET REQUEST ID
    document.getElementById("modal_request_id").value =
        requestId;


    // SET TITLE
    document.getElementById("modal_title").value =
        title;


    // SET DEPARTMENT
    document.getElementById("modal_department").value =
        department;


    // SET DESCRIPTION
    document.getElementById("modal_description").value =
        description;


    // OPEN MODAL
    document.getElementById("updateModal").style.display =
        "flex";


    // PREVENT BACKGROUND SCROLL
    document.body.classList.add("modal-open");

}


// =========================================================
// CLOSE UPDATE MODAL
// =========================================================

function closeUpdateModal() {

    document.getElementById("updateModal").style.display =
        "none";


    document.body.classList.remove("modal-open");

}


// =========================================================
// CLOSE WHEN CLICKING OUTSIDE MODAL
// =========================================================

document.addEventListener("click", function(event) {

    const modal =
        document.getElementById("updateModal");


    if (!modal) {
        return;
    }


    if (event.target === modal) {

        closeUpdateModal();

    }

});


// =========================================================
// CLOSE USING ESC KEY
// =========================================================

document.addEventListener("keydown", function(event) {

    if (event.key !== "Escape") {
        return;
    }


    const modal =
        document.getElementById("updateModal");


    if (
        modal &&
        modal.style.display === "flex"
    ) {

        closeUpdateModal();

    }

});



