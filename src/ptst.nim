import pixie
import json


let canvasConfig = parseJson(readFile("canvas.json"))
let messageBoxConfig = parseJson(readFile("box.json"))

var 
    pfpCFG = parseJson(readFile("pfp.json"))
    fpfp = newImage(128,128)

let image = newImage(canvasConfig["w"].getInt(), canvasConfig["h"].getInt())

image.fill(
    rgba(
        uint8(canvasConfig["r"].getInt()),
        uint8(canvasConfig["g"].getInt()), 
        uint8(canvasConfig["b"].getInt()), 
        uint8(canvasConfig["a"].getInt())
    )
)

let mainCTX = newContext(image)
mainCTX.fillStyle = rgba(255, 0, 0, 255)

let 
    pfpCTX = newContext(fpfp)
    pfpPaint = newPaint(ImagePaint)

pfpPaint.image = readImage("pfp.jpg")
pfpCTX.fillStyle = pfpPaint
pfpCTX.fillCircle(
    circle(
        vec2(
            float32(pfpCFG["px"].getFloat()),
            float32(pfpCFG["px"].getFloat())
        ),
        float32(pfpCFG["r"].getFloat())
    )
)


let
    pos = vec2(float32(messageBoxConfig["px"].getFloat()), float32(messageBoxConfig["py"].getFloat()))
    wh = vec2(float32(messageBoxConfig["w"].getFloat()), float32(messageBoxConfig["h"].getFloat()))
    

mainCTX.fillRoundedRect(rect(pos, wh),22)
mainCTX.drawImage(
    fpfp,
    float32(pfpCFG["dx"].getFloat()), # postion on x axis
    float32(pfpCFG["dy"].getFloat()), # postion on y axis
    float32(pfpCFG["dw"].getFloat()), # width
    float32(pfpCFG["dh"].getFloat())  # height
)
image.writeFile("square.png")