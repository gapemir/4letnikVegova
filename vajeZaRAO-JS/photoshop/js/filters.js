//filters
function grayscale() {
    let imgData = getImageData();
    for (let i = 0; i < imgData.data.length; i += 4) {
        imgData.data[i] = 0.299 * imgData.data[i] + 0.587 * imgData.data[i] + 0.114 * imgData.data[i];
        imgData.data[i + 1] = imgData.data[i];
        imgData.data[i + 2] = imgData.data[i];
    }
    putImageData(imgData);
    saveHistory();
}
function removeC(channel = 0) {
    let imgData = getImageData();
    data = channelHighlightingFilter(imgData.data, channel, 0);
    putImageData(imgData);
    saveHistory();
}
function treshold() {
    let imgData = getImageData();
    let tresh = document.getElementById("tresholdSlider").value;
    for (let i = 0; i < imgData.data.length; i++) {
        imgData.data[i] = imgData.data[i] > tresh ? 255 : 0;
        if (i % 4 == 2)
            i++;
    }
    putImageData(imgData);
    saveHistory();
}
function channelHighlighting(channel = 0) {
    let hig = document.getElementById("sliderChannel" + channel).value;
    let imgData = getImageData();
    channelHighlightingFilter(imgData.data, channel, hig)
    putImageData(imgData);
    saveHistory();
}
function lighting() {
    let lig = document.getElementById("sliderLighting").value;
    let imgData = getImageData();
    lightingFilter(imgData.data, lig);
    putImageData(imgData);
    saveHistory();
}
function box(radius = 1) {
    let imgData = getImageData();
    boxFilter(imgData.data, imgData.width, imgData.height, radius);
    putImageData(imgData);
    saveHistory();
}
function identity() {
    box(0);
}
function gaussian() {
    let imgData = getImageData();
    genericPicMatrix(imgData.data, imgData.width, imgData.height, [[0.0947416, 0.118318, 0.0947416], [0.118318, 0.147761, 0.118318], [0.0947416, 0.118318, 0.0947416]]);
    //genericPicMatrix(imgData.data, imgData.width, imgData.height, [[0.003, 0.013, 0.022, 0.013, 0.003], [0.013, 0.053, 0.097, 0.59, 0.13], [0.022, 0.097, 0.159, 0.097, 0.022], [0.013, 0.059, 0.097, 0.059, 0.013], [0.003, 0.013, 0.022, 0.013, 0.003]])
    putImageData(imgData);
    saveHistory();
}
function median() {
    let imgData = getImageData();
    medianFilter(imgData.data, imgData.width, imgData.height);
    putImageData(imgData);
    saveHistory();
}
function sobel(mode = "v") {//todo ne dela
    let imgData = getImageData();
    if (mode == "vh") {
        let copy = [...imgData.data];
        genericPicMatrix(copy, imgData.width, imgData.height, [[1, 2, 1], [0, 0, 0], [-1, -2, -1]]);
        genericPicMatrix(imgData.data, imgData.width, imgData.height, [[1, 0, -1], [2, 0, -2], [1, 0, -1]]);
        sobelAdd(imgData.data, copy);
    }
    if (mode == "h")
        genericPicMatrix(imgData.data, imgData.width, imgData.height, [[1, 2, 1], [0, 0, 0], [-1, -2, -1]]);
    if (mode == "v")
        genericPicMatrix(imgData.data, imgData.width, imgData.height, [[1, 0, -1], [2, 0, -2], [1, 0, -1]]);
    putImageData(imgData);
    saveHistory();
}
function laplace() {
    let imgData = getImageData();
    genericPicMatrix(imgData.data, imgData.width, imgData.height, [[1, 1, 1], [1, -8, 1], [1, 1, 1]]);
    putImageData(imgData);
    saveHistory();
}
function sharpening() {
    let imgData = getImageData();
    let copy = [...imgData.data];
    genericPicMatrix(copy, imgData.width, imgData.height, [[1, 1, 1], [1, -8, 1], [1, 1, 1]]);
    for (i = 0; i < imgData.data.length; i += 4) {
        imgData.data[i] -= copy[i];
        imgData.data[i + 1] -= copy[i + 1];
        imgData.data[i + 2] -= copy[i + 2];
    }
    putImageData(imgData);
    saveHistory();
}
function unsharpening() {
    let imgData = getImageData();
    let copy = [...imgData.data];
    genericPicMatrix(copy, imgData.width, imgData.height, [[0.0947416, 0.118318, 0.0947416], [0.118318, 0.147761, 0.118318], [0.0947416, 0.118318, 0.0947416]]);
    for (let i = 0; i < imgData.data.length; i += 4) {
        imgData.data[i] += imgData.data[i] - copy[i];
        imgData.data[i + 1] += imgData.data[i + 1] - copy[i + 1];
        imgData.data[i + 2] += imgData.data[i + 2] - copy[i + 2];
    }
    putImageData(imgData);
    saveHistory();
}

