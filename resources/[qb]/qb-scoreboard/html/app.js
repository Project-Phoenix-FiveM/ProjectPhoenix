window.addEventListener("message", (event) => {
  switch (event.data.action) {
    case "open":
      Open(event.data);
      break;
    case "close":
      Close();
      break;
    case "setup":
      Setup(event.data);
      break;
  }
});

const Open = (data) => {
  $(".scoreboard-block").fadeIn(150);
  $("#total-players").html("<p>" + data.players + " of " + data.maxPlayers + "</p>");

  $.each(data.requiredCops, (i, category) => {
    var beam = $(".scoreboard-info").find('[data-type="' + i + '"]');
    var status = $(beam).find(".info-beam-status");

    // For anyone wondering, this does work, you can leave the brackets out if you have just one line of code to execute
    if (category.busy)
      $(status).html('<i class="fas fa-clock"></i>');
    else if (data.currentCops >= category.minimumPolice)
      $(status).html('<i class="fas fa-check"></i>');
    else
      $(status).html('<i class="fas fa-times"></i>');
  });
};

const Close = () => {
  $(".scoreboard-block").fadeOut(150);
};

const Setup = (data) => {
  let scoreboardHtml = "";
  $.each(data.items, (index, value) => {
    scoreboardHtml += `
      <div class="scoreboard-info-beam" data-type=${index}>
        <div class="info-beam-title">
            <p>${value}</p>
        </div>
        <div class="info-beam-status"></div>
      </div>
    `;
  });
  scoreboardHtml += `
    <div class="scoreboard-info-beam" style="background: #dc143c">
      <div class="info-beam-title-players">
        <p>Total Players</p>
      </div>
      <div class="info-beam-status" id="total-players" style="color: #ededed"></div>
    </div>
  `;
  $(".scoreboard-info").html(scoreboardHtml);
};
