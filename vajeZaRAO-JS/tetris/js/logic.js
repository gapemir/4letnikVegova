let scriptFile = document.createElement("script");
scriptFile.setAttribute("src", "js/main.js");
let m = false;
if (document.location.search == "?m=1") {
    scriptFile.setAttribute("src", "js/multi.js");
    m = true;
    document.getElementById("butMode").innerHTML = "SOLO MODE";
}
document.body.appendChild(scriptFile);

let KEYS = ["KeyA", "KeyS", "KeyD", "Space", "ArrowLeft", "ArrowDown", "ArrowRight", "ControlRight", "KeyP"];
const colors = [
    null,
    "./media/red.png",
    "./media/light_blue.png",
    "./media/blue.png",
    "./media/orange.png",
    "./media/yellow.png",
    "./media/green.png",
    "./media/purple.png",

];

/*------------------------------functions--------------------------------*/
let setSpeed = function () {
    if (score > 900)
        speed = 1;
    else if (score > 800)
        speed = 2;
    else if (score > 700)
        speed = 3;
    else if (score > 600)
        speed = 4;
    else if (score > 500)
        speed = 5;
    else if (score > 400)
        speed = 6;
    else if (score > 300)
        speed = 7;
    else if (score > 200)
        speed = 8;
    else if (score > 100)
        speed = 9;
    else return 0
    return speed;
}
let makeMatrix = function (w, h) {
    let matrix = [];
    for (i = 0; i < h; i++)
        matrix.push(new Array(w).fill(0));
    return matrix;
};
let makePiece = function (type) {
    if (type === "t") return [[0, 0, 0], [5, 5, 5], [0, 5, 0]];
    else if (type === "o") return [[7, 7], [7, 7]];
    else if (type === "l") return [[0, 4, 0], [0, 4, 0], [0, 4, 4]];
    else if (type === "j") return [[0, 1, 0], [0, 1, 0], [1, 1, 0]];
    else if (type === "i") return [[0, 2, 0, 0], [0, 2, 0, 0], [0, 2, 0, 0], [0, 2, 0, 0]];
    else if (type === "s") return [[0, 3, 3], [3, 3, 0], [0, 0, 0]];
    else if (type === "z") return [[6, 6, 0], [0, 6, 6], [0, 0, 0]];
};
let points = function (player, area) {
    let rowCount = 1;
    outer: for (let y = area.length - 1; y > 0; --y) {
        for (let x = 0; x < area[y].length; ++x) {
            if (area[y][x] === 0) {
                continue outer;
            }
        }
        const row = area.splice(y, 1)[0].fill(0);
        area.unshift(row);
        ++y;
        player.score += rowCount * 100;
        rowCount *= 2;
    }
    score = player.score;
}
let collide = function (area, player) {
    const [m, o] = [player.matrix, player.pos];
    for (let y = 0; y < m.length; ++y) {
        for (let x = 0; x < m[y].length; ++x) {
            if (m[y][x] !== 0 && (area[y + o.y] && area[y + o.y][x + o.x]) !== 0) {
                return true;
            }
        }
    }
    return false;
};
let drawMatrix = function (matrix, offset, next = 0, p = 0) {
    matrix.forEach((row, y) => {
        row.forEach((value, x) => {
            if (value !== 0) {
                let imgTag = document.createElement("IMG");
                imgTag.src = colors[value];
                cont[p][next].drawImage(imgTag, x + offset.x, y + offset.y, 1, 1);
            }
        });
    });
};
let merge = function (area, player) {
    player.matrix.forEach((row, y) => {
        row.forEach((value, x) => {
            if (value !== 0) {
                area[y + player.pos.y][x + player.pos.x] = value;
            }
        });
    });
};


/*function rotateMatrix(matrix) { //dont work yet
    let n = matrix.length;
    console.log(n);
    const transposedMatrix = [];
    for (let i = 0; i < n; i++) {
        transposedMatrix.push([]);
        for (let j = 0; j < n; j++) {
            transposedMatrix[i][j] = matrix[j][i];
        }
    }
    console.log("haaaaaaaaaaa");

    const rotatedMatrix = transposedMatrix.forEach(row => row.reverse());
    return rotatedMatrix;
}*/



