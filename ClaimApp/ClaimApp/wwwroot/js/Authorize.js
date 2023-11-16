
checkUserLoggedIn();
var base_url = "https://localhost:44397/api/"

function checkUserLoggedIn() {
    var auth_user = localStorage.getItem("token");
    if (auth_user == null) {
        window.location.href = "/Account/Login"
    }
}

$(document).ready(function () {
    $("#btnLogout").click(function () {
        localStorage.removeItem("user")
        localStorage.removeItem("token")
        window.location.href = "/Account/Login"
    })

})