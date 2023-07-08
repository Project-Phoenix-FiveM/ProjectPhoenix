var Input = false;
var Inputs = 0;

function CreateInput(data) {
    $(".input").append(`<div class='input-title'>${data.title}</div>`);
    Inputs = data.inputs.length;
    data.inputs.forEach((input, index) => {
        let row = "";
        switch(input.type) {
            case "text":
                row = `<div class='input-row'><input class="input-field" id="input-${index}" placeholder="${input.placeholder}" type="text"></div>`;
                break;
            case "password":
                row = `<div class='input-row'><input class="input-field" id="input-${index}" placeholder="${input.placeholder}" type="password"></div>`;
                break;
            case "number":
                row = `<div class='input-row'><input class="input-field" id="input-${index}" placeholder="${input.placeholder}" type="number"></div>`;
                break;
            default:
                break;
        };
        $(".input").append(row);
    });
    $(".input").append(`<div class='input-submit'><button type="submit" class="input-btn" onclick="SubmitInput()">Submit</button></div>`);
    $(".input").fadeIn(0);
    Input = true;
}

function SubmitInput() {
    let returnData = [];
    for (var i = 0; i < Inputs; i++) {
        returnData[i] = document.getElementById("input-"+i).value;
    }
    $.post('https://ps-ui/input-callback', JSON.stringify({ 'input': returnData }));
    CloseInput()
}

function CloseInput() {
    $.post('https://ps-ui/input-close', JSON.stringify({"ok":true}));
    $(".input").fadeOut(0);
    document.querySelector('.input').innerHTML = '';
    Input = false;
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'input') {
        CreateInput(event.data.data);
    }
});

document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['Escape'];
    if (Input) {
        if (valid_keys.includes(key_pressed)) {
            switch (key_pressed) {
                case 'Escape':
                    CloseInput()
                    break;
            }
        }
    }
});