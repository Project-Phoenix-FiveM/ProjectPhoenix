const app = Vue.createApp({
    data() {
        return {
            coords: "",
            heading: "",
            hash: "",
            doorlockStyleObject: {
                "display": "none",
                "background-color": "rgb(19, 28, 74)"
            },
            doorlockClassObject: {
                "slide_in": false,
                "slide_out": false
            },
            doorText: ""
        }
    },
    mounted() {
        this.listener = window.addEventListener("message", (event) => {
            switch (event.data.type) {
                case "setText":
                    this.setText(event.data);
                    break;
                case "setDoorText":
                    this.setDoorText(event.data)
                    break;
                case "audio":
                    this.playAudio(event.data)
                    break;
                default:
                    break;
            }
        })
    },
    beforeUnmount() {
        window.removeEventListener(this.listener);
    },
    methods: {
        setText(data) {
            if (data.aim) {
                const element = document.getElementById("aim");
                element.style.display = data.aim;
            }

            if (data.details) {
                this.coords = data.coords;
                this.heading = data.heading;
                this.hash = data.hash;
                const element = document.getElementById("textDetails");
                element.style.display = data.details;
            }
        },
        setDoorText(data) {
            if (data.enable) {
                if (this.doorlockStyleObject["display"] == "none") {
                    this.doorlockClassObject["slide_in"] = true;
                    this.doorlockStyleObject["display"] = "flex";
                }
                this.doorlockStyleObject["background-color"] = data.color;
                this.doorText = data.text;
            } else {
                this.doorlockClassObject["slide_in"] = false;
                this.doorlockClassObject["slide_out"] = true;
                setTimeout(() => {
                    this.doorlockStyleObject["display"] = "none";
                    this.doorlockClassObject["slide_out"] = false;
                    this.doorText = "";
                }, 1000);
            }
        },
        playAudio(data) {
            var volume = (data.audio['volume'] / 10) * data.sfx
            if (data.distance !== 0) volume /= data.distance;
            if (volume > 1.0) volume = 1.0;
            const sound = new Audio('sounds/' + data.audio['file']);
            sound.volume = volume;
            sound.play();
        }
    }
}).mount('#mainContainer');
