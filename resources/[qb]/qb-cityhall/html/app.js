let mouseOver = false;
let selectedIdentity = null;
let selectedIdentityType = null;
let selectedIdentityCost = null;
let selectedJob = null;
let selectedJobId = null;

Open = function(jobs) {
    SetJobs(jobs);
    $(".container").fadeIn(150);
}

Close = function() {
    $(".container").fadeOut(150, function(){
        ResetPages();
    });
    $.post('https://qb-cityhall/close');
    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");
}

SetJobs = function(jobs) {
    $('.job-page-blocks').empty();
    $.each(jobs, (job, name) => {
        let html = `<div class="job-page-block" data-job="${job}"><p>${name.label}</p></div>`;
        $('.job-page-blocks').append(html);
    })
}

ResetPages = function() {
    $(".cityhall-option-blocks").show();
    $(".cityhall-identity-page").hide();
    $(".cityhall-job-page").hide();
}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                Open(event.data.jobs);
                break;
            case "close":
                Close();
                break;
            case "setJobs":
                SetJobs(event.data.jobs);
                break;
        }
    })
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            Close();
            break;
    }
});

$('.cityhall-option-block').click(function(e){
    e.preventDefault();
    let blockPage = $(this).data('page');
    $(".cityhall-option-blocks").fadeOut(100, () => {
        $(`.cityhall-${blockPage}-page`).fadeIn(100);
    });
    if (blockPage == "identity") {
        $(".identity-page-blocks").html("");
        $.post('https://qb-cityhall/requestLicenses', JSON.stringify({}), function(licenses){
            $.each(licenses, (i, license) => {
                let elem = `<div class="identity-page-block" data-type="${i}" data-cost="${license.cost}"><p>${license.label}</p></div>`;
                $(".identity-page-blocks").append(elem);
            });
        });
    }
});

$(document).on("click", ".identity-page-block", function(e){
    e.preventDefault();
    selectedIdentityType = $(this).data('type');
    selectedIdentityCost = $(this).data('cost');
    if (selectedIdentity == null) {
        $(this).addClass("identity-selected");
        $(".hover-description").fadeIn(10);
        selectedIdentity = this;
        $(".request-identity-button").fadeIn(100);
        $(".request-identity-button").html(`<p>Buy $${selectedIdentityCost}</p>`);
    } else if (selectedIdentity == this) {
        $(this).removeClass("identity-selected");
        selectedIdentity = null;
        $(".request-identity-button").fadeOut(100);
    } else {
        $(selectedIdentity).removeClass("identity-selected");
        $(this).addClass("identity-selected");
        selectedIdentity = this;
        $(".request-identity-button").html("<p>Buy</p>");
    }
});

$(".request-identity-button").click(function(e){
    e.preventDefault();
    $.post('https://qb-cityhall/requestId', JSON.stringify({
        type: selectedIdentityType,
        cost: selectedIdentityCost
    }))
    ResetPages();
});

$(document).on("click", ".job-page-block", function(e){
    e.preventDefault();
    selectedJobId = $(this).data('job');
//    selectedJobId["application"] = $(this).data('application')
    if (selectedJob == null) {
        $(this).addClass("job-selected");
        selectedJob = this;
        $(".apply-job-button").fadeIn(100);
    } else if (selectedJob == this) {
        $(this).removeClass("job-selected");
        selectedJob = null;
        $(".apply-job-button").fadeOut(100);
    } else {
        $(selectedJob).removeClass("job-selected");
        $(this).addClass("job-selected");
        selectedJob = this;
    }
});

$(document).on('click', '.apply-job-button', function(e){
    e.preventDefault();
    $.post('https://qb-cityhall/applyJob', JSON.stringify(selectedJobId))
    ResetPages();
});

$(document).on('click', '.back-to-main', function(e){
    e.preventDefault();
    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");
    ResetPages();
});
