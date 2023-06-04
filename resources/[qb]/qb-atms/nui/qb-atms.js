var Config = new Object();
Config.closeKeys = [69];
Config.ATMTransLimit = 5000;
var currentLimit = null;
var clientPin = null;
var cardSelected = null
var clientCid = null
var cardNumb = null

window.addEventListener("message", function (event) {    
    if(event.data.status == "openATMFrontScreen") {
        populateCurrentCards(event.data);
        $('#cardSelector').css({"display":"block"});
    } else if(event.data.status == "loadBankAccount") {
        $("#currentStatementATM").DataTable().destroy();
        ATMStatement(event.data.information.statement);
        $('#bankingHomeATM-tab').tab('show')
        $("#currentBalanceATM1").html(event.data.information.bankbalance);
        $("#accountNameATM").html(event.data.information.name);
        $("#accountNumberATM").html(event.data.information.accountinfo);
        $("#withdrawATMErrorMsg").removeClass('alert-success').addClass('alert-danger');
        $("#successMessageATM").removeClass('alert-danger').addClass('alert-success');
        $("#withdrawATMError").css({"display":"none"});
        $("#withdrawATMErrorMsg").html('');
        $("#currentBalanceATM1").html('$' + event.data.information.bankbalance);
        $("#customerNameATM").html(event.data.information.name);
        $("#currentBalanceATM").html('$' + event.data.information.bankbalance);
        $("#currentCashBalanceATM").html('$' + event.data.information.cash);
        $("#currentCashBalance1ATM").html('$' + event.data.information.cash);
        $('#pinContainer').css({"display":"none"});
        $("#ATMContainer").css({"display":"block"});
    } else if(event.data.status == "closeATM") {
        $('#cardSelector').css({"display":"none"});
        $('#pinContainer').css({"display":"none"});
        $("#ATMContainer").css({"display":"none"});
        $('#pinCode').val('');
    }
});

function populateCurrentCards(data) {
    $('#cardsDisplay').html('');
    $.each(data.cards, function(index, card) {
        
        if(card.cardType == "visa") {
            image = "visa.png"
        } else {
            image = "mastercard.png"
        }
        var str = ""+ card.cardNumber + "";
        var res = str.slice(12);
        var cardNumber = "************" + res;
        if(card.cardActive !== undefined && card.cardActive !== null && card.cardActive === true) {
            cardStatus = '<span class="text-success">(Active)</span> ';
            $('#cardsDisplay').append('<div class="card mb-3 mx-auto" style="width:100%; background:#505050; box-shadow: 0 3px 10px rgb(0 0 0 / 0.2); color: #dcdcdc"><div class="row no-gutters"><div class="col-2 my-auto text-center"><img src="images/' + image + '" class="img-fluid" width="100" alt=""></div><div class="col-8"><div class="card-body p-0"><h5 class="card-title pb-0 pt-1 pl-2 mb-0" style="color: #fff" id="cardOwner-' + index + '">' + card.name + '</h5><p class="card-text pl-2"><small class="text-muted"><span style="color: #fff" id="cardType-' + index + '">' + cardStatus + '' + card.cardType + '</span><br><span style="color: #a8a8a8; font-size: 12px;" id="cardNumber-' + index + '">' + cardNumber + '</span></small></p></div></div><div class="col-2 my-auto pr-1"><button class="btn btn-primary btn-sm btn-block" style="font-size: 12px;" id="cardBtn-' + index + '" data-action="useCard">Use</button></div></div></div>');
        } else {
            cardStatus = '';
            $('#cardsDisplay').append('<div class="card mb-3 mx-auto" style="width:100%; background:#505050; box-shadow: 0 3px 10px rgb(0 0 0 / 0.2); color: #dcdcdc"><div class="row no-gutters"><div class="col-2 my-auto text-center"><img src="images/' + image + '" class="img-fluid" width="100" alt=""></div><div class="col-8"><div class="card-body p-0"><h5 class="card-title pb-0 pt-1 pl-2 mb-0" style="color: #fff" id="cardOwner-' + index + '">' + card.name + '</h5><p class="card-text pl-2"><small class="text-muted"><span style="color: #fff" id="cardType-' + index + '">' + cardStatus + '' + card.cardType + '</span><br><span style="color: #a8a8a8; font-size: 12px;" id="cardNumber-' + index + '">' + cardNumber + '</span></small></p></div></div><div class="col-2 my-auto pr-1"><button class="btn btn-danger btn-block" style=" font-size: 11px;" id="cardBtn-' + index + '" data-action="removeCard">Remove</button></div></div></div>');
        }
        
        $('#cardBtn-' + index).data('card', card);
    });
}

function dynamicSort(property) {
    var sortOrder = 1;
    if(property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a,b) {
        var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
        return result * sortOrder;
    }
}

function ATMStatement(data) {
    $("#currentStatementContentsATM").html('');
    if(data !== undefined) {
        data.sort(dynamicSort("date"));
        $.each(data, function (index, statement) {
        if(statement.deposited == null && statement.deposited == undefined) {
            deposit = "0"
        } else {
            deposit = statement.deposited
        }
        if(statement.withdraw == null && statement.withdraw == undefined) {
            withdraw = "0"
        } else {
            withdraw = statement.withdraw
        }
        if (statement.balance == 0) {
            balance = '<span class="text-dark">$' + statement.balance + '</span>';
        } else if (statement.balance > 0) {
            balance = '<span class="text-success">$' + statement.balance + '</span>';
        } else {
            balance = '<span class="text-danger">$' + statement.balance + '</span>';
        }
        $("#currentStatementContentsATM").append('<tr class="statement"><td><small>' + statement.date + '</small></td><td><small>' + statement.type + '</small></td><td class="text-center text-danger"><small>$' + withdraw + '</small></td><td class="text-center text-success"><small>$' + deposit + '</small></td><td class="text-center"><small>' + balance + '</small></td></tr>');

    });

    $(document).ready(function() {
        $('#currentStatementATM').DataTable({
            "order": [[ 0, "desc" ]],
            "pagingType": "simple",
            "lengthMenu": [[20, 35, 50, -1], [20, 35, 50, "All"]]
        });
    } );
    }
}

