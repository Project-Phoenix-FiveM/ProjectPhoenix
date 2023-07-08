var keypad = null;
let onClickAudio = new Audio("https://cdn.discordapp.com/attachments/1053976576179568721/1061414043937689742/hack-click.mp3"); // You can replace this with your own audio files if you wish.
let successAudio = new Audio("https://cdn.discordapp.com/attachments/1053976576179568721/1061411326158716928/hack-success.mp3") // You can replace this with your own audio files if you wish.
var canclick = true;

class Keypad {
  clickKey(key) {
    if (this.lockKeys == false) {
        if (this.progress === 0 && this.setProgress === 0) {
          this.startTime = new Date();
        }
  
        onClickAudio.play();

        if (key === this.sequence[this.setProgress]) {
          this.correctKeyClicked(key);
          canclick = false;
          setTimeout(() => {
            canclick = true;
          }, 300);
        } else {
          this.incorrectKeyClicked();
        }

    }
  }

  reset(sequenceLength) {
    this.sequenceLength = sequenceLength;
    this.setSequence(sequenceLength);
    this.progress = 0;
    this.showSequence(0);
    this.setProgress = 0;
  }
  
  setSequence(length) {
    this.sequence = []
    for (var i = 0; i < length; i++) {
      this.sequence.push(Math.floor(Math.random() * Math.floor(this.fieldSize * this.fieldSize)))
    }
  }
  
  correctKeyClicked(key) {
    var button = document.getElementById('key_'+(key));
    this.setProgress +=1;
    button.className = "keypad__key keypad__key--clicked_correct";
    var timeout = setTimeout(() => {button.className = "keypad__key"}, 300)

    if (this.setProgress > this.progress) {
      this.setProgress = 0;
      if (this.progress + 1 === this.sequenceLength) {
        this.blinkKeys(true, 0);
        setTimeout(() => 
          this.reset(this.sequenceLength)
        , 1000)
        timeout = 0;
        successAudio.play()
        $.post('https://simonsays/success', JSON.stringify({}));
        var container = document.getElementById('container');
        container.style.display = 'none';
      } else {
        this.progress +=1;
        setTimeout( ()=> {this.showSequence(this.progress);}, 500);
      }
    }
  }

  incorrectKeyClicked() {
    this.blinkKeys(false, 0)
    setTimeout(() => {
      this.reset(this.sequenceLength);
      $.post('https://simonsays/failed', JSON.stringify({}));
      var container = document.getElementById('container');
      container.style.display = 'none';
    }, 1750);
  }
  
  async showSequence(progress) {
    this.lockKeys = true;
    for(var i = 0; i < ( progress + 1); i++) {
      var highlightButton = document.getElementById("key_" + (this.sequence[i]));
      await sleep(100);
      highlightButton.className = 'keypad__key keypad__key--highlight';
      await sleep(300);
      highlightButton.className = 'keypad__key';
      if (i === progress) {
        this.lockKeys = false;
      }
    }
  }
  
  blinkKeys(correct, count = 0) {
      var keys = document.getElementsByClassName('keypad__key');
      for (var i = 0; i < keys.length; i++) {
        if (correct) {
          keys[i].className = "keypad__key keypad__key--clicked_correct";
        } else {
          keys[i].className = "keypad__key keypad__key--clicked_incorrect";
        }
      }
      setTimeout(() => {
        for (var i = 0; i < keys.length; i++) {
          keys[i].className = 'keypad__key';
        }
      }, 200);
    if (count < 2) {
      setTimeout(() => {this.blinkKeys(correct, (count+1));}, 500);
    }
  }
  
  drawButtons(fieldSize) {
    this.fieldSize = fieldSize;
    const keypadContainer = document.getElementById('keypad')
    while (keypadContainer.firstChild) {
      keypadContainer.removeChild(keypadContainer.lastChild);
    }
    var keyNumber = 0;
    for (var i = 0; i < fieldSize; i++) {
      var keypadRow = document.createElement('div');
      keypadRow.className = "keypad__row";
      for (var j = 0; j < fieldSize; j++) {
        var keypadKey = document.createElement('div');
        const keyIdString = keyNumber;
        keypadKey.className = "keypad__key";
        keypadKey.onclick = () => {
          if (canclick) {
            keypad.clickKey(keyIdString);
          };
        };
        keypadKey.id = "key_" + keyNumber;
        keypadKey.style.height = Math.floor(100 * (1/(fieldSize + 1))) + "vw";
        keypadKey.style.width = Math.floor(100 * (1/(fieldSize + 1))) + "vw";
        keyNumber +=1;
        keypadRow.append(keypadKey);
      }
      keypadContainer.append(keypadRow);
    }
  }
  
  handleSizeChange() {
    const sizeInput = document.getElementById('sizeInput');
    console.log(sizeInput.value);
    if(sizeInput.value > 1 && sizeInput.value < 6) {
      this.drawButtons(parseInt(sizeInput.value));
    }
    this.reset(this.sequenceLength);
  }
  
  handleSequenceChange() {
    const sequenceInput = document.getElementById('sequenceInput');
    this.reset(parseInt(sequenceInput.value));
  }
}

window.addEventListener('message', function (event) {
  var event = event.data;
  if (!event.buttonGrid || !event.length) {
    BeginHack(3, 5);
  } else {
    BeginHack(event.buttonGrid, event.length);
  };
});

function BeginHack(buttonGrid, length) {
  var container = document.getElementById('container');
  container.style.display = 'flex';
  
  keypad = new Keypad();
  keypad.drawButtons(buttonGrid);
  keypad.reset(length);
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
