let meterStarted = false;

const updateMeter = (meterData) => {
  $("#total-price").html("$ " + meterData.currentFare.toFixed(2));
  $("#total-distance").html(
    (meterData.distanceTraveled).toFixed(2) + " mi"
  );
};

const resetMeter = () => {
  $("#total-price").html("$ 0.00");
  $("#total-distance").html("0.00 mi");
};

const toggleMeter = (enabled) => {
  if (enabled) {
    $(".toggle-meter-btn").html("<p>Started</p>");
    $(".toggle-meter-btn p").css({ color: "rgb(51, 160, 37)" });
  } else {
    $(".toggle-meter-btn").html("<p>Stopped</p>");
    $(".toggle-meter-btn p").css({ color: "rgb(231, 30, 37)" });
  }
};

const meterToggle = () => {
  if (!meterStarted) {
    $.post(
      "https://qb-taxijob/enableMeter",
      JSON.stringify({
        enabled: true,
      })
    );
    toggleMeter(true);
    meterStarted = true;
  } else {
    $.post(
      "https://qb-taxijob/enableMeter",
      JSON.stringify({
        enabled: false,
      })
    );
    toggleMeter(false);
    meterStarted = false;
  }
};

const openMeter = (meterData) => {
  $(".container").fadeIn(150);
  $("#total-price-per-100m").html("$ " + meterData.defaultPrice.toFixed(2));
};

const closeMeter = () => {
  $(".container").fadeOut(150);
};

$(document).ready(function () {
  $(".container").hide();
  window.addEventListener("message", (event) => {
    const eventData = event.data;
    switch (eventData.action) {
      case "openMeter":
        if (eventData.toggle) {
          openMeter(eventData.meterData);
        } else {
          closeMeter();
        }
        break;
      case "toggleMeter":
        meterToggle();
        break;
      case "updateMeter":
        updateMeter(eventData.meterData);
        break;
      case "resetMeter":
        resetMeter();
        break;
      default:
        break;
    }
  });
});
