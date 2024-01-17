console.log("multi.js-multi game");


//make multi game
let content = document.getElementById("content");
let next_cont = document.createElement("div");
next_cont.className = "next-container";
let canvas_next = document.createElement("canvas");
canvas_next.id = "next1";
canvas_next.className = "next";
canvas_next.width = "125";
canvas_next.height = "150";
next_cont.appendChild(canvas_next);
content.appendChild(next_cont);
let game_cont = document.createElement("div");
game_cont.className = "game-container";
let canvas_tetris = document.createElement("canvas");
canvas_tetris.id = "tetris1";
canvas_tetris.className = "tetris";
canvas_tetris.width = "300";
canvas_tetris.height = "500";
game_cont.appendChild(canvas_tetris);
content.appendChild(game_cont);
let game_cont2 = document.createElement("div");
game_cont2.className = "game-container";
let canvas_tetris2 = document.createElement("canvas");
canvas_tetris2.id = "tetris2";
canvas_tetris2.className = "tetris";
canvas_tetris2.width = "300";
canvas_tetris2.height = "500";
game_cont2.appendChild(canvas_tetris2);
content.appendChild(game_cont2);
let next_cont2 = document.createElement("div");
next_cont2.className = "next-container";
let canvas_next2 = document.createElement("canvas");
canvas_next2.id = "next2";
canvas_next2.className = "next";
canvas_next2.width = "125";
canvas_next2.height = "150";
next_cont2.appendChild(canvas_next2);
content.appendChild(next_cont2);


const canvas = document.getElementById('tetris1');
const context = canvas.getContext('2d');
context.scale(25, 25);
const Ncanvas = document.getElementById('next1');
const Ncontext = Ncanvas.getContext('2d');
Ncontext.scale(25, 25);
const canvas2 = document.getElementById('tetris2');
const context2 = canvas2.getContext('2d');
context2.scale(25, 25);
const Ncanvas2 = document.getElementById('next2');
const Ncontext2 = Ncanvas2.getContext('2d');
Ncontext2.scale(25, 25);

let area1 = makeMatrix(12, 20);
let area2 = makeMatrix(12, 20);
let player1 = {
    pos: {
        x: 0,
        y: 0
    },
    matrix: null,
    score: 0,
    nextMatrix: null
};
let player2 = {
    pos: {
        x: 0,
        y: 0
    },
    matrix: null,
    score: 0,
    nextMatrix: null
};

//let KEYS = ["KeyA", "KeyS", "KeyD", "Space", "ArrowLeft", "ArrowDown", "ArrowRight", "ControlRight", "KeyP"];
document.addEventListener('keydown', function (e) {
    if (e.code === KEYS[8]) {
        if (!conf)
            setPause();
    }
    if (pause) {
        if (conf) {
            if (confSwitc !== null)
                updateControls(e);
            confSwitc = null;
        }
        return;
    }
    if (e.code === KEYS[0]) {
        playerMove(player1, -move, area1);
    }
    else if (e.code === KEYS[4]) {
        playerMove(player2, -move, area2);
    }
    else if (e.code === KEYS[2]) {
        playerMove(player1, +move, area1);
    }
    else if (e.code === KEYS[6]) {
        playerMove(player2, +move, area2);
    }
    else if (e.code === KEYS[1]) {
        if (gameRun) {
            playerDrop(player1, area1);
        }
    }
    else if (e.code === KEYS[5]) {
        if (gameRun) {
            playerDrop(player2, area2, 1);
        }
    }
    else if (e.code === KEYS[3]) {
        playerRotate(player1, -move, area1);
        if (!gameRun)
            startGame();
    }
    else if (e.code === KEYS[7]) {
        playerRotate(player2, -move, area2);
        if (!gameRun)
            startGame();
    }
});

startGame(player1, area1, [[context, Ncontext], [context2, Ncontext2]], player2, area2);