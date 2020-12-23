var grafico_MP, grafo_TEMP;
var MaterialParticulado = document.getElementById("graph_mp").getContext("2d");;
var Temperatura = document.getElementById("graph_temp").getContext("2d");;
const nTime = 1000 * 10; 


var datos_mp1 = {label: "MP 1.0 ug/m3",data: [], borderColor: 'Blue'};
var datos_mp2 = {label: "MP 2.5 ug/m3",data: [], borderColor: 'green'};
var datos_mp3 = {label: "MP 10 ug/m3",data: [], borderColor: 'red'};

var info_MP ={
    labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
    datasets: [datos_mp1,datos_mp2,datos_mp3]
  };

var data_Temp = [
    { label: "Te", data: [] , borderColor: 'red'}
];

var info_TEMP = {
    labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
    datasets: [data_Temp[0]]
};
var chartOptions = {
    legend: {display: true, position: 'top', labels: {boxWidth: 80,fontColor: 'black'}}
};

function Almacena(dData){
    datos_mp1.data = dData[0];
    datos_mp2.data = dData[1];
    datos_mp3.data = dData[2];
    data_Temp[0].data = dData[3];
    info_TEMP.datasets = [data_Temp[0]]; 
    info_MP.datasets = [datos_mp1,datos_mp2,datos_mp3];
    graficar_MP();
    graficar_Temperatura();
};


function GetJson(){
    $.getJSON("http://127.0.0.1:5000/GetData", function(data){
        Almacena(data);
    });
};

function graficar_MP() {
    grafico_MP = new Chart(MaterialParticulado, {
        type: 'line',
        data: info_MP,
        options: chartOptions
    });
    grafico_MP.render();
};

function graficar_Temperatura(){
    grafo_TEMP = new Chart(Temperatura, {
        type: 'line',
        data: info_TEMP,
        options: chartOptions
    });
    grafo_TEMP.render();
};

function Sample() {
    GetJson();
    grafico_MP.render();
    grafo_TEMP.render();
    graficar_MP();
    graficar_Temperatura();
};

graficar_MP();
graficar_Temperatura();
setInterval(Sample, nTime);

