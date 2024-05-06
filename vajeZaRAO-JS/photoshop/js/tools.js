// Magic Wand
let mwregistered = false;
document.getElementById("magicWand").addEventListener("click", (e) => {
    mwregistered = !mwregistered;
    if (mwregistered) {
        canvas.addEventListener("click", MagicWandFunction);
        e.target.style.backgroundColor = "var(--fourth-color)";
    } else {
        canvas.removeEventListener("click", MagicWandFunction);
        e.target.style.backgroundColor = "var(--first-color)";
    }
});
function MagicWandFunction(e) {
    let imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    let color = document.getElementById('magicWandColor').value;
    let col = [parseInt(color.substring(1, 3), 16), parseInt(color.substring(3, 5), 16), parseInt(color.substring(5, 7), 16)];
    let width = canvas.width;
    let height = canvas.height;

    if (document.getElementById("magicWandTolerance").value <= 0) return;
    let tolerance = document.getElementById("magicWandTolerance").value;

    let mouseX = Math.floor((e.clientX - canvas.getBoundingClientRect().left) / scale);
    let mouseY = Math.floor((e.clientY - canvas.getBoundingClientRect().top) / scale);

    let pixelData = ctx.getImageData(mouseX, mouseY, 1, 1).data;
    let targetColor = { r: pixelData[0], g: pixelData[1], b: pixelData[2] };

    let visited = new Array(width * height).fill(false);

    function colorsSimilar(color1, color2) {
        let deltaR = color1.r - color2.r;
        let deltaG = color1.g - color2.g;
        let deltaB = color1.b - color2.b;
        let distanceSquared = deltaR * deltaR + deltaG * deltaG + deltaB * deltaB;
        return distanceSquared <= tolerance * tolerance;
    }

    function floodFill(x, y) {
        let stack = [];
        stack.push({ x: x, y: y });

        while (stack.length > 0) {
            let point = stack.pop();
            let newX = point.x;
            let newY = point.y;

            if (newX < 0 || newX >= width || newY < 0 || newY >= height || visited[newY * width + newX]) continue;
            visited[newY * width + newX] = true;

            let pixelIndex = (newY * width + newX) * 4;
            let pixelColor = {
                r: imageData.data[pixelIndex],
                g: imageData.data[pixelIndex + 1],
                b: imageData.data[pixelIndex + 2]
            };

            if (!colorsSimilar(pixelColor, targetColor)) continue;

            imageData.data[pixelIndex] = col[0];
            imageData.data[pixelIndex + 1] = col[1];
            imageData.data[pixelIndex + 2] = col[2];

            stack.push({ x: newX + 1, y: newY });
            stack.push({ x: newX - 1, y: newY });
            stack.push({ x: newX, y: newY + 1 });
            stack.push({ x: newX, y: newY - 1 });
        }
    }
    floodFill(mouseX, mouseY);
    ctx.putImageData(imageData, 0, 0);
    saveHistory();
    /*canvas.removeEventListener("click", MagicWandFunction);
    document.getElementById("magicWand").style.backgroundColor = "var(--second-color)";
    mwregistered = true;*/
}