//support functions
function getPixel(data, w, x, y) {
    let pixel = [data[y * w * 4 + x * 4], data[y * w * 4 + x * 4 + 1], data[y * w * 4 + x * 4 + 2], data[y * w * 4 + x * 4 + 3]];
    return pixel[0] === undefined ? null : pixel;
}
function sobelAdd(h, v) {
    for (i = 0; i < h.length; i++)
        h[i] = h[i] + v[i];
    return h;
}


//functions
function channelHighlightingFilter(data, channel, value) {
    for (let i = channel; i < data.length; i += 4) {
        data[i] = Math.floor(data[i] * value);
        data[i] > 255 ? data[i] = 255 : data[i];
    }
}
function lightingFilter(data, light) {
    for (let i = 0; i < data.length; i++) {
        data[i] = Math.floor(Math.pow(data[i], light));
        data[i] > 255 ? data[i] = 255 : data[i];
        if (i % 4 == 2)
            i++;
    }
}
function boxFilter(data, w, h, rad) {
    copy = [...data];
    for (y = 0; y < h; y++) {
        for (x = 0; x < w; x++) {
            let r = 0, g = 0, b = 0, count = 0;
            for (let dy = -rad; dy <= rad; dy++) {
                for (let dx = -rad; dx <= rad; dx++) {
                    if (pixel = getPixel(copy, w, x + dx, y + dy)) {
                        r += pixel[0];
                        g += pixel[1];
                        b += pixel[2];
                        count++;
                    }
                }
            }
            let thisPixel = (y * w + x) * 4;
            data[thisPixel] = Math.round(r / count);
            data[thisPixel + 1] = Math.round(g / count);
            data[thisPixel + 2] = Math.round(b / count);
            data[thisPixel + 3] = 255; // Alpha value
        }
    }
}
function medianFilter(data, width, height) {
    console.log("in median filter");
    let copy = [...data]
    function medianIntFunc(arr) {
        let sorted = arr.slice().sort((a, b) => a - b);
        let mid = Math.floor(sorted.length / 2);
        return sorted.length % 2 !== 0 ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2;
    }
    for (let y = 0; y < height; y++) {
        for (let x = 0; x < width; x++) {
            let tempArray = [];
            for (let dy = -1; dy <= 1; dy++) {
                for (let dx = -1; dx <= 1; dx++) {
                    if (pixel = getPixel(copy, width, x + dx, y + dy))
                        tempArray.push(pixel[0], pixel[1], pixel[2], pixel[3]);
                }
            }
            let offset = (y * width + x) * 4;
            data[offset] = medianIntFunc(tempArray.filter((_, i) => i % 4 === 0));
            data[offset + 1] = medianIntFunc(tempArray.filter((_, i) => i % 4 === 1));
            data[offset + 2] = medianIntFunc(tempArray.filter((_, i) => i % 4 === 2));
            data[offset + 3] = medianIntFunc(tempArray.filter((_, i) => i % 4 === 3));
        }
    }
}
function genericPicMatrix(data, w, h, matrix, alpha = false) {
    let r = (matrix.length - 1) / 2;
    let copy = [...data];
    for (y = 1; y < h - 1; y++) {
        for (x = 1; x < w - 1; x++) {
            pxl = [0, 0, 0, 0];
            for (dy = -r; dy <= r; dy++) {
                for (dx = -r; dx <= r; dx++) {
                    let weight = matrix[dy + 1][dx + 1];
                    if (pixel = getPixel(copy, w, x + dx, y + dy)) {
                        pxl[0] += pixel[0] * weight;
                        pxl[1] += pixel[1] * weight;
                        pxl[2] += pixel[2] * weight;
                        if (alpha)
                            pxl[3] += pixel[3] * weight;
                    }
                }
            }
            for (i = 0; i < 4; i++) {
                if (pxl[i] < 0) pxl[i] = 0;
                else if (pxl[i] > 255) pxl[i] = 255;
            }
            let thisPixel = (y * w + x) * 4;
            data[thisPixel] = Math.round(pxl[0]);
            data[thisPixel + 1] = Math.round(pxl[1]);
            data[thisPixel + 2] = Math.round(pxl[2]);
            if (alpha)
                data[thisPixel + 3] = Math.round(pxl[3]);
        }
    }
}