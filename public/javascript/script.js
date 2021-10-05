
    var call = function(elementId){
      console.log(elementId)
  var drawer = document.getElementById(elementId)
    if (drawer.style.display == "none"){
        drawer.style.display = "block";
  } else {
        drawer.style.display = "none";
  }
}

  var flip = function(elementId, frameId){
    var frame = document.getElementById(frameId);
    var front = document.getElementById(elementId);
    var temp = document.getElementById(elementId).innerHTML;
    var back = document.getElementById('backOfCard');
      if( front.side  == "front") {
    front.innerHTML = back.innerHTML;
    frame.style.backgroundColor="white";
    frame.style.color = "black";
    front.side = back;
    back.innerHTML = temp;
    } else {
      front.innerHTML = back.innerHTML;
        frame.style.backgroundColor = "blue";
        frame.style.color = "white";
        front.side="front";
      back.innerHTML = temp;
      console.log("Flip");
    }
  };



  var previous = function (displayId) {
    var arrayLength = document.getElementById('array-length');
    var display = document.getElementById(displayId);
    var moreInfo = document.getElementById('more-info');
    var touches = document.getElementById('touches');
    var rating = document.getElementById('rating');
    var lastView = document.getElementById('last_view');

    var entryExample  = document.getElementById('entry-example');
    var backOfCard = document.getElementById('backOfCard');

    var cardIndex = document.getElementById('cardIndex');

    var previousId = Number(cardIndex.innerHTML) - 1;
    if(previousId >= 0){
    cardIndex.innerHTML = previousId;
    } else {
      cardIndex.innHTML = 0;
      previousId = 0;
    };

    var previousCardClass = document.getElementsByClassName(Number(previousId))
    display.innerHTML = previousCardClass[0].innerHTML;
    backOfCard.innerHTML = previousCardClass[1].innerHTML;
    moreInfo.innerHTML = previousCardClass[2].innerHTML;
    entryExample.innerHTML = previousCardClass[3].innerHTML;
    touches.innerHTML = previousCardClass[4].innerHTML;
    rating.innerHTML = previousCardClass[5].innerHTML;
    lastView.innerHTML = previousCardClass[6].innerHTML;
    console.log("previous!!")

};

  var next = function (displayId) {
    var arrayLength = document.getElementById('array-length').innerHTML;
    var display = document.getElementById(displayId);
    var moreInfo = document.getElementById('more-info');
    var touches = document.getElementById('touches');
    var rating = document.getElementById('rating');
    var lastView = document.getElementById('last_view');

    var entryExample = document.getElementById('entry-example');
    var backOfCard = document.getElementById('backOfCard');

    var cardIndex = document.getElementById('cardIndex');
    
    var nextId = Number(cardIndex.innerHTML) + 1;
    if (nextId <= Number(arrayLength) - 1) {
      cardIndex.innerHTML = nextId;
    } else {
      cardIndex.innerHTML = Number(arrayLength) - 1;
      nextId = Number(arrayLength) - 1;
    };
    
    var nextCardClass = document.getElementsByClassName(Number(nextId));
    display.innerHTML = nextCardClass[0].innerHTML;
    backOfCard.innerHTML = nextCardClass[1].innerHTML;
    moreInfo.innerHTML = nextCardClass[2].innerHTML;
    entryExample.innerHTML = nextCardClass[3].innerHTML;
    touches.innerHTML = nextCardClass[4].innerHTML;
    rating.innerHTML = nextCardClass[5].innerHTML;
    lastView.innerHTML = nextCardClass[6].innerHTML;
    console.log("next!!")

};


var math = function(number){
  
  console.log(number)

}


var reveal = function(word, elem, color) {
  elem.style.background = color;
  console.log(word);
  var wordNodes = document.getElementsByClassName(word);
  console.log(wordNodes.length);
  
for(let card of wordNodes){
    if (card.style.display == 'none') {
      card.style.display = 'block';
    } else {
      card.style.display = 'none';
    }
  }
 
  
}


var colorChange = function(color){
  this.style.background = color;
}


var clicked = function clicked(e) {
  if (!confirm('Are you sure?')) {
    e.preventDefault();
  }
}






