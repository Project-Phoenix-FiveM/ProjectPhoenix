const search_fade_animation = 400
const search_type_delay = 550
const ms = 25;
const SFX_ACTIVE = true

let Buttons = [];
let Button = [];

function delay(callback, ms) {
    var timer = 0;
    return function () {
        var context = this, args = arguments;
        clearTimeout(timer);
        timer = setTimeout(function () {
            callback.apply(context, args);
        }, ms || 0);
    };
}

function MouseEnter(disabled, element) {
    if (SFX_ACTIVE == false) return;
    element.mouseenter(function () {
        if (!disabled) {
            SFX()
        }
    });
}

function ShiftkeyAndMouseWheel(i, data) {
    $(`#range${i}`).bind('mousewheel', function (e) {
        if (!e.shiftKey) return
        let el = document.getElementById(`range${i}`)
        if (e.originalEvent.wheelDelta > 0) {
            el.value = parseInt(el.value) + parseInt(el.step);
        } else {
            el.value = parseInt(el.value) - parseInt(el.step);
        }
        Slider_Output(i, data[i].range.multiplier, data[i].range.currency)
    })
}

function SearchDoneSfx() {
    if (SFX_ACTIVE == false) return;
    SFX_Search_Done()
}

function SearchFailedSfx() {
    if (SFX_ACTIVE == false) return;
    SFX_Search_Failed()
}

const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
});

const OpenMenu = (data, rtl) => {
    if (rtl) {
        $('#container').attr('data-direction', 'rtl');
    } else {
        $('#container').attr('data-direction', 'ltr');
    }

    DrawButtons(data, rtl)
}

const CreateOverlay = (data) => {
    let ele = document.querySelector('.info')
    // @swkeep: changed context to subheader as i always do :)
    let context = data.subheader ? data.subheader : ""
    let footer = data.footer ? data.footer : ""
    let element = $(`
        <div class="info">
            <div class="column">
                <div class="row">
                    ${data.icons['header'] ? `<div class="icon-o"> <i class="${data.icons['header']}"></i> </div>` : ""} 
                    <div class="header"> ` + data.header + `</div>
                </div>
                <div class="row">
                    ${data.icons['subheader'] ? `<div class="icon-o"> <i class="${data.icons['subheader']}"></i> </div>` : ""} 
                    <div class="context">` + context + `</div>
                </div>

                <div class="row">
                    ${data.icons['footer'] ? `<div class="icon-o"> <i class="${data.icons['footer']}"></i> </div>` : ""} 
                    <div class="footer"> ` + footer + `</div>
                </div>
            </div>
        </div>
        `
    );

    if (ele != null) {
        $('div.info').replaceWith(element);

    } else {
        $('#infos').append(element);
    }
}

const CloseOverlay = () => {
    let element = $(``);
    $('div.info').replaceWith(element);
};

const CloseMenu = () => {
    // remove search bar
    $(".searchbar").remove();
    $(".searchbarDisabled").remove();
    // remove buttons
    $(".button").remove();
    $(".buttonDisabled").remove();
    // remove stteper
    $(".stepper-container").remove();
    $(".stepper").remove();
    // remove pin
    $(".pin-container").remove();
    // remove range_slider
    $(".sliderButton").remove();
    Buttons = [];
    Button = [];
};

function btn_next(data, i) {
    let element = $(`
            <div class="${data[i].disabled ? "stepperDisabled next-radius" : "stepper next-radius"}" id=${i} ${data[i].style ? `style="${data[i].style}"` : ""}>
                <div class="icon" id=${i}> <i class="fa-regular fa-circle-right" id=${i}></i> </div>

                <div className="column">
                    <div class="header" id=${i}>Next</div>
                </div>
            </div>
            `
    );
    MouseEnter(data[i].disabled, element)
    $('.stepper-container').append(element);
    Buttons[i] = element
    Button[i] = data[i]
}

function btn_pervious(data, i) {
    let element = $(`
            <div class ="stepper-container">
                <div class="${data[i].disabled ? "stepperDisabled pervious-radius" : "stepper pervious-radius"}" id=${i}>
                    <div class="icon" id=${i}> <i class="fa-regular fa-circle-left" id=${i}></i> </div>

                    <div className="column">
                        <div class="header" id=${i}>Pervious</div>
                    </div>
                </div>
            </div>`
    );
    MouseEnter(data[i].disabled, element)
    $('#buttons').append(element);
    Buttons[i] = element
    Button[i] = data[i]
}

function contorl_bar() {
    if (!document.querySelectorAll('div.pin-container').length > 0) {
        let element = $(`<div class ="pin-container"></div>`);
        $('#buttons').append(element);
    }
}

function btn_pin(data, i) {
    contorl_bar()
    let element = $(`
            <div class="pin" id=${i} ${data[i].style ? `style="${data[i].style}"` : ""}>
                <div class="icon" id=${i}> <i class="${data[i].icon}" id=${i}></i> </div>
                <div class="header" id=${i}>${data[i].header}</div>
            </div>`
    );
    MouseEnter(data[i].disabled, element)
    $('.pin-container').append(element);
    Buttons[i] = element
    Button[i] = data[i]
}

