console.log("main.js-solo game");


//make solo game
let content = document.getElementById("content");
let scoreb_cont = document.createElement("div");
scoreb_cont.id = "scoreboard-container";
let canvas_scoreb = document.createElement("canvas");
canvas_scoreb.id = "scoreboard";
canvas_scoreb.width = "300";
canvas_scoreb.height = "300";
scoreb_cont.appendChild(canvas_scoreb);
content.appendChild(scoreb_cont);
let game_cont = document.createElement("div");
game_cont.className = "game-container";
let canvas_tetris = document.createElement("canvas");
canvas_tetris.id = "tetris";
canvas_tetris.className = "tetris";
canvas_tetris.width = "300";
canvas_tetris.height = "500";
game_cont.appendChild(canvas_tetris);
content.appendChild(game_cont);
let next_cont = document.createElement("div");
next_cont.className = "next-container";
let canvas_next = document.createElement("canvas");
canvas_next.id = "next";
canvas_next.className = "next";
canvas_next.width = "125";
canvas_next.height = "150";
next_cont.appendChild(canvas_next);
content.appendChild(next_cont);

const canvas = document.getElementById('tetris');
const context = canvas.getContext('2d');
context.scale(25, 25);
const Scanvas = document.getElementById('scoreboard');
const Scontext = Scanvas.getContext('2d');
Scontext.scale(25, 25);
const Ncanvas = document.getElementById('next');
const Ncontext = Ncanvas.getContext('2d');
Ncontext.scale(25, 25);


const area1 = makeMatrix(12, 20);
const player1 = {
    pos: {
        x: 0,
        y: 0
    },
    matrix: null,
    score: 0,
    nextMatrix: null
};


document.addEventListener('keydown', function (e) {
    if (e.code === KEYS[8]) {
        if (!conf && !nameIn)
            setPause();
    }
    if (pause) {
        if (conf) {
            if (confSwitc !== null)
                updateControls(e);
            confSwitc = null;
        }
        if (!gameRun)
            setPause();
        return;
    }
    if (e.code === KEYS[0] || e.code === KEYS[4]) {
        playerMove(player1, -move, area1);
    }
    else if (e.code === KEYS[2] || e.code === KEYS[6]) {
        playerMove(player1, +move, area1);
    }
    else if (e.code === KEYS[1] || e.code === KEYS[5]) {
        if (gameRun) {
            playerDrop(player1, area1);
        }
    }
    else if (e.code === KEYS[3] || e.code === KEYS[7]) {
        playerRotate(player1, -move, area1);
        if (!gameRun)
            startGame();
    }
});






startGame(player1, area1, [[context, Ncontext, Scontext]]);


