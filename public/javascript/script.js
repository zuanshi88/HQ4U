
    var call = function(elementId){
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
    var back = document.getElementById('back');
      if( front.side  == "front") {
    front.innerHTML = back.innerHTML;
    back.innerHTML = temp;
    } else {
      front.innerHTML = back.innerHTML;
      back.innerHTML = temp;
    }
  };



<style>
  const flashcards = [];

  var loadFlashcards = document.addEventListener("DOMContentLoaded", function() {
    function(){
      var cardbox = document.getElementsByClassName("flashcards")
       for(var i = cardbox.length - 1; i >= 0; i-- ){
    flashcard.push(flashcards[i].innerHTML)
  }

  console.log(flashcards[0])

  return flashcards

   } 

  };
});
  function()
</style>