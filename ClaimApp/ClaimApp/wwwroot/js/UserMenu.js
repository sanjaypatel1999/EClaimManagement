$(document).ready(function () {
    GetProgramList()
})
var rootPath ="http://localhost:50645/"
function GetProgramList() {
    var user = {
        "UserId": localStorage.getItem("UserRid")
        }
    $.ajax({
        "url": base_url + "ProgramAccess/GetProgramList",
        "method": "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        "data": user,
        "success": function (response) {
            if (response.ok) {
             //   console.log(response)
                var menu =''
                response.data.forEach(function (item, index) {

                    menu += '<li class="nav-item"><a href="' + rootPath + item.path + '" class="nav-link">'
                    menu += '<i class="nav-icon fas fa-chart-pie"></i>'
                    menu += '<p>'+item.title+'<i class="right fas fa-angle-left"></i>'
                    menu += '</p></a></li >'
                })
                $("#programMenu").html(menu)
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