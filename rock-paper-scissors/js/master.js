const playButton = document.querySelector('button[name="play"]')
const playerChoices = document.querySelectorAll('.clickable')

let playerKey = 0

function playerWins(playerKey, computerKey) {
  return (computerKey - playerKey) % 3 == 2
}

function setWinLose(player, computer){
  let [win, lose] = playerWins(player, computer) ? [player, computer] : [computer, player]
  document.querySelector(`div[data-key="${win}"]`).classList.add('win')
  document.querySelector(`div[data-key="${lose}"]`).classList.add('lose')
}

function playRound() {
  playButton.disabled = true
  playerChoices.forEach(item => item.classList.remove('clickable'))
  let computerKey = Math.floor(Math.random() * 3) + 3

  document.querySelector(`div[data-key="${computerKey}"]`).classList.add("draw")
  if (playerKey != computerKey - 3) {
    let winnerName = playerWins(playerKey, computerKey) ? 'player' : 'computer'
    ++document.querySelector(`#${winnerName}-score`).innerText
    setWinLose(playerKey, computerKey)
  }
}

function selectOption(object) {
  playerChoices.forEach(i => i.classList.remove("selected"));
  object.classList.add("selected")
  playerKey = object.dataset.key
}

playerChoices.forEach(item => item.addEventListener(
  "mousedown", e => selectOption(e.target))
);

function clearState(e){
  e.target.classList.remove('win', 'draw', 'lose')
  playerChoices.forEach(item => item.classList.add('clickable'))
  playButton.disabled = false
}

document.querySelectorAll(".choice").forEach(
  item => item.addEventListener(
    "animationend", e => clearState(e))
)

playButton.addEventListener("mouseup", playRound)
