let target = 50;
let value = 0;
let raw = 0;
let volts = 0;
let bounds = [20, 40];

let id = 1;
let STEVILO_ZAPISOV_V_SQL_TABELI = 5;
if(parseInt(document.getElementById("inputStRecordsInArchive").value))
	STEVILO_ZAPISOV_V_SQL_TABELI = parseInt(document.getElementById("inputStRecordsInArchive").value)

let sendDB = setInterval(sendToDB, 1000);

function map(x, in_min, in_max, out_min, out_max) {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}


function update() {
    let slider = document.getElementsByClassName("slider")[0];
    target = slider.value;
    let k1 = document.getElementById("target_kaz");
    let k2 = document.getElementById("current_kaz");
    let deg1 = map(value, bounds[0], bounds[1], 0, 180);
    let deg2 = map(target, bounds[0], bounds[1], 0, 180);

    k2.style.transform = "rotate(" + deg1 + "deg)";
    k1.style.transform = "rotate(" + deg2 + "deg)";

    document.getElementById("raw").innerText = raw;
    document.getElementById("volt").innerText = volts.toFixed(3);
    document.getElementById("val").innerText = value.toFixed(1);
    document.getElementById("tar").innerText = target;

    requestAnimationFrame(update);
}

update();





// GRAF
const start = Date.now();
const maxLen = 100;
let dfArr = [];
for (let i = 0; i < maxLen; i++) {
    dfArr.push(0);
}



let chart = new Chart("myChart", {
    type: "line",
    data: {
        labels: dfArr,

        datasets: [{
            lineTension: 0.2,
            label: "Set",
            data: dfArr,
            borderColor: "rgb(0, 13, 199)",
            fill: false
        }, {
            lineTension: 0.2,
            label: "Actual",
            data: dfArr,
            borderColor: "black",
            fill: false
        }]
    },
    options: {
        legend: { display: true },
        scales: {
            y: {
                min: bounds[0],
                max: bounds[1],
                ticks: {
                    stepSize: 1
                }
            }
        },
    },

});


function updateGraph() {
    const millis = Date.now() - start;

    for (let i = 9; i > 0; i--) {
        for (let j = 0; j < 3; j++) {
            document.getElementById(i + "" + j).innerText = document.getElementById((i - 1) + "" + j).innerText;
        }
    }

    document.getElementById("00").innerText = Math.round(value, -2);
    document.getElementById("01").innerText = target;
    document.getElementById("02").innerText = Math.floor(millis / 1000);

    if (chart.data.labels.length >= maxLen) {
        chart.data.labels = chart.data.labels.slice(1);
    }
    chart.data.labels.push(Math.floor(millis / 1000))

    if (chart.data.datasets[0].data.length > maxLen) {
        chart.data.datasets[0].data = chart.data.datasets[0].data.slice(1);
    }
    chart.data.datasets[0].data.push(target);

    if (chart.data.datasets[1].data.length > maxLen) {
        chart.data.datasets[1].data = chart.data.datasets[1].data.slice(1);
    }
    chart.data.datasets[1].data.push(value);

    chart.update();

    setTimeout(updateGraph, 250);
}
updateGraph();


// POVEZAVA

var ws = new WebSocket('ws://localhost:8080');

// dogodek, ki se sproži samo ob prvem odprtju povezave
ws.onopen = function () {
    console.log('websocket is connected ...')
    // sending a send event to websocket server
    ws.send('connected')
    //var stevec=0;
    //setInterval(function(){
    //  stevec++; 
    //  ws.send(stevec)},20);		  
}

// dogodek, ki se sproži ob sprejemu sporočila 

/*

var DB1_0_int_digital_in=0;  // digital IN
var DB1_2_int_analog_in=0;   // analog IN
var DB1_4_int_digital_out=0; // digital OUT
var DB1_6_int_stevec=0;      // stevec
var DB1_8_int_analog_out=0;  // analog OUT

*/
ws.onmessage = function (ev) {
    // console.log(ev);
    //Pošlje naprej v nadzorno okno
    // window.parent.postMessage(ev.data, '*');

    // let sendBack = "0#65535";
    // ws.send(sendBack);

    console.log(ev.data);
    raw = (JSON.parse(ev.data).data[2] * 256) + JSON.parse(ev.data).data[3];
    volts = (raw * 10) / 27648;
    value = volts * 10;
    // console.log(raw);
    // document.getElementById("nizPodatkov").innerHTML=ev.data;
}
/**
 * @param  url url to send to default = "./insert.php"
*/
function sendToDB(url = "./insert.php") {
    let data = {
        zel: target,
        real: value,
        id: id
    };
    fetch(url, {
        method: "POST",
        body: JSON.stringify(data)
    }).then((data) => data.text())
        .then((data) => console.log(data))
    id > STEVILO_ZAPISOV_V_SQL_TABELI ? id = 1 : id++;
}

document.getElementById("buttonResetArchive").addEventListener("click", () => {
    console.log("TABLE RESET");
    STEVILO_ZAPISOV_V_SQL_TABELI = parseInt(document.getElementById("inputStRecordsInArchive").value);
    let data = {
        st: document.getElementById("inputStRecordsInArchive").value
    };
    fetch("./start.php", {
        method: "POST",
        body: JSON.stringify(data)
    }).then((data) => data.text())
        .then((data) => console.log(data))
});



// Pošlje sporočilo na klik       //document.getElementById('message_button').addEventListener('click', function (e) {
//   var random = Math.random();
//    window.parent.postMessage('Iz iframea pozdrav' + random, '*');
//});
document.getElementById("slider").addEventListener('change', function (e) {

    let mapV = Math.round((document.getElementById("slider").value / 100) * 27648);
    let sendback = mapV + "#" + mapV;
    console.log(sendback);
    ws.send(sendback);
});


