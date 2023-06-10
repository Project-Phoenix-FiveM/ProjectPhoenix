let RaceActive = false;

const UpdateUI = (data) => {
  if (data.active) {
    if (!RaceActive) {
      RaceActive = true;
      $(".editor").hide();
      $(".race").fadeIn(300);
      $("#race-racename").html(data.data.RaceName);
      let totalRacers = data.data.TotalRacers;
      if (!totalRacers) {
        totalRacers = 0;
      }
      $("#race-position").html(data.data.Position + " / " + totalRacers);
      $("#race-checkpoints").html(
        data.data.CurrentCheckpoint + " / " + data.data.TotalCheckpoints
      );
      if (data.data.TotalLaps == 0) {
        $("#race-lap").html("Sprint");
      } else {
        $("#race-lap").html(data.data.CurrentLap + " / " + data.data.TotalLaps);
      }
      $("#race-time").html(secondsTimeSpanToHMS(data.data.Time));
      if (data.data.BestLap !== 0) {
        $("#race-besttime").html(secondsTimeSpanToHMS(data.data.BestLap));
      } else {
        $("#race-besttime").html("N/A");
      }
      $("#race-totaltime").html(secondsTimeSpanToHMS(data.data.TotalTime));
    } else {
      $("#race-racename").html(data.data.RaceName);
      let totalRacers = data.data.TotalRacers;
      if (!totalRacers) {
        totalRacers = 0;
      }
      $("#race-position").html(data.data.Position + " / " + totalRacers);
      $("#race-checkpoints").html(
        data.data.CurrentCheckpoint + " / " + data.data.TotalCheckpoints
      );
      if (data.data.TotalLaps == 0) {
        $("#race-lap").html("Sprint");
      } else {
        $("#race-lap").html(data.data.CurrentLap + " / " + data.data.TotalLaps);
      }
      $("#race-time").html(secondsTimeSpanToHMS(data.data.Time));
      if (data.data.BestLap !== 0) {
        $("#race-besttime").html(secondsTimeSpanToHMS(data.data.BestLap));
      } else {
        $("#race-besttime").html("N/A");
      }
      $("#race-totaltime").html(secondsTimeSpanToHMS(data.data.TotalTime));
    }
  } else {
    RaceActive = false;
    $(".editor").hide();
    $(".race").fadeOut(300);
  }
};

const Countdown = () => {
  setTimeout(function () {
    $(".show-numbers").fadeIn(300);
    var big = document.querySelector(".show-numbers > .big-outer");
    var small = document.querySelector(".show-numbers > .small-fill");
    setTimeout(function () {
      big.innerHTML = "2";
      small.innerHTML = "2";
    }, 1000);
    setTimeout(function () {
      big.innerHTML = "1";
      small.innerHTML = "1";
    }, 2000);
    setTimeout(function () {
      big.innerHTML = "GO!";
      big.classList.remove("animate-big-left-to-right");
      small.innerHTML = "GO!";
      small.classList.remove("animate-small-left-to-right");
      small.classList.add("show-scale-2");
      small.style.left = "50%";
      small.style.fontSize = "25vh";
    }, 3000);
    setTimeout(function () {
      var show = document.querySelector(".show-numbers");
      show.style.display = "none";
      $(".show-numbers").fadeOut(300);
      big.innerHTML = "3";
      small.innerHTML = "3";
      big.classList.add("animate-big-left-to-right");
      small.classList.add("animate-small-left-to-right");
      small.classList.remove("show-scale-2");
      small.style.fontSize = "10vh";
      small.style.left = "58%";
    }, 4500);
  }, 600);
};

$(document).ready(function () {
  window.addEventListener("message", function ({ data }) {
    switch (data.action) {
      case "countdown":
        Countdown();
        break;
      case "race":
        UpdateUI(data);
        break;
    }
  });
});

function roundUpToPrecision(n, d) {
  var round = n.toPrecision(d);

  if (round === n.toString()) {
    return n;
  }

  return +(
    n +
    0.5 * Math.pow(10, Math.floor(Math.log(n) * Math.LOG10E) - 1)
  ).toPrecision(d);
}

function secondsTimeSpanToHMS(milli) {
  var milliseconds = milli % 1000;
  var seconds = Math.floor((milli / 1000) % 60);
  var minutes = Math.floor((milli / (60 * 1000)) % 60);
  minutes = minutes < 10 ? "0" + minutes : minutes;
  seconds = seconds < 10 ? "0" + seconds : seconds;

  return minutes + ":" + seconds + "." + String(milliseconds).slice(0, 2);
}
