function postCreate(){
    strumLines.members[0].characters[0].cameras = [camHUD];
    strumLines.members[0].characters[0].x = -500;
    strumLines.members[0].visible = false;
}

function update(elapsed){
    strumLines.members[0].characters[0].y = - Math.abs(Math.sin(Conductor.songPosition / 400) * 20);
}

function beatHit(curBeat){
    switch(curBeat){
        case 224:
            FlxTween.tween(strumLines.members[0].characters[0], {x: FlxG.width},(Conductor.crochet / 1000) * 64);
        case 324:
            camZoomingInterval = 1;
            camZoomingStrength += 0.6;
            insert(members.indexOf(dad)-1,grid);
    }
}