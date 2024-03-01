import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import flixel.util.FlxTimer;
var curVideo = null;
var quitted = false;
function create() {
	trace("uh oh you died!!");
        curVideo = new FlxVideo();
        curVideo.onEndReached.add(curVideo.dispose);
        var path = Paths.file("video/death.mp4");
	curVideo.load(Assets.getPath(path));

	var timer:FlxTimer = new FlxTimer();
	timer.start(1, curVideo.play(), 0);
}

function update() {
	lossSFX.volume = 0;
	if (FlxG.sound.music != null) {
		FlxG.sound.music.stop();
	}
	if (controls.BACK || controls.ACCEPT) {
		trace("IM OUTA HERE!!!!");
		quitted = true;
		if (curVideo != null) curVideo.dispose();
		if (FlxG.game.contains(curVideo)) {
			FlxG.game.removeChild(curVideo);
		}
		FlxG.switchState(new PlayState());
	}
	if (quitted) {
		FlxG.camera.alpha = 0;
	}
	trace(curVideo.length - curVideo.time);
	if (curVideo.time == -1 && !quitted) {
        	curVideo = new FlxVideo();
        	curVideo.onEndReached.add(curVideo.dispose);
        	var path = Paths.file("videos/death.mp4");
		curVideo.load(Assets.getPath(path));

		var timer:FlxTimer = new FlxTimer();
		timer.start(1, curVideo.play(), 0);
	}
}