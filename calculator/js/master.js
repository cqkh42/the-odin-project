function operate(num1, func, num2) {
  switch (func) {
    case "+":
      return num1 + num2
      break;
    case "-":
      return num1 - num2
    case "*":
      return num1 * num2
    case "/":
      return num1 / num2
    default:
      return 0
  }
};

const screen = document.querySelector("#screen")
const numbers = document.querySelectorAll('button[type="number"]')
const funcs = document.querySelectorAll('button[type="func"]')
const equals = document.querySelector('button[type="equals"]')
const dot = document.querySelector('button[data-num="."]')
const ac = document.querySelector('button[name="ac"]')

let total = 0;
let operator = "+";
let modifier = 0;

let isFirst = true;
let isNewNumber = true;
let number = 0;
let numberArray = []

function reset() {
  let total = 0;
  let operator = "+";
  let modifier = 0;

  let isFirst = true;
  let isNewNumber = true;
  let number = 0;
  let numberArray = []
  screen.classList.remove("decimal")
  screen.innerText = number.toLocaleString()


}

function numKeyPress(press) {
  if (press == ".") {
    screen.classList.add("decimal")
    dot.disabled = true
  } else {
    screen.classList.remove("decimal")
  }
  if (isNewNumber) {
    numberArray = [0, press]
  } else {
    numberArray.push(press)
  }
  number = Number(numberArray.join(""))
  screen.innerText = number.toLocaleString();
  if (isFirst) {
    total = number
    modifier = 0;
  } else {
    modifier = number
  }
  isNewNumber = false
}

function operatorPress(press) {
  dot.disabled = false
  if (!isFirst) {
    total = operate(total, operator, modifier)
    screen.innerText = total.toLocaleString()
  }
  isFirst = false;
  operator = press
  isNewNumber = true
}

function equalsPress(press) {
  dot.disabled = false
  isFirst = true;
  total = operate(total, operator, modifier)
  isNewNumber = true;
  screen.innerText = total.toLocaleString()
}

document.addEventListener("keyup", event => {
  if (!isNaN(event.key)) {
    numKeyPress(event.key)
  } else if (event.key == ".") {
    numKeyPress(event.key)
  } else if ("+-*/".includes(event.key)) {
    operatorPress(event.key)
  } else if (event.key == "Enter" || event.key == "=") {
    equalsPress(event.key)
  }
})

numbers.forEach(item => {
  item.addEventListener("mouseup", event => numKeyPress(event.target.dataset["num"]))
});
funcs.forEach(item => {
  item.addEventListener("mouseup", event => operatorPress(event.target.dataset["operator"]))
})
equals.addEventListener("mouseup", equalsPress)
ac.addEventListener("mouseup", reset)
