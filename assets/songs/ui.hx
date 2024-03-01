public var uiText:FunkinText;

function postCreate(){
    uiText = new FunkinText(100, 0, 0, "", 20);
    add(uiText);
    
    uiText.cameras = [camHUD];
    uiText.y = scoreTxt.y;

    uiText.borderSize = 2;

    remove(scoreTxt);
    remove(missesTxt);
    remove(accuracyTxt);
}

function update(elapsed) {
    if(FlxG.keys.justPressed.F6){
        player.cpu = !player.cpu;
    }
}

function postUpdate(elapsed) {
    if (player.cpu){
        uiText.text = "BOTPLAY";
    } else{
        if (accuracy < 0){
            uiText.text = "Score:" + songScore + " | Misses: " + misses+ " | Accuracy:" + "?";
        } else{
            uiText.text = "Score:" + songScore + " | Misses: " + misses +  " | Accuracy:" + FlxMath.roundDecimal(accuracy * 100, 2) + "%";
        }
    }
    uiText.screenCenter(FlxAxes.X);
}   