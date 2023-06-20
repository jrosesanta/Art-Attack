//Create a canvas
var canvas = document.createElement("canvas");
canvas.width = 600;
canvas.height = 400;
canvas.style.border = "3px solid black";
document.body.appendChild(canvas);

//Get canvas context
var ctx = canvas.getContext("2d");

//Create the background
ctx.fillStyle = "#000000";
ctx.fillRect(0, 0, canvas.width, canvas.height);

//Draw the chessboard
for (var x = 0; x < 8; x++) {
    for (var y = 0; y < 8; y++) {
        //Change color for each square
        if (x % 2 == 0) {
            ctx.fillStyle = (y % 2 == 0 ? "#FFFFFF" : "#BBBBBB");
            ctx.fillRect(x * 50, y * 50, 50, 50);
        } else {
            ctx.fillStyle = (y % 2 == 0 ? "#BBBBBB" : "#FFFFFF");
            ctx.fillRect(x * 50, y * 50, 50, 50);
        }
    }
}

//Creating the Paintbrush
var size = 15;
ctx.fillStyle = "#FFFFFF";
ctx.fillRect(((canvas.width - size) / 2), ((canvas.height - size) / 2), size, size);

//Capture mouse move
document.addEventListener("mousemove", function (e) {
    ctx.fillStyle = "#000000";
    ctx.fillRect(((canvas.width - size) / 2), ((canvas.height - size) / 2), size, size);
});

//Capture mouse click
document.addEventListener("mousedown", function (e) {
    ctx.fillStyle = "#FF0000";
    ctx.fillRect(((canvas.width - size) / 2), ((canvas.height - size) / 2), size, size);
});

//Capture mouse up
document.addEventListener("mouseup", function (e) {
    ctx.fillStyle = "#FFFFFF";
    ctx.fillRect(((canvas.width - size) / 2), ((canvas.height - size) / 2), size, size);
});

//Capture mouse out
document.addEventListener("mouseout", function (e) {
    ctx.fillStyle = "#FFFFFF";
    ctx.fillRect(((canvas.width - size) / 2), ((canvas.height - size) / 2), size, size);
});

//Create the save button
var saveButton = document.createElement("button");
saveButton.textContent = "Save";
document.body.appendChild(saveButton);

//Capture save click
saveButton.addEventListener("click", function (e) {
    //Create a new canvas to clone the image
    var newCanvas = document.createElement("canvas");
    var newCtx = newCanvas.getContext("2d");
    newCanvas.width = canvas.width;
    newCanvas.height = canvas.height;
    newCtx.drawImage(canvas, 0, 0);

    //Generate the image data
    var link = document.createElement("a");
    link.download = "Art_Attack_Image.png";
    link.href = newCanvas.toDataURL();
    link.click();
});