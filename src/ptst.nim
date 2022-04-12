import pixie
import json

const 
    PFP_DEMENSION = 64
    IMAGE_MAT_SCALE = 0.1


let
    messageBoxColor = rgba(19, 15, 28, 255)

let 
    canvasConfig = parseJson(readFile("canvas.json"))
    messageBoxConfig = parseJson(readFile("box.json"))

var 
    pfpCFG = parseJson(readFile("pfp.json"))
    fpfp = newImage(PFP_DEMENSION, PFP_DEMENSION)

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
pfpPaint.imageMat = scale(vec2(IMAGE_MAT_SCALE, IMAGE_MAT_SCALE))
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
    
mainCTX.fillStyle = messageBoxColor
mainCTX.fillRoundedRect(rect(pos, wh),22)

mainCTX.drawImage(
    fpfp,
    float32(pfpCFG["dx"].getFloat()), # postion on x axis
    float32(pfpCFG["dy"].getFloat()), # postion on y axis
    float32(PFP_DEMENSION),           # width
    float32(PFP_DEMENSION)            # height
)
image.writeFile("square.png")