function chooseComputer() {
  const choices = document.querySelectorAll('div[data-player="computer"] > div')
  let index = Math.floor(Math.random() * choices.length);
  return choices[index];
}
const playButton = document.querySelector('button[name="play"]')
// const playerChoices = document.querySelectorAll(".user > div")
const playerChoices = document.querySelectorAll('div[data-player="user"] > div')

let playerChoice = document.querySelector(".selected")
const allChoices = document.querySelectorAll(".choice")

let playerScore = document.querySelector("#player-score")
let computerScore = document.querySelector("#computer-score")

function clearState(){
  allChoices.forEach(item => item.classList.remove("win", "lose", "draw"));
}

function playRound() {
  clearState()
  let computerChoice = chooseComputer()
  const playerKey = playerChoice.dataset.key
  const computerKey = computerChoice.dataset.key

  if (playerKey == computerKey) {
    computerChoice.classList.add("draw")
  } else if ((playerKey + 1) % 3 == computerKey % 3) {
      ++computerScore.innerText
      computerChoice.classList.add("win")
      playerChoice.classList.add("lose")
  } else if ((computerKey + 1) % 3 == playerKey % 3) {
      ++playerScore.innerText
      playerChoice.classList.add("win")
      computerChoice.classList.add("lose")
    }
}

function selectOption(object) {
  clearState()
  playerChoices.forEach(i => i.classList.remove("selected"));
  object.classList.add("selected")
  playerChoice = object
}
playerChoices.forEach(item => item.addEventListener(
  "mousedown", e => selectOption(e.target))
);

allChoices.forEach(item => item.addEventListener("animationend", e =>
    clearState)
);

playButton.addEventListener("mouseup", playRound)
