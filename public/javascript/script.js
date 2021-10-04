
    var call = function(elementId){
      console.log(elementId)
  var drawer = document.getElementById(elementId)
    if (drawer.style.display == "none"){
        drawer.style.display = "block";
  } else {
        drawer.style.display = "none";
  }
}

  var flip = function(elementId){
    var front = document.getElementById(elementId);
    var temp = document.getElementById(elementId).innerHTML;
    var back = document.getElementById('backOfCard');
      if( front.side  == "front") {
    front.innerHTML = back.innerHTML;
    back.innerHTML = temp;
    } else {
      front.innerHTML = back.innerHTML;
      back.innerHTML = temp;
      console.log("Flip");
    }
  };



  var previous = function (displayId) {

    var display = document.getElementById(displayId);
    var backOfCard = document.getElementById('backOfCard');

    var cardIndex = document.getElementById('cardIndex');

    var previousId = Number(cardIndex.innerHTML) - 1;
    cardIndex.innerHTML = previousId
    var previousCardClass = document.getElementsByClassName(Number(previousId))
    display.innerHTML = previousCardClass[0].innerHTML;
    backOfCard.innerHTML = previousCardClass[1].innerHTML;
    console.log("previous!!")

};

  var next = function (displayId) {
    var display = document.getElementById(displayId);
    var backOfCard = document.getElementById('backOfCard');

    var cardIndex = document.getElementById('cardIndex');
    
    var nextId = Number(cardIndex.innerHTML) + 1;
    cardIndex.innerHTML = nextId;
    var nextCardClass = document.getElementsByClassName(Number(nextId));
    display.innerHTML = nextCardClass[0].innerHTML;
    backOfCard.innerHTML = nextCardClass[1].innerHTML;

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






