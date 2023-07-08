let Items = [];
let Open = false;

function CreateMenu(data) {
    Items = [];
    for (let i = 0; i < data.length; i++) {
        let e = "";
        let header = data[i].header ? data[i].header : "";
        let text = data[i].text ? data[i].text : "";
        let icon = data[i].icon ? data[i].icon : "";
        let color = data[i].color ? data[i].color: "";

        e = $(`
            <div class="item" onclick="MenuSelect(${i})">
                    <div class="menu-icon">
                        <span style="color:${color};"><i class="${icon}"></i></span>
                    </div>
                    <div class="menu-text">
                        <div class="header">${header}</div>
                        <div class="text">${text}</div>
                    </div>
            </div>`
        );
        Items[i] = data[i];
        $('#menu-items').append(e);
    }
    Open = true;
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'menu-open' && event.data.data != null) {
        CreateMenu(event.data.data)
    }
});

document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['Escape'];
  
    if (valid_keys.includes(key_pressed) && Open) {
        switch (key_pressed) {
            case 'Escape':
                MenuClose()
                break;
        }
    }
});

function MenuClose() {
    $.post('https://ps-ui/menuClose', JSON.stringify({"ok":true}));
    $(".item").remove();
    Open = false
}

function MenuSelect(id) {
    let data = Items[id];
    $.post(`https://ps-ui/MenuSelect`, JSON.stringify({"data":data, "ok":true}));
    MenuClose();
}
