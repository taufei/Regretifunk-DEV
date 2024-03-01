import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

var input = true;
var playButton:FlxSprite;
var settingsButton:FlxSprite;
var creditsButton:FlxSprite;

var bg:FlxSprite;
var songs:Array<String> = ['infection'];
function create(){
    bg = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, 0xFF322221);
    add(bg);

    var titleTxt:FunkinText = new FunkinText(100, 100, 0, "Regretifunk (temporary title)", 50);
    add(titleTxt);

    FlxG.mouse.visible = true;
    playButton = new FlxSprite(100, 200);
    playButton.frames = Paths.getFrames('menus/newMainMenu/playButton');
    playButton.animation.addByPrefix('idle', 'playButtonIdle', 1);
    playButton.animation.addByPrefix('hover', 'playButtonHover', 1);
    add(playButton);
    
    settingsButton = new FlxSprite(100, 325);
    settingsButton.frames = Paths.getFrames('menus/newMainMenu/settingsButton');
    settingsButton.animation.addByPrefix('idle', 'settingsButtonIdle', 1);
    settingsButton.animation.addByPrefix('hover', 'settingsButtonHover', 1);
    add(settingsButton);
    
    creditsButton = new FlxSprite(225, 325);
    creditsButton.frames = Paths.getFrames('menus/newMainMenu/creditsButton');
    creditsButton.animation.addByPrefix('idle', 'creditsButtonIdle', 1);
    creditsButton.animation.addByPrefix('hover', 'creditsButtonHover', 1);
    add(creditsButton);

    rblxButton = new FlxSprite(350, 325);
    rblxButton.frames = Paths.getFrames('menus/newMainMenu/rblxButton');
    rblxButton.animation.addByPrefix('idle', 'rblxButtonIdle', 1);
    rblxButton.animation.addByPrefix('hover', 'rblxButtonHover', 1);
    add(rblxButton);
}

function update(elapsed){
    if (controls.BACK && input){
        input = false;

        FlxG.switchState(new MainMenuState());
    }
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