function closeBanking() {
    $.post("https://qb-atms/NUIFocusOff", JSON.stringify({}));
    currentLimit = null;
    clientPin = null;
    cardSelected = null;
    clientCid = null;
    cardNumb = null;
};

$( function() {
    $("body").on("keydown", function (key) {
        if (Config.closeKeys.includes(key.which) || key.keyCode == 27) {
            closeBanking();
        }

        if ($('#pinContainer').is(':visible')) {
            if (key.which >= 48 && key.which <= 57) { // 48 - 57 (0-9 keys)
                var currentVal = $('#pinCode').val();
                var number = key.which - 48;
                $('#pinCode').val(currentVal + number);
            } else if (key.which >= 96 && key.which <= 105) { //96 - 105 (0-9 numberpad)
                var currentVal = $('#pinCode').val();
                var number = key.which - 96;
                $('#pinCode').val(currentVal + number);
            } else if (key.which == 13) {
                var currentVal = $('#pinCode').val();
                if (currentVal == clientPin) {
                    $('#errorMsg').addClass('alert-info').removeClass('alert-danger');
                    $('#errorMsg').html('Please enter your debit card pin, to access the ATM.');
                    $('#pinCode').val('');
                    $.post("https://qb-atms/loadBankingAccount", JSON.stringify({
                        cid: clientCid,
                        cardnumber: cardNumb
                    }));
                } else {
                    $('#pinCode').val('');
                    $('#errorMsg').removeClass('alert-info').addClass('alert-danger');
                    $('#errorMsg').html('You have entered an incorrect pin, please try again.')
                    setTimeout(function () {
                        $('#errorMsg').addClass('alert-info').removeClass('alert-danger');
                        $('#errorMsg').html('Please enter your debit card pin, to access the ATM.');
                    }, 5000);
                }
            }
        }
    });

    $(document).on('click','#logoffbuttonatm, #cancelTransaction',function(){
        closeBanking();
    });

    $(document).on('click','[data-action=useCard]',function(){
        $.post("https://qb-atms/playATMAnim", JSON.stringify({}));
        var selectedCard = $(this).data('card')
        clientPin = selectedCard.cardPin;
        cardSelected = selectedCard
        clientCid = selectedCard.citizenid;
        cardNumb = selectedCard.cardNumber
        $('#cardSelector').css({"display":"none"});
        $('#pinContainer').css({"display":"block"});
    });
    
    $(document).on('click','[data-action=removeCard]',function(){
        var selectedCard = $(this).data('card')
        $.post("https://qb-atms/removeCard", JSON.stringify({
            cardNumber: selectedCard.cardNumber,
            cardType: selectedCard.cardType
        }));
    });

    document.querySelector('#withdrawAmountATM').addEventListener('keyup', (evt) => {
        document.querySelector('[data-withdrawal=manual]').setAttribute('data-amount', evt.target.value);
    });

    document.querySelectorAll('[data-withdrawal]').forEach(function (element) {
        element.addEventListener('click', (evt) => {
            const amount = evt.target.getAttribute('data-amount');
            const errorMessage = document.getElementById('withdrawATMErrorMsg');
            errorMessage.classList.add('d-none');

            if (amount == undefined || amount == null || amount <= 0) {
                errorMessage.classList.remove('d-none');
                return errorMessage.innerHTML = 'An error occurred with your withdrawal, please try again.';
            }

            $.post("https://qb-atms/doATMWithdraw", JSON.stringify({
                amount: parseInt(amount),
                cid: clientCid,
                cardnumber: cardNumb
            }));
        });
    });

    $(document).on('click','[data-act=enterNumber]',function(){
            var number = $(this).data('number');
            if (number == "ACCEPT") {
                var currentVal = $('#pinCode').val();
                if (currentVal == clientPin) {
                    $('#errorMsg').addClass('alert-info').removeClass('alert-danger');
                    $('#errorMsg').html('Please enter your debit card pin, to access the ATM.');
                    $('#pinCode').val('');
                    $.post("https://qb-atms/loadBankingAccount", JSON.stringify({
                        cid: clientCid,
                        cardnumber: cardNumb
                    }));
                } else {
                    $('#pinCode').val('');
                    $('#errorMsg').removeClass('alert-info').addClass('alert-danger');
                    $('#errorMsg').html('You have entered an incorrect pin, please try again.')
                    setTimeout(function(){ 
                        $('#errorMsg').addClass('alert-info').removeClass('alert-danger');
                        $('#errorMsg').html('Please enter your debit card pin, to access the ATM.');
                    }, 5000);
                }
            } else if (number == "CLEAR") {
                $('#pinCode').val('');
            } else if (number == "CANCEL") {
                closeBanking();
            } else {
                var currentVal = $('#pinCode').val();
                $('#pinCode').val(currentVal+number);
            }
        });

});
