import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;


function onSelectItem(event) {selectedSomethin = false; event.cancel();}
function onChangeItem(event) event.cancel();

var buttonList:Array<String> = [
    'playButton',
    'floorSelectButton',
    'settingsButton',
    'creditsButton',
    'rblxButton'
];

var button:FlxSprite;
var titleSpr:FlxSprite;

var buttons:FlxTypedGroup<FlxSprite>;

var curSelected:Int = 0;

var songs:Array<String> = ['infection'];

function postCreate(){
    for (y in menuItems.members) y.visible = false;
    
    var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x44FFFFFF, 0x11111111));
    grid.velocity.set(80, 40);
    grid.alpha = 0;
    grid.scrollFactor.set(0, 0.1);
    FlxTween.tween(grid, {alpha: 0.2}, 0.5, {ease: FlxEase.quadOut});
    insert(members.indexOf(magenta)+1,grid);

    bg = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, 0xFF322221);
    bg.scrollFactor.set();
    insert(members.indexOf(grid), bg);

    titleSpr = new FlxSprite(-150, -100).loadGraphic(Paths.image('menus/regretifunk_logo'));
    titleSpr.scrollFactor.set();
    titleSpr.scale.set(0.9, 0.9);
    add(titleSpr);

    FlxG.mouse.visible = true;

    buttons = new FlxTypedGroup();
    add(buttons);

    for (i in 0...buttonList.length){
        button = new FlxSprite(0, 0);
        button.frames = Paths.getFrames('menus/newMainMenu/' + buttonList[i]);
        button.animation.addByPrefix('idle', buttonList[i] + 'Idle', 1);
        button.animation.addByPrefix('hover', buttonList[i] + 'Hover', 1);
        button.ID = i;
        button.scale.set(0.85, 0.85);
        buttons.add(button);
        switch(i){
            case 0:
                button.setPosition(60, 325);
            case 1:
                button.setPosition(60, 437.5);
            case 2:
                button.setPosition(100, 550);
            case 3:
                button.setPosition(225, 550);
            case 4:
                button.setPosition(350, 550);
        }
        button.scrollFactor.set();
    }
}
var egg:Float;
function postUpdate(elapsed){
    titleSpr.angle = Math.sin(Conductor.songPosition / 200);
    egg = FlxMath.lerp(titleSpr.scale.x, 0.9, 0.05);
    titleSpr.scale.set(egg, egg);

    buttons.forEach(function(spr:FlxSprite){
        if (FlxG.mouse.overlaps(spr)){
            if (curSelected != spr.ID)
                curSelected = spr.ID;
            spr.animation.play('hover');
        } else {
            spr.animation.play('idle');
        }
    });

    if (FlxG.mouse.overlaps(buttons) && FlxG.mouse.justPressed){
        switch(curSelected){
            case 0:
                var rand = FlxG.random.int(0, songs.length - 1);
                PlayState.loadSong(songs[rand]);
                FlxG.switchState(new PlayState());
            case 1:
                FlxG.switchState(new FreeplayState());
            case 2:
                FlxG.switchState(new OptionsMenu());
            case 3:
                FlxG.switchState(new ModState('newCreditsState'));
            case 4:
                CoolUtil.openURL("https://rblx.games/4972273297");
        }
    }
    FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, 0.05);
}

function beatHit(curBeat){
    titleSpr.scale.set(1,1);
    FlxG.camera.zoom = 1.01;
}