function btn_leave(data, i) {
    contorl_bar()
    let element = $(`
            <div class="leave" id=${i} ${data[i].style ? `style="${data[i].style}"` : ""}>
                <div class="icon" id=${i}> <i class="fa-solid fa-circle-xmark" id=${i}></i> </div>
                <div class="header" id=${i}>${data[i].header || 'Leave'}</div>
            </div>`
    );
    MouseEnter(data[i].disabled, element)
    $('.pin-container').append(element);
    Buttons[i] = element
    Button[i] = data[i]
}

function range_slider(data, i) {
    let element = $(`
            <div class="sliderButton" ${data[i].spacer ? "is-spacer" : ""}" id=${i} ${data[i].style ? `style="${data[i].style}"` : ""}>
                ${data[i].icon ? `<div class="icon" id=${i}> <i class="${data[i].icon}" id=${i}></i> </div>` : ""}

                <div class="slider_column">
                <div class="header" id=${i}>${data[i].header}</div>
                <div class="context" id=${i}>${data[i].subheader}</div>
                
                <input type="range"
                    id='range${i}'
                    name="${data[i].name}",
                    class="range_slider", 
                    min="${data[i].range.min ? data[i].range.min : 0}" 
                    max="${data[i].range.max ? data[i].range.max : 0}" 
                    step="${data[i].range.step ? data[i].range.step : 0}" 
                    value="${data[i].range.value ? data[i].range.value : data[i].range.min}" 
                    oninput="Slider_Output(${i}, ${data[i].range.multiplier}, ${data[i].range.currency})"
                    style="${data[i].style}"
                    ${data[i].disabled ? "disabled" : ""}
                />
                <output id='label${i}'></output>
                </div>
            </div>
            `
    );

    MouseEnter(data[i].disabled, element)
    $('#buttons').append(element);
    ShiftkeyAndMouseWheel(i, data)
    Buttons[i] = element
    Button[i] = data[i]
}

function Slider_Output(index, multiplier, currency) {
    $('#range' + index).data('updated', new Date().getTime());
    setTimeout(() => {
        if (new Date().getTime() - ms >= $('#range' + index).data('updated')) {
            let inp2 = 'label' + index
            let range = 'range' + index
            let i2 = document.getElementById(inp2)
            let e_range = document.getElementById(range)
            if (currency) {
                if (multiplier) {
                    i2.innerHTML = 'Quantity: ' + e_range.value + ' | Price: ' + formatter.format(e_range.value * multiplier);
                } else {
                    i2.innerHTML = formatter.format(e_range.value);
                }
            } else {
                if (multiplier) {
                    i2.innerHTML = e_range.value * multiplier;
                } else {
                    i2.innerHTML = e_range.value;
                }
            }
        }
    }, ms);
}

function bar_search(data, i) {
    let element = $(`
            <div class="${data[i].disabled ? "searchbarDisabled" : "searchbar"} ${data[i].spacer ? "is-spacer" : ""}" id=${i} ${data[i].style ? `style="${data[i].style}"` : ""}>
                <div class="icon"> <i class="fa-solid fa-magnifying-glass" id=${i}></i> </div>
                <input type="text" id="${data[i].disabled ? "searchDisabled" : "search"}" ${data[i].disabled ? "disabled" : ""} placeholder="Search ...">
            </div>
            `
    );
    $('#buttons').append(element);
    Buttons[i] = element
    Button[i] = data[i]
}

function _search(Button, i, type, searchText) {
    let _string = Button[i][type].toString()
    _string = _string.replace(/\s/g, '').toLowerCase()
    searchText = searchText.replace(/\s/g, '').toLowerCase()
    if (_string.indexOf(searchText) != -1) {
        Buttons[i].fadeIn(search_fade_animation, 'swing')
    } else {
        Buttons[i].fadeOut(search_fade_animation, 'swing')
    }
    return (_string.indexOf(searchText) != -1)
}

