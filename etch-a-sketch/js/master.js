const container = document.querySelector(".container");
const colors = document.querySelectorAll(".swatch");

let selectedColor = document.querySelector(".selected-color")
const cols = document.querySelector("#num-cols");
const rows = document.querySelector("#num-rows");

function chooseColor() {
  const choices = ["magenta", "cyan", "yellow"]
  let index = Math.floor(Math.random() * choices.length);
  return choices[index];
}

function setColor(object) {
  let color = selectedColor.id == 'multi' ? chooseColor() : selectColor.id
  object.style.backgroundColor = color;
}

const drawGrid = function (){
  container.innerHTML = ""
  container.style.gridTemplateColumns = `repeat(${cols.value}, 1fr)`;
  container.style.gridTemplateRows = `repeat(${rows.value}, 1fr)`;

  for (let i = 0; i < cols.value * rows.value; ++i) {
    let cell = document.createElement("div")
    cell.classList.add("cell")
    cell.addEventListener("mouseover", e => setColor(cell))
    container.appendChild(cell)
  }
};

drawGrid()

function selectColor(object) {
  colors.forEach(i => i.classList.remove("selected-color"));
  object.classList.add("selected-color")
  selectedColor = object
}

colors.forEach(item => item.addEventListener(
  "mousedown", e => selectColor(e.target))
);

document.querySelector("#num-cols").addEventListener(
  "input", e => drawGrid());

document.querySelector("#num-rows").addEventListener(
  "input", e => drawGrid());

document.querySelector("#clear").addEventListener(
  "mouseup", e=> drawGrid()
);
