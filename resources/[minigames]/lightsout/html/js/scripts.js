var onClickAudio = new Audio("https://cdn.discordapp.com/attachments/1053976576179568721/1061414043937689742/hack-click.mp3");
var successAudio = new Audio("https://cdn.discordapp.com/attachments/1053976576179568721/1061411326158716928/hack-success.mp3")
var maxClicks = 20;
var canClick = true;
var clicks = 0;

class LightsOut {
  LightsOut(size, elem, maxClicks) {
    var container = document.getElementById('lights-out');
    container.style.display = 'flex';
    this.size = size;
    this.elem = elem;
    this.board = [];
    clicks = 0;
    maxClicks = maxClicks;
    for (let i = 0; i < this.size; i++) {
      this.board.push([]);
      
      for (let j = 0; j < this.size; j++) {
        this.board[i].push(0);
      }
    }
    lightsOut.randomize();
  };

  isComplete() {
    for (let i = 0; i < this.board.length; i++) {
      for (let j = 0; j < this.board[i].length; j++) {
        if (this.board[i][j] === 0) {
          return false;
        }
      }
    }
    return true;
  };

  print() {
    let output = "<table>";
    for (let i = 0; i < this.board.length; i++) {
      output += "<tr>";
      
      for (let j = 0; j < this.board[i].length ;j++) {
        output += "<td onclick='moveHandler(this);' id='" + i + "-" + j + "' " +
          "class='" + (this.board[i][j] ? "on" : "off") + "'></td>";
      }
      
      output += "</tr>";
    }
    this.elem.innerHTML = output + "</table>";
  };

  move(row, col, stopPrint) {
    [[0, 0], [-1, 0], [0, -1], [1, 0], [0, 1]].forEach(e => {
      if (this.board[row+e[0]] !== undefined && 
        this.board[row+e[0]][col+e[1]] !== undefined) {
        this.board[row+e[0]][col+e[1]] ^= 1;

        if (!stopPrint) {
          this.printCell(row+e[0], col+e[1]);
        }
      }
    });
  };

  printCell(row, col) {
    let cell = document.getElementById(row + "-" + col);
    if (cell) {
      cell.className = this.board[row][col] ? "on" : "off";
    }
  };

  randomize(amount) {
    amount = amount || 2000;      
    for (let i = 0; i < amount; i++) {
      const row = Math.random () * this.board.length | 0;
      const col = Math.random () * this.board.length | 0;
      this.move(row, col, true);
    }
  };

  blinkKeys(correct, count = 0) {
    var toggledKeys = document.getElementsByClassName('on');
    var notToggledKeys = document.getElementsByClassName('off');
    for (var i = 0; i < toggledKeys.length; i++) {
      if (correct) {
        toggledKeys[i].className = "on";
      } else {
        toggledKeys[i].className = "fail";
      }
    }
    for (var i = 0; i < notToggledKeys.length; i++) {
      if (correct) {
        notToggledKeys[i].className = "on";
      } else {
        notToggledKeys[i].className = "fail";
      }
    }
    setTimeout(() => {
      for (var i = 0; i < toggledKeys.length; i++) {
        toggledKeys[i].className = 'on';
        notToggledKeys[i].className = "off";
      }
    }, 200);
  if (count < 2) {
    setTimeout(() => {this.blinkKeys(correct, (count+1));}, 500);
  }
}
}

function moveHandler(elem) {if (canClick) {
  canClick = false;
  clicks++;
  lightsOut.move(...elem.id.split("-").map(Number));
  onClickAudio.play();
  if (lightsOut.isComplete()) {
    setTimeout(() => {
      successAudio.play();
      let on = document.getElementById("lights-out");
      on.innerHTML = ""
      on.innerHTML = '<i class="fa-solid fa-database" style="transform: translate(11.25vh, -3.1vh);padding-top: 4vh;padding-bottom: 1vh;font-size: 42px;"></i><span style="margin-top: 10vh;margin-right: 5vh;z-index: 4;transform: translate(0.6vh, -2vh);">Database Recovery Success.</span>'
    }, 500);
    finish(true);
  } else {
    if (clicks == maxClicks) {
      let on = document.getElementById("lights-out");
      on.innerHTML = ""
      on.innerHTML = '<i class="fa-solid fa-database" style="transform: translate(10.45vh, -1.1vh);font-size: 42px;"></i><span style="margin-top:10vh;margin-right: 5vh;z-index: 4;transform: translate(0.6vh, -2vh);">Database Recovery Failed</span>'
      finish(false);
    }
  
    setTimeout(() => {
      canClick = true;
    }, 300);
  }
}}


function finish(success) {
  if (success == true) {
    setTimeout(() => {
      $.post('https://lightsout/success', JSON.stringify({}));
      var container = document.getElementById('lights-out');
      container.style.display = 'none';
      canClick = true;
      clicks = 0;
    }, 4000);
  } else {
    setTimeout(() => {
      $.post('https://lightsout/failed', JSON.stringify({}));
      var container = document.getElementById('lights-out');
      container.style.display = 'none';
      canClick = true;
      clicks = 0;
    }, 4000);
  }

}

window.addEventListener('message', function (event) {
  var event = event.data;
  if (event.type == 'lightsout') {
    if (!event.grid || !event.length) {
      StartLightsOut(4, 20);
    } else {
      StartLightsOut(event.grid, event.length);
    };
  };
});

function StartLightsOut(grid, maxClicks) {
  let on = document.getElementById("lights-out");
  on.style.display = 'flex';
  on.innerHTML = ""
  on.innerHTML = '<i class="fa-solid fa-database" style="transform: translate(11.95vh, -3.1vh);padding-top: 4vh;padding-bottom: 1vh;font-size: 42px;"></i><span style="margin-top: 10vh;margin-right: 4.65vh;z-index: 4;transform: translate(0.8vh, -2vh);">Data corrupted, repair required.</span>'
  
  setTimeout(() => {
    lightsOut = new LightsOut();

    if (!grid) {
      grid = 4;
    } 

    if (grid > 5) {
      grid = 5;
    }

    if (grid < 2) {
      grid = 2;
    }
    
    if (!maxClicks) {
      maxClicks = 20;
    }
  
    lightsOut.LightsOut(grid, document.getElementById("lights-out"), maxClicks);
    lightsOut.print();
  }, 4500);
};