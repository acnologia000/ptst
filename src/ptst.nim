import pixie
import json


let canvasConfig = parseJson(readFile("canvas.json"))
#[
    r = red
    g = green
    b = blue 
    a = alpha
    h = height
    w = width
]#

let boxData = parseJson(readFile("box.json"))
#[
    r = red
    g = green
    b = blue 
    a = alpha
    h = height
    w = width
]#

var 
    pfpCFG = parseJson(readFile("pfp.json"))
    fpfp = newImage(32,32)
    pfpMask = newMask(pfpCFG["px"].getInt(),pfpCFG["px"].getInt()) 

let image = newImage(
    canvasConfig["w"].getInt(),
    canvasConfig["h"].getInt()
)

image.fill(
    rgba(
        uint8(canvasConfig["r"].getInt()),
        uint8(canvasConfig["g"].getInt()), 
        uint8(canvasConfig["b"].getInt()), 
        uint8(canvasConfig["a"].getInt())
    )
)

let ctx = newContext(image)
ctx.fillStyle = rgba(255, 0, 0, 255)

let
    imageMatScale = float32(pfpCFG["scale"].getFloat())
    pos = vec2(float32(boxData["px"].getFloat()), float32(boxData["py"].getFloat()))
    wh = vec2(float32(boxData["w"].getFloat()), float32(boxData["h"].getFloat()))
    

ctx.fillRoundedRect(rect(pos, wh),22)

#

image.draw(fpfp)
image.writeFile("square.png")