function make_buttons(data, i, rtl) {
    // @swkeep: changed context to subheader as i always do :)
    let element = $(`
                <div class="${data[i].disabled ? "buttonDisabled" : "button"} ${data[i].is_header ? "is-header" : ""} ${data[i].spacer ? "is-spacer" : ""} ${data[i].dark ? "dark" : ""}" id=${i} ${data[i].style ? `style="${data[i].style}"` : ""}>
                <!-- @swkeep: added back/leave/icon -->
                ${data[i].back && !data[i].disabled ? `<div class="icon" id=${i}> <i class="${rtl ? 'fa-solid fa-angle-right' : 'fa-solid fa-angle-left'}" id=${i}></i> </div>` : ""}
                ${data[i].leave && !data[i].disabled && !data[i].back ? `<div class="icon"> <i class="fa-solid fa-circle-xmark" id=${i}></i> </div>` : ""}
                ${data[i].icon ? `<div class="icon" id=${i}> <i class="${data[i].icon}" id=${i}></i> </div>` : ""}
    
                <!-- @swkeep: added column to support icon -->
                    <div class="column">
                        ${data[i].header ? `<div class="header" id=${i}>${data[i].header}</div>` : ""}
                        ${data[i].subheader ? `<div class="context" id=${i}>${data[i].subheader}</div>` : ""}
                        ${data[i].footer ? `<div class="footer" id=${i}>${data[i].footer}</div>` : ""}
                        <!-- @swkeep: changed subMenu to submenu :) -->
                        ${data[i].submenu && !data[i].disabled ? `<svg class="submenuicon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M5 3l3.057-3 11.943 12-11.943 12-3.057-3 9-9z"/></svg>` : ""}
                    </div>
                ${data[i].image ? `<img class="imageHover" src="${data[i].image}"/>` : ""}
                ${data[i].hover_information ? `<div class="hover_information">${data[i].hover_information}</div>` : ""}
                </div>
                `
    );
    MouseEnter(data[i].disabled, element)
    $('#buttons').append(element);
    Buttons[i] = element
    Button[i] = data[i]
}

$('#container').on('input', '#search', delay(function () {
    let searchText = this.value;
    let found = false
    if (searchText == "") {
        for (let i = 1; i < Buttons.length; i++) {
            // if buttons are not searchable don't use fade animation
            if (Button[i] == undefined) continue
            if (Button[i].searchable != true) {
                Buttons[i].show()
            } else {
                Buttons[i].fadeIn(search_fade_animation, 'swing')
            }
        }
        return
    }
    for (let i = 0; i < Button.length; i++) {
        if (Button[i] == undefined) continue
        if (Button[i].searchable != true) {
            Buttons[i].show()
        } else {
            let h, s, f = false

            if (Button[i].header) {
                h = _search(Button, i, 'header', searchText)
            }
            if (Button[i].subheader && h == false) {
                s = _search(Button, i, 'subheader', searchText)
            }
            if (Button[i].footer && s == false) {
                f = _search(Button, i, 'footer', searchText)
            }
            if (!found) {
                found = h ^ s ^ f
            }
        }
    }
    if (found) {
        SearchDoneSfx()
    } else {
        SearchFailedSfx()
    }
}, search_type_delay));

const DrawButtons = (data, rtl) => {
    for (let i = 0; i < data.length; i++) {
        if (data[i].hide) {
            // hide element
            continue
        }

        if (data[i].next) {
            btn_next(data, i)
        } else if (data[i].pervious) {
            btn_pervious(data, i)
        } else if (data[i].search) {
            bar_search(data, i)
        } else if (data[i].leave) {
            btn_leave(data, i)
        } else if (data[i].pin) {
            btn_pin(data, i)
        } else if (data[i].range_slider) {
            range_slider(data, i)
        } else {
            make_buttons(data, i, rtl)
        }
    }
};

$(document).click(function (event) {
    let $target = $(event.target);
    if (($target.closest('.leave').length && $('.leave').is(":visible")) || ($target.closest('.pin').length && $('.pin').is(":visible")) || ($target.closest('.stepper').length && $('.stepper').is(":visible")) || ($target.closest('.button').length && $('.button').is(":visible"))) {
        let id = event.target.id;
        if (Button[id]) {
            let slider = document.getElementsByClassName('range_slider')
            let res = {}
            for (const iterator of slider) {
                if (iterator.name && iterator.value) {
                    res[iterator.name] = parseInt(iterator.value)
                }
            }
            if (Button[id].disabled || false) return;
            // <!-- @swkeep: support for no args actions -->
            if (Button[id].is_header || false) return;

            if (!Button[id].event && !Button[id].action && !Button[id].leave && !Button[id].args) {
                console.warn('WARNING: No event, action or args to perform!');
                return;
            }
            if (res) {
                PostData(id, res)
            } else {
                PostData(id)
            }
        }
    }
})

const PostData = (id, other_inputs) => {
    $.post(`https://${GetParentResourceName()}/dataPost`, JSON.stringify({ id: id, other_inputs: other_inputs }))
}

const CancelMenu = () => {
    $.post(`https://${GetParentResourceName()}/cancel`)
}


const SFX = () => {
    $.post(`https://${GetParentResourceName()}/mouse:move:sfx`)
}

const SFX_Search_Done = () => {
    $.post(`https://${GetParentResourceName()}/mouse:search_found:sfx`)
}

const SFX_Search_Failed = () => {
    $.post(`https://${GetParentResourceName()}/mouse:search_not_found:sfx`)
}


window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const rtl = data.rtl
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info, rtl);
        case "OPEN_OVERLAY":
            return CreateOverlay(info);
        case 'CLOSE_OVERLAY':
            return CloseOverlay()
        case "CLOSE_MENU":
            return CloseMenu();
        case "CANCEL_MENU":
            return CancelMenu();
        default:
            return;
    }
})

window.addEventListener("keyup", (ev) => {
    if (ev.code === 'Escape') {
        CancelMenu();
    }
})
