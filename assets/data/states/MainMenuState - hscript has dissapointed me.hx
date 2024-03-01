import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

typedef MainMenuItem = {
    var x:Int;
    var y:Int;
    var name:String;
}

function onSelectItem(event) event.cancel();

function create() FlxG.keys.enabled = true;

var buttons:Array<MainMenuItem> = [
    {x: 0, y: 0, name: "playButton"},
    {x: 0, y: 100, name: "settingsButton"},
    {x: 0, y: 200, name: "creditsButton"}
];
var bg:FlxSprite;
var songs:Array<String> = ['infection'];
var ohMyButtons:FlxTypedGroup<FlxSprite>;

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

    var titleTxt:FunkinText = new FunkinText(100, 100, 0, "Regretifunk (temporary title)", 50);
    titleTxt.scrollFactor.set();
    add(titleTxt);

    FlxG.mouse.visible = true;
    /*playButton = new FlxSprite(100, 200);
    playButton.frames = Paths.getFrames('menus/newMainMenu/playButton');
    playButton.animation.addByPrefix('idle', 'playButtonIdle', 1);
    playButton.animation.addByPrefix('hover', 'playButtonHover', 1);
    
    playButton.scrollFactor.set();
    add(playButton);
    
    settingsButton = new FlxSprite(100, 325);
    settingsButton.frames = Paths.getFrames('menus/newMainMenu/settingsButton');
    settingsButton.animation.addByPrefix('idle', 'settingsButtonIdle', 1);
    settingsButton.animation.addByPrefix('hover', 'settingsButtonHover', 1);
    settingsButton.scrollFactor.set();
    add(settingsButton);
    
    creditsButton = new FlxSprite(225, 325);
    creditsButton.frames = Paths.getFrames('menus/newMainMenu/creditsButton');
    creditsButton.animation.addByPrefix('idle', 'creditsButtonIdle', 1);
    creditsButton.animation.addByPrefix('hover', 'creditsButtonHover', 1);
    creditsButton.scrollFactor.set();
    add(creditsButton);

    rblxButton = new FlxSprite(350, 325);
    rblxButton.frames = Paths.getFrames('menus/newMainMenu/rblxButton');
    rblxButton.animation.addByPrefix('idle', 'rblxButtonIdle', 1);
    rblxButton.animation.addByPrefix('hover', 'rblxButtonHover', 1);
    rblxButton.scrollFactor.set();
    add(rblxButton);*/

    for (i in 0...buttons.length){
        var button:FlxSprite = new FlxSprite(buttons[i].x, buttons[i].y);
        button.frames = Paths.getFrames('menus/newMainMenu/' + buttons[i].name);
        buttons.animation.addByPrefix('idle', buttons[i].name + 'idle', 1);
        buttons.animation.addByPrefix('hover', buttons[i].name + 'hover', 1);
        ohMyButtons.add(button);
        button.ID = i;
    }
}
function update(elapsed){
    if (FlxG.mouse.overlaps(playButton)){
        playButton.animation.play('hover', true);

        if (FlxG.mouse.justPressed){        
            var rand = FlxG.random.int(0, songs.length - 1);
            PlayState.loadSong(songs[rand]);
            FlxG.switchState(new PlayState());
        }
    } else {
        playButton.animation.play('idle', true);
    }
        
    if (FlxG.mouse.overlaps(settingsButton)){
        settingsButton.animation.play('hover', true);
        if (FlxG.mouse.justPressed){        
            FlxG.switchState(new OptionsMenu());
        }
    } else settingsButton.animation.play('idle', true);

    if (FlxG.mouse.overlaps(creditsButton)){
        creditsButton.animation.play('hover', true);
        if (FlxG.mouse.justPressed)
            FlxG.switchState(new CreditsMain());
    } else creditsButton.animation.play('idle', true);

    if (FlxG.mouse.overlaps(rblxButton)){
        rblxButton.animation.play('hover', true);
        if (FlxG.mouse.justPressed)
            CoolUtil.openURL("https://rblx.games/4972273297");
    } else rblxButton.animation.play('idle', true);


    FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, 0.05);
}

function beatHit(curBeat)
    FlxG.camera.zoom = 1.01;