//Pen
let pregistered = false;
let isDrawing = false;
document.getElementById("pen").addEventListener("click", (e) => {
    pregistered = !pregistered;
    if (pregistered) {
        canvas.addEventListener("mousedown", startDrawing);
        canvas.addEventListener("mousemove", draw);
        canvas.addEventListener("mouseup", stopDrawing);
        canvas.addEventListener("mouseleave", stopDrawing);
        canvas.addEventListener("touchstart", startDrawing);
        canvas.addEventListener("touchmove", draw);
        canvas.addEventListener("touchend", stopDrawing);
        canvas.addEventListener("touchcancel", stopDrawing);
        e.target.style.backgroundColor = "var(--fourth-color)";
    } else {
        canvas.removeEventListener("mousedown", startDrawing);
        canvas.removeEventListener("mousemove", draw);
        canvas.removeEventListener("mouseup", stopDrawing);
        canvas.removeEventListener("mouseleave", stopDrawing);
        canvas.removeEventListener("touchstart", startDrawing);
        canvas.removeEventListener("touchmove", draw);
        canvas.removeEventListener("touchend", stopDrawing);
        canvas.removeEventListener("touchcancel", stopDrawing);
        e.target.style.backgroundColor = "var(--first-color)";
    }
});
function startDrawing(e) {
    isDrawing = true;
    ctx.strokeStyle = document.getElementById('penColor').value;
    if (document.getElementById("penThickness").value <= 0) return;
    ctx.lineWidth = document.getElementById("penThickness").value;
    ctx.lineCap = 'round';
    draw(e);
}
function draw(e) {
    if (!isDrawing) return;
    mouseX = Math.floor((e.clientX - canvas.getBoundingClientRect().left) / scale);
    mouseY = Math.floor((e.clientY - canvas.getBoundingClientRect().top) / scale);
    if (e.type.includes("touch")) {
        mouseX = Math.floor((e.touches[0].clientX - canvas.getBoundingClientRect().left) / scale);
        mouseY = Math.floor((e.touches[0].clientY - canvas.getBoundingClientRect().top) / scale);
    }
    if (e.type === 'mousedown' || e.type === 'touchstart') {
        ctx.beginPath();
        ctx.moveTo(mouseX, mouseY);
    } else {
        ctx.lineTo(mouseX, mouseY);
        ctx.stroke();
    }
}

function stopDrawing() {
    if (isDrawing)
        saveHistory();
    isDrawing = false;
}

//partOfImage
let partOfImage = null;
document.getElementById("partOfImageStart").addEventListener("click", e => {
    partOfImage = null;
    hideSelectDiv
    document.getElementById("canvas").addEventListener("click", partOfImageSelection);
    e.target.style.backgroundColor = "var(--fourth-color)";
    showPartOfImageMessage();
})
document.getElementById("partOfImageReset").addEventListener("click", e => {
    document.getElementById("canvas").removeEventListener("click", partOfImageSelection);
    partOfImage = null;
    hideSelectDiv();
    document.getElementById("partOfImageStart").style.backgroundColor = "var(--first-color)";
    showPartOfImageMessage();
})

function partOfImageSelection(e) {
    if (partOfImage == null)
        partOfImage = { x: Math.floor((e.clientX - canvas.getBoundingClientRect().left) / scale), y: Math.floor((e.clientY - canvas.getBoundingClientRect().top) / scale) };
    else {
        partOfImage.w = Math.floor((e.clientX - canvas.getBoundingClientRect().left) / scale) - partOfImage.x;
        partOfImage.h = Math.floor((e.clientY - canvas.getBoundingClientRect().top) / scale) - partOfImage.y;
        document.getElementById("canvas").removeEventListener("click", partOfImageSelection);
        document.getElementById("partOfImageStart").style.backgroundColor = "var(--first-color)";
        showPartOfImageMessage();
        showSelectDiv();
    }
}
function showPartOfImageMessage() {
    if (partOfImage == null)
        document.getElementById("partOfImageMessage").innerText = "";
    else
        document.getElementById("partOfImageMessage").innerText = "selected: " + partOfImage.w + "x" + partOfImage.w;
}

function showSelectDiv() {
    let div = document.getElementById("selectDiv");
    div.style.display = "block";
    div.style.top = (partOfImage.y * scale + canvas.getBoundingClientRect().top) + "px";
    div.style.left = (partOfImage.x * scale + canvas.getBoundingClientRect().left) + "px";
    div.style.width = (partOfImage.w * scale) + "px";
    div.style.height = (partOfImage.h * scale) + "px";
}

function hideSelectDiv() {
    let div = document.getElementById("selectDiv");
    div.style.display = "none";
}

