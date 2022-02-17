use std::fs::File;
use std::io::BufReader;
use std::{thread, time};
use notify_rust::Notification;
use rodio::{Decoder, OutputStream, source::Source, Sink};

fn main() {
    loop {
        let twenty_minutes = time::Duration::from_secs(20 * 60);
        thread::sleep(twenty_minutes);
        notify("Look away for 20 seconds!");
        let twenty_seconds = time::Duration::from_secs(20);
        thread::sleep(twenty_seconds);
        notify("You can look back now!");
        success_sound();
    }
}

fn notify(message: &str) {
    Notification::new()
        .summary("Twenty Twenty")
        .body(message)
        // .icon("firefox")
        .show()
        .unwrap();
}

fn success_sound() {
    // https://www.freesoundslibrary.com/success-sound-effect
    let sound_effect = File::open("assets/success-sound-effect.mp3").unwrap();

    let (_stream, stream_handle) = OutputStream::try_default().unwrap();
    let sink = Sink::try_new(&stream_handle).unwrap();
    sink.set_volume(0.6);
    let reader = BufReader::new(sound_effect);
    let source = Decoder::new(reader).unwrap();
    sink.append(source);
    sink.sleep_until_end();
}
