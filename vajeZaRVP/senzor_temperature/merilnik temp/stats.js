let actual = [];
let target = [];
let cas = [];
let bounds = [20, 40];


let from = "1970-01-01 00:01";
let to = "2570-01-01 00:01";
if(document.getElementById("from").value !== "" && document.getElementById("to").value !== ""){
	from = parseDateTime(document.getElementById("from").value);
	to = parseDateTime(document.getElementById("to").value);
}

fetch("getArchive.php", {
    method: "POST",
	body:JSON.stringify({from:from,to:to})
}).then((data) => data.text())
    .then((data) => {
		console.log(data);
		data = JSON.parse(data);
        console.log(data);
		actual = data.map(e=>e.realna);
		target = data.map(e=>e.zeljena);
		cas = data.map(e=>e.cas)
		makeGraph();
    })

function makeGraph(){
	let chart = new Chart("myChart", {
		type: "line",
		data: {
			labels: cas,
			datasets: [{
				lineTension: 0.2,
				label: "Set",
				data: target,
				borderColor: "rgb(0, 13, 199)",
				fill: false
			}, {
				lineTension: 0.2,
				label: "Actual",
				data: actual,
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
}

function parseDateTime(string){
	return string.substr(0,10)+" "+string.substr(11,2)+":"+string.substr(14,2);
}