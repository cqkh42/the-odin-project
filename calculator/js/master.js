let value = '0'
let operator = null

function catchNumber(key){
  const screen = document.querySelector('#screen')

  let newValue = value + key
  if (newValue == '00'){
    return
  } else if (newValue.match(/0\d/)) {
    value = key
    screen.innerText = key
  } else if (!isNaN(newValue)){
    value += key
    screen.innerText = newValue
  }
}

function catchOperator(key){
  console.log(key)
  const operators = {''}
  operator = key
}

function catchInput(key){
  console.log(key)
  if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.'].includes(key)) {
    catchNumber(key)
  } else if ['*', '/', '+', '-'].includes(key) {
    catchOperator(key)
  }
}

function keyPress(e) {
  let key = e.key
  if (key == "Shift") {
    return
  } else if (key == "Enter") {
    key = '='
  }
  try {
    document.querySelector(`button[data-key="${key}"]`).focus()
    catchInput(key)
  }
  catch(err) {
    return
  }
}

function buttonPress(e) {
  let key = e.target.dataset.key
  catchInput(key)
}

document.querySelectorAll('button').forEach(
  item => item.addEventListener('mouseup', e=> buttonPress(e))
)

document.addEventListener(
  "keydown", e => keyPress(e)
)

document.addEventListener(
  "keyup", (e) => document.activeElement.blur()
)

document.addEventListener(
  "mouseup", (e) => document.activeElement.blur()
)
// document.addEventListener("keydown", (e) => play(e.which))
