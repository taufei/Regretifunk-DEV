var sign:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/credits/Sign'));
var realbg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/credits/creditbgthingy'));
var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/credits/Credits1'));
var obj:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/credits/midbgobjects'));

var input:Bool = true;

var guys:FlxTypedGroup<FlxSprite>;

var curSelected:Int = 0;

var dumb:Array<Array<String>> = [
    ['Taufei', '', '', "https://www.youtube.com/channel/UCxHjDEbm-RWWr_PSodXAZbg"],
    ['Goobier', '', '', "https://www.youtube.com/channel/UCxHjDEbm-RWWr_PSodXAZbg"],
]; // there is probably definetely a better way to do this but ummm idk im nbto a good coder...... -taufei

var titleTxt:FunkinText;

function create(){
    guys = new FlxTypedGroup();

    add(realbg);
    add(obj);
    obj.scale.set(0.9, 0.9);
    obj.y += 50;
    add(bg);

    var blackBar1:FlxSprite = new FlxSprite(0, -50).makeSolid(FlxG.width, 50, FlxColor.BLACK);
    add(blackBar1);
    var blackBar2:FlxSprite = new FlxSprite(0, FlxG.height).makeSolid(FlxG.width, 50, FlxColor.BLACK);
    add(blackBar2);

    FlxTween.tween(blackBar1, {y: 0}, 1, {ease:FlxEase.circOut});
    FlxTween.tween(blackBar2, {y: FlxG.height - 50}, 1, {ease:FlxEase.circOut});

    blackBar1.alpha = blackBar2.alpha = 0.6;
    sign.origin.set(sign.width / 2, 0);

    for (i in 0...dumb.length){
        var stupid:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/credits/characters/' + dumb[i][0]));
        guys.add(stupid);
        stupid.screenCenter();
        stupid.scale.set(0.9, 0.9);
        stupid.origin.set(stupid.width / 2, (stupid.height / 2) + 100);
    }
    add(guys);
    add(sign);

    titleTxt = new FunkinText(0, 0, 0, dumb[curSelected][0], 40);
    add(titleTxt);
    
    changeSelection(1);
}

function update(elapsed){
    titleTxt.text = dumb[curSelected][0];
    titleTxt.screenCenter(FlxAxes.X);

    sign.angle = Math.sin(Conductor.songPosition / 400);
    if (controls.BACK && input){    
        input = false;

        FlxG.switchState(new MainMenuState());
    }

    bg.x = FlxMath.lerp(bg.x, (FlxG.mouse.screenX - bg.width/2) / 200, 0.1);
    bg.y = FlxMath.lerp(bg.y, (FlxG.mouse.screenY - bg.height/2) / 200, 0.1);

    obj.x = FlxMath.lerp(obj.x, (FlxG.mouse.screenX - obj.width/2) / 300, 0.1);
    obj.y = FlxMath.lerp(obj.y, (FlxG.mouse.screenY - obj.height/2) / 300 + 10, 0.1);

    if (FlxG.keys.justPressed.A || FlxG.keys.justPressed.LEFT)
        changeSelection(1);
    else if (FlxG.keys.justPressed.D || FlxG.keys.justPressed.RIGHT)
        changeSelection(-1);

    for (i in 0...guys.members.length){
        var egg:Float= FlxMath.lerp(guys.members[i].scale.x, 0.9, 0.05);
        guys.members[i].scale.set(egg, egg);

        
        guys.members[i].x = FlxMath.lerp(guys.members[i].x, (FlxG.mouse.screenX - guys.members[i].width/2) / 200, 0.1);
        guys.members[i].y = FlxMath.lerp(guys.members[i].y, (FlxG.mouse.screenY - guys.members[i].height/2) / 200, 0.1);
    }
    
}

function changeSelection(a){ // gh ty frakis
    curSelected = FlxMath.wrap(curSelected + a, 0, dumb.length -1);

    for (i in 0...guys.members.length){
        if (i == curSelected) guys.members[i].visible = true;
        else guys.members[i].visible = false;

        guys.members[i].scale.set(1,1);
    }

    trace("changeSelection");
    FlxG.sound.play(Paths.sound('menu/scroll'));
}
