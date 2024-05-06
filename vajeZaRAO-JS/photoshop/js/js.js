let canvas = document.getElementById("canvas");
let ctx = canvas.getContext('2d');
let orig = null;
let nameOfFile = "";

//uploading
document.getElementById("imageUpload").addEventListener("change", uploadFile);
document.querySelector(".drag-area").addEventListener("drop", uploadFile);
function uploadFile(e) {
    e.preventDefault();
    let file = new FileReader();
    file.onload = (event) => {
        let img = new Image();
        img.onload = () => {
            canvas.width = img.width;
            canvas.height = img.height;
            canvas.style.width = "";
            ctx.drawImage(img, 0, 0);
            orig = [...getImageData().data];
            updateHistogram();
            if (getOptimalScale() < 1) {
                setScale(getOptimalScale());
                document.getElementById("scaleMessage").innerText = "scale was changed to " + scale;
                document.getElementById("scaleInput").value = scale;
            }
            document.getElementsByClassName("drag-area")[0].style.display = "none";
            canvas.style.border = "1px solid black";
        }
        img.src = event.target.result;
    }
    if (e.type == "change") fileData = e.target.files[0];
    else fileData = e.dataTransfer.files[0];
    try {
        file.readAsDataURL(fileData);
        nameOfFile = fileData.name;
        deleteHistory();
        partOfImage = null;
        hideSelectDiv();
    } catch (e) {
        console.log(e);
    }
}

//drag and drop
const dropArea = document.querySelector(".drag-area");
dropArea.addEventListener("click", e => document.getElementById("imageUpload").click())
dropArea.ondragover = (event) => {
    event.preventDefault();
    dropArea.classList.add("active");
};
dropArea.ondragleave = () => { dropArea.classList.remove("active"); };

//downloading
document.getElementById("imageDownload").addEventListener("click", (e) => {
    let canvasUrl = canvas.toDataURL();
    let oldCanvas = { w: canvas.width, h: canvas.height }
    if (partOfImage != null) {
        let fullData = getImageData(true);
        let data = getImageData();
        canvas.style.width = null;
        canvas.width = partOfImage.w;
        canvas.height = partOfImage.h;
        putImageData(data, true);
        canvasUrl = canvas.toDataURL();
        canvas.width = oldCanvas.w;
        canvas.height = oldCanvas.h;
        putImageData(fullData, true);
    }
    const createEl = document.createElement('a');
    createEl.href = canvasUrl;
    createEl.download = nameOfFile;
    createEl.click();
    createEl.remove();
});


//history 
let history = [];
let undoHistory = [];
let selectionHistory = [];
let undoselectionHistory = [];
function saveHistory() {
    let imgData = getImageData();
    if (partOfImage != null && partOfImage.hasOwnProperty("w"))
        imgData = getImageData(true);
    history.push(imgData.data);
    undoHistory = [];
    selectionHistory.push(partOfImage);
}
document.getElementById("undoButton").addEventListener("click", () => {
    if (history.length != 0) {
        let imgData = getImageData(true);

        undoHistory.push(history.pop());
        undoselectionHistory.push(selectionHistory.pop());

        partOfImage = selectionHistory.length == 0 ? null : selectionHistory[selectionHistory.length - 1];
        imgData.data.set(history.length == 0 ? orig : history[history.length - 1]);
        putImageData(imgData, true);
        showPartOfImageMessage();
    }
});
document.getElementById("redoButton").addEventListener("click", () => {
    if (undoHistory.length != 0) {
        let imgData = getImageData(true);

        imgData.data.set(undoHistory[undoHistory.length - 1]);
        partOfImage = undoselectionHistory[undoselectionHistory.length - 1]

        history.push(undoHistory.pop());
        selectionHistory.push(undoselectionHistory.pop());

        putImageData(imgData, true);
        showPartOfImageMessage();
    }
});
function deleteHistory() {
    history = [];
    undoHistory = [];
    selectionHistory = [];
    undoselectionHistory = [];
}


//scale
let scale = 1;
function getOptimalScale() {
    if ((ws = (window.innerWidth - 625) / canvas.width) > (hs = (window.innerHeight - 50) / canvas.height))
        return hs;
    return ws;
}
function setScale(scaleTo = 1) {
    scale = scaleTo;
    canvas.style.width = canvas.width * scale + "px";
    document.body.style.height = "";
    let height = Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);
    if (Number(window.getComputedStyle(document.body).height.slice(0, -2)) < height)
        document.body.style.height = height + "px";

}
document.getElementById("scale").addEventListener("click", e => {
    if (document.getElementById("scaleInput").value <= 0) return;
    setScale(document.getElementById("scaleInput").value);
    document.getElementById("scaleMessage").innerText = "";
});
document.getElementById("scaleOptimal").addEventListener("click", e => {
    setScale(getOptimalScale());
    document.getElementById("scaleMessage").innerText = "scale was changed to " + scale;
    document.getElementById("scaleInput").value = scale;
});

//general functions 
function getImageData(wholeImage = false) {
    if (wholeImage == true || partOfImage == null || !partOfImage.hasOwnProperty("w"))
        return ctx.getImageData(0, 0, canvas.width, canvas.height);
    return ctx.getImageData(partOfImage.x, partOfImage.y, partOfImage.w, partOfImage.h);
}
function putImageData(imgData, wholeImage = false) {
    if (wholeImage == true || partOfImage == null || !partOfImage.hasOwnProperty("w"))
        ctx.putImageData(imgData, 0, 0);
    else
        ctx.putImageData(imgData, partOfImage.x, partOfImage.y);
}

//event listers for image procesing
document.getElementById("grayscaleButton").addEventListener("click", grayscale);
document.getElementById("tresholdButton").addEventListener("click", treshold);
document.getElementById("rmC0").addEventListener("click", removeC.bind(null, 0));
document.getElementById("rmC1").addEventListener("click", removeC.bind(null, 1));
document.getElementById("rmC2").addEventListener("click", removeC.bind(null, 2));
document.getElementById("buttonChanel0").addEventListener("click", channelHighlighting.bind(null, 0));
document.getElementById("buttonChanel1").addEventListener("click", channelHighlighting.bind(null, 1));
document.getElementById("buttonChanel2").addEventListener("click", channelHighlighting.bind(null, 2));
document.getElementById("buttonLighting").addEventListener("click", lighting);