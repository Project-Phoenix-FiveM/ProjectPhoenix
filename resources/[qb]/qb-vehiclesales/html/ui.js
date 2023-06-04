var app = new Vue({
    el: "#app",
    data: {
        mode: "",
        bizName: "",
        sellerName: "",
        bankAccount: "",
        phoneNumber: "",
        licensePlate: "",
        vehicleDescription: "",
        sellPrice: "",
        showTakeBackOption: false,
        errors: []
    },
    methods: {
        sell(sellPrice) {
            this.errors = [];
            if (this.sellPrice != "") {
                if (!isNaN(sellPrice)) {
                    const requestOptions = {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            price: this.sellPrice,
                            desc: this.vehicleDescription
                        })
                    };
                    fetch("https://qb-vehiclesales/sellVehicle", requestOptions);
                    this.close();
                } else {
                    this.errors.push("Price must be a numeric value only");
                }
            } else {
                this.errors.push("Sale price required")
            }
        },
        buy() {
            const requestOptions = {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({})
            };
            fetch("https://qb-vehiclesales/buyVehicle", requestOptions);
            this.close();
        },
        takeBack() {
            const requestOptions = {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({})
            };
            fetch("https://qb-vehiclesales/takeVehicleBack", requestOptions);
            this.close();
        },
        close() {
            const requestOptions = {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({})
            };
            fetch("https://qb-vehiclesales/close", requestOptions);

            this.resetForm();
            this.hideForm();

        },
        resetForm() {
            this.sellerName = "";
            this.bankAccount = "";
            this.phoneNumber = "";
            this.licensePlate = "";
            this.vehicleDescription = "";
            this.sellPrice = "";
            this.errors = [];
        },
        hideForm() {
            document.body.style.display = "none";
        }

    },
    computed: {
        tax() {
            return (this.sellPrice / 100 * 19).toFixed(0);
        },
        mosleys() {
            return (this.sellPrice / 100 * 4).toFixed(0);
        },
        total() {
            return (this.sellPrice / 100 * 77).toFixed(0);
        }
    }

});

function setupForm(data) {
    if(data.action === "sellVehicle" || data.action === "buyVehicle") {
        document.body.style.display = "block";
    }

    app.mode = data.action;

    app.showTakeBackOption = data.showTakeBackOption;

    app.bizName = data.bizName;

    app.sellerName = data.sellerData.firstname + " " + data.sellerData.lastname;
    app.bankAccount = data.sellerData.account;
    app.phoneNumber = data.sellerData.phone;
    app.licensePlate = data.plate;

    if (data.action === "buyVehicle") {
        app.vehicleDescription = data.vehicleData.desc;
        app.sellPrice = data.vehicleData.price;
    }
}

document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener("message", (event) => {
            this.setupForm(event.data);
        });
    }
};

/* Handle escape key press to close the menu */
document.onkeyup = function (data) {
    if (data.key != "Escape") return;

    app.close();
};
