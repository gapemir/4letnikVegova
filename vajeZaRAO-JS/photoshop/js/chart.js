Chart.defaults.global.defaultFontColor = 'white';
let xValues = [];
let yValues = [[], [], []];
let chartConf;
let histogramMode = 1;
let chart = null;

function reloadChart() {
    xValues = [];
    yValues = [[], [], []];
    if (histogramMode == 0) {
        xValues = ["0-50", "51-100", "101-150", "151-200", "201-255"];
        yValues = [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]];
        chartConf = {
            type: "bar",
            data: {
                labels: xValues,
                datasets: [{
                    label: "Rdeča",
                    data: yValues[0],
                    backgroundColor: 'red',
                }, {
                    label: "Zelena",
                    data: yValues[1],
                    backgroundColor: 'green'
                }, {
                    label: "Modra",
                    data: yValues[0],
                    backgroundColor: 'blue'
                }]
            },
            options: {
                title: { display: false },
            }
        }
    } else {
        for (let i = 0; i < 255; i++) {
            xValues.push(i);
            yValues[0].push(0);
            yValues[1].push(0);
            yValues[2].push(0);
        }
        chartConf = {
            type: 'line',
            data: {
                labels: xValues,
                datasets: [{
                    label: "Rdeča",
                    data: yValues[0],
                    borderColor: 'red',
                    backgroundColor: 'transparent'
                }, {
                    label: "Zelena",
                    data: yValues[1],
                    borderColor: 'green',
                    backgroundColor: 'transparent'
                }, {
                    label: "Modra",
                    data: yValues[2],
                    borderColor: 'blue',
                    backgroundColor: 'transparent'
                }]
            },
            options: {}
        }
    };
    if (chart !== null)
        chart.destroy();
    chart = new Chart("myChart", chartConf);
}

function updateHistogram() {
    if (histogramMode == 0) {
        chart.data.datasets[0].data = yValues[0];
        chart.data.datasets[1].data = yValues[1];
        chart.data.datasets[2].data = yValues[2];
        let imgData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        for (let i = 0; i < imgData.data.length; i += 4) {
            for (let j = 0; j < 3; j++)
                insertYColor(j, imgData.data[i + j]);
        }
    } else {

        chart.data.datasets[0].data = yValues[0];
        chart.data.datasets[1].data = yValues[1];
        chart.data.datasets[2].data = yValues[2];
        let imgData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        for (let i = 0; i < imgData.data.length; i += 4) {
            for (let j = 0; j < 3; j++)
                insertYColor(j, imgData.data[i + j]);
        }
    }
    chart.update();
}

function insertYColor(col, val) {
    if (histogramMode == 0)
        chart.data.datasets[col].data[(val >= 0 && val <= 50) ? 0 : (val >= 51 && val <= 100) ? 1 : (val >= 101 && val <= 150) ? 2 : (val >= 151 && val <= 200) ? 3 : 4] += 1;
    else
        chart.data.datasets[col].data[val] += 1;
}

reloadChart();

document.getElementById("graphButton").addEventListener("click", e => {
    histogramMode = !histogramMode;
    reloadChart();
    updateHistogram();
});

