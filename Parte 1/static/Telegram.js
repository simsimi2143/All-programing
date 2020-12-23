var G_1, G_2;
var imagen1 = document.getElementById("exportChart")
var imagen2 = document.getElementById("exportChart2")
var time = new Date;
const nTIME = 1000 * 3
var aData_1 = [
    { x:time, y: 0 },

];
var aData_3 = [
    { x:time, y: 0 },
];
var aData_4 = [
    { x:time, y: 0 }
];

var aData_2 = [
    { x:time, y: 0 },
];
function Put_Data(aD) {
    var timeAc = new Date;
    aData_1.push({
        x: timeAc,
        y: aD[0]
    });
    aData_3.push({
        x: timeAc,
        y: aD[1]
    });
    aData_4.push({
        x: timeAc,
        y: aD[2]
    });
    aData_2.push({
        x: timeAc,
        y: aD[3]
    });
};
function post_img(img){
    $.post("http://127.0.0.1:5000/postimg", img)
}
function Get_Json() {
    $.getJSON("http://127.0.0.1:5000/GetData", function(data) {
        Put_Data(data['k']);
        
    });
};
function Set_Graph() {
    G_1 = new CanvasJS.Chart("G1", {
        title: {
            text: "Material Particulado 1.0 - 2.5 - 10"
        },
        axisX: {
            title: "Mediciones de Estaciones",
        },
        axisY: {
            title: "Material Particulado ",
            suffix: " ug/m3"
        },
        toolTip: {
            shared: true
        },
        data: [{
            type: "spline",
            xValueType: "1.0",
            name: "1.0",
            xValueFormatString: "hh:mm:ss TT",
            color: ['red'],
            dataPoints: aData_1
        },
        {
            type: "spline",
            xValueType: "2.5",
            xValueFormatString: "hh:mm:ss TT",
            name: "2.5",
            color: ['green'],
            dataPoints: aData_3
        },
        {
            type: "spline",
            xValueType: "10",
            name: "10",
            xValueFormatString: "hh:mm:ss TT",
            color: ['blue'],
            dataPoints: aData_4
        }
    ]
    });
    G_1.render();

    G_2 = new CanvasJS.Chart("G2", {
        title: {
            text: "Medicion Ambiental Tempe"
        },
        toolTip: {
            shared: true
        },
        data: [{
            type: "spline",
            xValueFormatString: "hh:mm:ss TT",
            dataPoints: aData_2,
            color: ['blue'],
            name: "Temperatura",
        }],
        axisX: {
            title: "Mediciones de Estaciones"
        },
        axisY: {
            title: "Tempe",
            suffix: " C°"
        }
    });
    G_2.render();
}

function Sample() {
    Get_Json();
    G_1.render();
    G_2.render();
};
Set_Graph();	
setInterval(Sample, nTIME);
imagen1.onclick = function(){
    img1 = G_1.exportChart({toDataURL: true});
    img1 = img1.replace(/^data:image\/(png|jpg);base64,/, "") ;
    post_img(img1)
}
imagen2.onclick = function(){
    img2 = G_2.exportChart({toDataURL: true});
    img2 = img2.replace(/^data:image\/(png|jpg);base64,/, "") ;
    post_img(img2)
}