let rotate = function (matrix, dir) {
    //matrix = rotateMatrix(matrix);
    for (let y = 0; y < matrix.length; ++y) {
        for (let x = 0; x < y; ++x) {
            [
                matrix[x][y],
                matrix[y][x]
            ] = [
                    matrix[y][x],
                    matrix[x][y],
                ]
        }
    }
    if (dir > 0)
        matrix.forEach(row => row.reverse());
    else
        matrix.reverse();
};
let hardReset = function (p1, ar1, p2, ar2) {
    p1.score = 0;
    ar1.forEach(row => row.fill(0));
    if (p2 != null) {
        p2.score = 0;
        ar2.forEach(row => row.fill(0));
    }
}
let playerReset = function (player, area, p) {
    const pieces = "ijlostz";
    player.matrix = (player.nextMatrix === null ? makePiece(pieces[Math.floor(Math.random() * pieces.length)]) : player.nextMatrix);
    player.nextMatrix = makePiece(pieces[Math.floor(Math.random() * pieces.length)]);
    player.pos.y = 0;
    player.pos.x = (Math.floor(area[0].length / 2)) - (Math.floor(player.matrix[0].length / 2));
    if (collide(area, player)) {
        gameRun = false;
        playerLosing = p;
    }
};
let playerDrop = function (player, area, p = 0) {
    player.pos.y++;
    if (collide(area, player)) {
        player.pos.y--;
        merge(area, player);
        points(player, area);
        playerReset(player, area, p);
        updateScore(player, p);
    }
};
let playerMove = function (player, dir, area) {
    player.pos.x += dir;
    if (collide(area, player)) {
        player.pos.x -= dir;
    }
};
let playerRotate = function (player, dir, area) {
    const pos = player.pos.x;
    let offset = 1;
    rotate(player.matrix, dir);
    while (collide(area, player)) {
        player.pos.x += offset;
        offset = -(offset + (offset > 0 ? 1 : -1));
        if (offset > player.matrix[0].length) {
            rotate(player.matrix, -dir);
            player.pos.x = pos;
            return;
        }
    }
};
let updateScore = function (player, p = 0) {
    cont[p][0].font = "bold 1px Comic Sans MS";
    cont[p][0].fillStyle = "#ffffff";
    cont[p][0].textAlign = "left";
    cont[p][0].textBaseline = "top";
    cont[p][0].fillText("Score:" + player.score, 0.5, 0.5);

};
let draw = function (player, area, p) {

    cont[p][0].clearRect(0, 0, canvas.width, canvas.height);
    cont[p][0].fillStyle = "#000";
    cont[p][0].fillRect(0, 0, canvas.width, canvas.height);

    updateScore(player, p);
    updateNext(p);
    drawMatrix(area, { x: 0, y: 0 }, 0, p);
    drawMatrix(player.matrix, player.pos, 0, p);
    drawMatrix(player.nextMatrix, { x: 1, y: 2 }, 1, p);
};
let updateNext = function (p) {
    cont[p][1].clearRect(0, 0, Ncanvas.width, Ncanvas.height);
    cont[p][1].fillStyle = "#000";
    cont[p][1].fillRect(0, 0, Ncanvas.width, Ncanvas.height);
    cont[p][1].font = "bold 1px Comic Sans MS";
    cont[p][1].fillStyle = "#fff";
    cont[p][1].textAlign = "left";
    cont[p][1].textBaseline = "top";
    cont[p][1].fillText("Next", Ncanvas.width / 100, 0.5);
}
let gameOver = function (pl1, pl2) {
    if (!m) {
        scoreboard.push({ playerName, score });
        sortScoreboard();
        localStorage.setItem("scoreboard", JSON.stringify(scoreboard));
    }
    clearInterval(gameLoop);
    gameRun = false;
    playerName = "";
    if (!m) {
        cont[0][0].font = "2px Comic Sans MS";
        cont[0][0].fillStyle = "#ffffff";
        cont[0][0].textAlign = "center";
        cont[0][0].textBaseline = "middle";
        cont[0][0].fillText("Game Over", (canvas.width / 25) / 2, (canvas.width / 25) / 2);
    }
    else {
        let p = 0;
        if ((pl1.score < pl2.score) || (pl1.score == pl2.score && playerLosing == 0))
            p = 1;
        cont[p][0].font = "2px Comic Sans MS";
        cont[p][0].fillStyle = "#ffffff";
        cont[p][0].textAlign = "center";
        cont[p][0].textBaseline = "middle";
        cont[p][0].fillText("Win", (canvas.width / 25) / 2, (canvas.width / 25) / 2);
        cont[p ? 0 : 1][0].font = "2px Comic Sans MS";
        cont[p ? 0 : 1][0].fillStyle = "#ffffff";
        cont[p ? 0 : 1][0].textAlign = "center";
        cont[p ? 0 : 1][0].textBaseline = "middle";
        cont[p ? 0 : 1][0].fillText("Lost", (canvas.width / 25) / 2, (canvas.width / 25) / 2);
    }
};

