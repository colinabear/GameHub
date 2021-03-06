
var tasks = document.getElementsByClassName("task");
var c = document.getElementById("myCanvas");
var bg = document.getElementById("background");
var bgCtx = bg.getContext("2d");
var ctx = c.getContext("2d");
ctx.font = "24px Arial";
var canvasWidth = 1100;
var canvasHeight = 600;
var toDoX = 0;
var toDoY = 40;
var inProgX = canvasWidth/3;
var inProgY = 40;
var recentCompletedX = 2*canvasWidth/3;
var recentCompletedY = 40;
var grd = bgCtx.createLinearGradient(0,0,0,300);
var jobArr = [];
var count = 0;
initializeKanban();


function initializeKanban() {
  buildBackGround();
  ctx.rect(0,0,canvasWidth/3,30);
  ctx.fillStyle = "blue";
  ctx.fill();
  ctx.font = "20px Arial";
  ctx.fillStyle = "white";
  ctx.fillText("To Do", 10, 22);
  ctx.beginPath();
  ctx.rect(canvasWidth/3,0,2*canvasWidth/3,30);
  ctx.fillStyle = "salmon";
  ctx.fill();
  ctx.font = "20px Arial";
  ctx.fillStyle = "white";
  ctx.fillText("In Progress", canvasWidth/3+10, 22);
  ctx.beginPath();
  ctx.rect(2*canvasWidth/3,0,3*canvasWidth/3,30);
  ctx.fillStyle = "green";
  ctx.fill();
  ctx.font = "20px Arial";
  ctx.fillStyle = "white";
  ctx.fillText("Completed", 2*canvasWidth/3+10, 22);
  for(var i = 0; i<tasks.length; i++) {
    addSquare("todo");
    count++;
  }
}



function addSquare(choice) {
  //var title = document.getElementById("title").value;
  var title = tasks[count].innerText;
  title = title.substring(0,29);
  var desc = document.getElementById("desc").value;

  if(title=="") {
    alert("Must have title!");
    return;
  }

  if(choice == "todo"){
    checkHeight(toDoY);
    createRect(toDoX,toDoY,"blue", title, desc);
    toDoY+=170;
  }
  else if(choice == "inProg") {
    checkHeight(inProgY);
    createRect(inProgX,inProgY,"salmon", title, desc);
    inProgY+=170;
  }
  else if(choice == "recent") {
    checkHeight(recentCompletedY);
    createRect(recentCompletedX,recentCompletedY,"green", title, desc);
    recentCompletedY+=170;
  }
  document.getElementById("title").value = "";
}


function createRect(x,y,color, title, desc) {
  ctx.beginPath();
  ctx.rect(x+5,y,canvasWidth/3-10,40);
  grd = ctx.createLinearGradient(x,y,x,y+40);
  grd.addColorStop(0,"light"+color);
  grd.addColorStop(1,color);
  ctx.fillStyle = grd;
  ctx.fill();
  ctx.beginPath();
  ctx.rect(x+5,y+40,canvasWidth/3-10,120);
  ctx.fillStyle = "light"+color;
  ctx.fill();
  ctx.font = "24px Arial";
  ctx.fillStyle = "white";
  ctx.fillText(title, x+10, y+30);
  ctx.font = "14px Arial";
  ctx.fillStyle = "black";
  ctx.fillText(desc, x+10, y+60);
}

function checkHeight(current) {
  if(current>=canvasHeight-160){
    var imgData = ctx.getImageData(0, 0, canvasWidth, canvasHeight-10);
    canvasHeight+=170;
    document.getElementById("myCanvas").height = canvasHeight;
    document.getElementById("background").height = canvasHeight;
    buildBackGround();
    ctx.putImageData(imgData, 0, 0);
    ctx.font = "24px Arial";
  }
}

function buildBackGround() {
  bgCtx.beginPath();
  var bgGrd = bgCtx.createLinearGradient(0,0,0,300);
  bgGrd.addColorStop(0,"gray");
  bgGrd.addColorStop(1,"darkgray");
  bgCtx.fillStyle = bgGrd;
  bgCtx.fillRect(0,0,canvasWidth,canvasHeight);
  for(var i = 1; i<=2; i++) {
    bgCtx.beginPath();
    bgCtx.moveTo(i*canvasWidth/3, 0);
    bgCtx.lineTo(i*canvasWidth/3, canvasHeight);
    bgCtx.stroke();
  }
}
