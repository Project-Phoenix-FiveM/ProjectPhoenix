window.timeBlocksShows = 0; //4.5sec
window.timeUntilLose = 0; //12sec
window.correctBlocksNum = 0;
window.maxIncorrectBlocksNum = 0;
window.allBlocksNum = 36;
window.activateClicking = false;

ThermiteNew = {}

$(document).ready(function(){
    $(".container").hide()
})

$(document).ready(function(){
ThermiteNew.Start = function(data) {

    $(".container").show()
    $(".grid").removeClass("won");

    $(".grid").removeClass("won");
    $(".grid").removeClass("lost");
    hideAllBlocks();
    window.maxIncorrectBlocksNum = data.incorrect;
    window.correctBlocksNum = data.correct;
    window.timeBlocksShows = data.showtime; 
    window.timeUntilLose = data.losetime; 
    window.gridCorrectBlocks = generateRandomNumberBetween(1, 36, data.correct);
    window.activateClicking = false;
    showCorrectBlocks();
    setTimeout(()=>{
    hideAllBlocks();
    window.activateClicking = true;
    }, timeBlocksShows*1000);
    setTimeout(()=>{
        isGameForeited();
    }, timeUntilLose*1000);
}


window.addEventListener('message', function(event){
  var action = event.data.action;
  switch(action) {
      case "Start":
          ThermiteNew.Start(event.data);
          break;
      }
  });
})

$(document.body).on("click", ".block", onBlockClick);

function generateRandomNumberBetween(min=1,max=window.allBlocksNum,length = window.correctBlocksNum){
  var arr = [];
  while(arr.length < length){
      var r = Math.floor(Math.random() * (max+1-min)) + min;
      if(arr.indexOf(r) === -1) arr.push(r);
  }
  return arr;
}

function onBlockClick(e){
  if(!activateClicking){
    return;
  }
  
  let clickedBlock = e.target;
  
  let blockNum = clickedBlock.classList.value.match(/(?:block-)(\d+)/)[1];
  blockNum = Number(blockNum);
  let correctBlocks = window.gridCorrectBlocks;

  let correct = correctBlocks.indexOf(blockNum) !== -1;
  clickedBlock.classList.add("clicked");
  if(correct){
    clickedBlock.classList.remove("incorrect");
    clickedBlock.classList.add("correct");
  }
  else{
    clickedBlock.classList.add("incorrect");
    clickedBlock.classList.remove("correct");
  }
checkWinOrLost();
}

function showCorrectBlocks(){
  
  $(".block").each((i,ele)=>{
    let blockNum = ele.classList.value.match(/(?:block-)(\d+)/)[1];
    blockNum = Number(blockNum);
    let correctBlocks = window.gridCorrectBlocks;
    let correct = correctBlocks.indexOf(blockNum) !== -1;
    if(correct){
      ele.classList.add("show");
    }
  });
}
function hideAllBlocks(){
  $(".block").each((i,ele)=>{
    ele.classList.remove("show");
    ele.classList.remove("correct");
    ele.classList.remove("incorrect");
    ele.classList.remove("clicked");
  });
}

function checkWinOrLost(){
  if(isGameWon()){
    hideAllBlocks()
    window.activateClicking = false;
    $(".container").hide()
    $.post('https://memorygame/ThermiteResult', JSON.stringify({
        success: true
    }));
  }
  if(isGameLost()){
    hideAllBlocks();
    $(".container").hide()
    window.activateClicking = false;
    $.post('https://memorygame/ThermiteResult', JSON.stringify({
        success: false
    }));
  }
 
}

function isGameWon(){
  return $(".correct").length >= (window.correctBlocksNum);
}
function isGameLost(){
  return $(".incorrect").length >= window.maxIncorrectBlocksNum;
};

function isGameForeited(){
    if (window.activateClicking ){
        hideAllBlocks();
        $(".container").hide()
        window.activateClicking = false;
        $.post('https://memorygame/ThermiteResult', JSON.stringify({
            success: false
        }));
    }       
}