let dropInter = 100;
let time = 0;
const move = 1;
let gameLoop;
let gameRun = true;
let playerLosing = 0;
let pause = false;
let scoreboard = [];
let score = 0;
let speed = 10;
let pl1 = null;
let pl2 = null;
let ar1 = null;
let ar2 = null;
let cont = null;//2darray in where contects are written
let playerName = "";

//za config keybindov
let conf = false;
let confSwitc = null;

//za name inout
let nameIn = false;

let update = function (player, area) {
    //setSpeed();
    //resetInterval(player);
    if (pause)
        return;
    time++;
    if (time >= dropInter) {
        playerDrop(player, area, 0);
        time = 0;
    }
    draw(player, area, 0);
};
let update2p = function (player1, area1, player2, area2) {
    if (pause)
        return;
    time++;
    if (time >= dropInter) {
        playerDrop(player1, area1, 0);
        playerDrop(player2, area2, 1);
        time = 0;
    }
    draw(player1, area1, 0);
    draw(player2, area2, 1);
};
let setPause = function () {
    pause = !pause;
    for (let i = 0; i < 2; i++) {
        cont[i][0].font = "2px Comic Sans MS";
        cont[i][0].fillStyle = "#ffffff";
        cont[i][0].textAlign = "center";
        cont[i][0].textBaseline = "middle";
        cont[i][0].fillText("Pause", (canvas.width / 25) / 2, (canvas.width / 25) / 2);
        if (!m)
            break;
    }
}
let startGame = function (player1, area1, con, player2, area2,) {
    getControls();
    makeControls();
    if (player1 != null) {
        pl1 = player1;
        pl2 = player2;
        ar1 = area1;
        ar2 = area2;
        cont = con;
    } else {
        hardReset(pl1, ar1, pl2, ar2);
    }
    playerReset(pl1, ar1, 0);
    if (m) {
        playerReset(pl2, ar2, 1);
        resetInterval();
    }
    gameRun = true;
    pause = false;
    if (!m) {
        if (localStorage.getItem("scoreboard") !== null)
            scoreboard = JSON.parse(localStorage.getItem("scoreboard"));
        activateNameInput();
        makeScoreboard();
        update(pl1, ar1);
    }
}
let resetInterval = function () {
    clearInterval(gameLoop);
    gameLoop = setInterval(function () {
        if (gameRun) {
            if (m)
                update2p(pl1, ar1, pl2, ar2);
            else
                update(pl1, ar1);
        }
        else {
            gameOver(pl1, pl2);
        }
    }, setSpeed());
}
/*------------------------------scoreboard-------------------------------*/
let makeScoreboard = function () {
    Scontext.clearRect(0, 0, Scanvas.width, Scanvas.height);
    Scontext.fillStyle = "#000";
    Scontext.fillRect(0, 0, Scanvas.width, Scanvas.height);
    Scontext.font = "bold 1px Comic Sans MS";
    Scontext.fillStyle = "#fff";
    Scontext.textAlign = "left";
    Scontext.textBaseline = "top";
    Scontext.fillText("Scoreboard", Scanvas.width / 100, 0.5);
    for (i = 0; i < scoreboard.length; i++) {
        Scontext.fillText(scoreboard[i].playerName, Scanvas.width / 210, i + 1);
        Scontext.fillText(scoreboard[i].score, Scanvas.width / 40, i + 1);
    }
}
let sortScoreboard = function () {
    for (let j = 0; j < scoreboard.length - 1; j++)
        for (let i = 0; i < scoreboard.length - 1 - j; i++) {
            if (scoreboard[i].score < scoreboard[i + 1].score) {
                let tmp = scoreboard[i];
                scoreboard[i] = scoreboard[i + 1];
                scoreboard[i + 1] = tmp;
            }
        }
    let sc = [];
    for (let i = 0; i < scoreboard.length; i++) {
        if (sc.includes(scoreboard[i].playerName)) {
            scoreboard.splice([i], 1);
            i--;
        }
        else
            sc.push(scoreboard[i].playerName);
    }
    scoreboard.splice(10);
}
/*----------------------------------name----------------------------------*/
let activateNameInput = function () {
    document.getElementById("nameCont").style.visibility = "initial";
    nameIn = true;
}
/*--------------------------------controls--------------------------------*/
let setControls = function () {
    localStorage.setItem("controls", JSON.stringify(KEYS));
}
let getControls = function () {
    if (localStorage.getItem("controls") !== null)
        KEYS = JSON.parse(localStorage.getItem("controls"));
    else setControls();
}
let updateThisContol = function () {
    confSwitc = this.a;
    document.getElementById("controlError").innerHTML = "Press button you want to bind to this action";
}
let updateControls = function (a) {
    KEYS[confSwitc] = a.code;
    document.getElementById("controlError").innerHTML = "success";
    setControls();
    makeControls();
}
let resetControls = function () {
    KEYS = ["KeyA", "KeyS", "KeyD", "Space", "ArrowLeft", "ArrowDown", "ArrowRight", "ControlRight", "KeyP"];
    setControls();
    deleteControls();
    makeControls();
}
let deleteControls = function () {
    for (let i = -1; i < 2; i++) {
        let cont = document.getElementById("playercont" + (i + 1))
        cont.innerHTML = "";
    }
}
let makeControls = function () {
    let x = ["LEFT", "DOWN", "RIGHT", "ROTATE"];
    for (let i = -1; i < 2; i++) {
        let cont = document.getElementById("playercont" + (i + 1))
        cont.innerHTML = "";
        let p = document.createElement("p");
        if (i >= 0)
            p.innerHTML = "PLAYER".concat(i + 1);
        else {
            p.innerHTML = "‎";
            p.className = "descCtrl";
        }
        cont.appendChild(p);
        for (let j = 0; j < 4; j++) {
            if (i >= 0) {
                let but = document.createElement("button");
                but.onclick = updateThisContol;
                but.a = i * 4 + j;
                if (i == 0)
                    but.innerHTML = KEYS[i * 4 + j];
                else
                    but.innerHTML = KEYS[i * 4 + j];
                cont.appendChild(but);
            }
            else {
                let p = document.createElement("p");
                p.innerHTML = x[j];
                p.className = "text_desc";
                cont.appendChild(p);
            }
        }
    }
}

document.getElementById("clrScore").addEventListener("click", function () {
    localStorage.removeItem("scoreboard");
    scoreboard = [];
    makeScoreboard();
});
/*--------------------------------event listeners--------------------------------*/
document.getElementById("butMode").addEventListener("click", function () {
    if (this.innerHTML == "SOLO MODE") {
        this.innerHTML = "MULTIPLAYER";
        document.location = "./index.html";
    } else {
        document.location = "./index.html?m=1";
        this.innerHTML = "SOLO MODE";
    }
});
document.getElementById("control").addEventListener("click", function () {
    if (!pause)
        setPause();
    conf = !conf;
    let ctrl = document.getElementById("controls");
    if (window.getComputedStyle(ctrl).visibility == "hidden") {
        ctrl.style.visibility = "visible"
    }
    else
        ctrl.style.visibility = "hidden"
    document.getElementById("controlError").innerHTML = "";
});
document.getElementById("resetCtrl").addEventListener("click", resetControls);
document.getElementById("nameEnter").addEventListener("click", function (e) {
    if (e.x) {
        playerName = document.getElementById("nameInsert").value;
        makeScoreboard();
        resetInterval();
        nameIn = false;
        document.getElementById("nameCont").style.visibility = "hidden";
    }
});
