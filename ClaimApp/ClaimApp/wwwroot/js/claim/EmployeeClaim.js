
$(document).ready(function () {
    $("#btnSubmit").click(function () {
        addClaimrequest()
    })
    $("#btnReload").click(function () {
        window.location.reload()
    })

})

function addClaimrequest() {

    var isValid = false;
    
    isValid = requiredTextFiled("ClaimTitle", "claim title");
    if (!isValid) { return false }

    isValid = requiredTextFiled("ClaimReason", "claim reason");
    if (!isValid) { return false }

    isValid = requiredTextFiled("ClaimAmount", "claim amount");
    if (!isValid) { return false }

    isValid = requiredTextFiled("ClaimExpenseDt", "expense date");
    if (!isValid) { return false }

    isValid = requiredTextFiled("ClaimEvidence", "evidence");
    if (!isValid) { return false }

    isValid = requiredTextFiled("ClaimDescription", "description");
    if (!isValid) { return false }
    
    if (isValid) {
        var data = new FormData()
        data.append("ClaimTitle", $("#txtClaimTitle").val())
        data.append("ClaimReason", $("#txtClaimReason").val())
        data.append("ClaimDescription", $("#txtClaimDescription").val())
        data.append("ClaimAmount", $("#txtClaimAmount").val())
        data.append("ExpenseDt", $("#txtClaimExpenseDt").val())
        data.append("UserId", localStorage.getItem("UserRid"))
        data.append("file", $("#txtClaimEvidence")[0].files[0])

        $.ajax({
            "url": base_url + "Claim/RequestClaim",
            "method": "POST",
            cache: false,
            contentType: false,
            processData: false,
            headers: {
                "Authorization": "Bearer " + localStorage.getItem("token")
            },
            "data": data,
            "success": function (response) {
                if (response.ok) {
                    $("#msg").html(response.message).css("color", "green")
                    setTimeout(function () {
                        location.reload()
                    }, 3000)
                }
                else {
                    $("#msg").html(response.message).css("color", "red")
                }
            },
            "error": function (err) {
                console.log(err)
            }
        })


    }   
}

$("#txtClaimTitle").keyup(function () {
    isValid = requiredTextFiled("ClaimTitle", "claim title");
    if (!isValid) { return false }
})