// anything start from $ is jquery

$(document).ready(function () {
    
    
    let answerBox = document.getElementById("answer-container"); //this is this vanilla style 
    
    let $answerBox = $("answer-container"); //this is this vanilla style 
    //$ is how jquery to call out element

    $("#answer-toggle").click(function(){
        $answerBox.toggle(;)
    })
$("#upvote-form").submit(function (e) {
    e.preventDefault();
    console.log("Prevented Default");

    $.ajax({
        method: this.method,
        url: this.action,
        success: function (data) {
            console.log("success");
            let realData = JSON.parse(data)
            console.log(realData)

            $("#upvote-count").html("1");
        },
        error: function (error) {
            console.log("This is error repot");
            console.log(error);
        }
    })
}); 