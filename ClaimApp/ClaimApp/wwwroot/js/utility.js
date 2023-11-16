
function requiredTextFiled(control, ErrorMessage,validationtype="all") {
    var id = "#txt" + control
    var err = "#err" + control
    var formGroup = "#formGroup" + control
    var txtVal = $(id).val()
    if (txtVal == "" || txtVal == null || txtVal == "undefined") {
        $(err).html("Please enter " + ErrorMessage).addClass("error-control")
        $(formGroup).addClass("error-control")
        return false
    }
    else {

      if (GetRegx(validationtype).test(txtVal)) { 
        $(err).html("").removeClass("error-control")
        $(formGroup).removeClass("error-control")
        return true
         }
        else {
            $(err).html("Please enter valid " + ErrorMessage).addClass("error-control")
            $(formGroup).addClass("error-control")
            return false
        }

    }
}

function GetRegx(type) {

    var regx = /.+/s;
    switch (type) {
        case "email":
            regx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            break;

        case "mobile":
            regx = /^[1-9]{1}[0-9]{9}$/;
            break;
    }
    return regx;
}