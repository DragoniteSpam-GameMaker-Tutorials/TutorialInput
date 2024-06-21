global.peak_strength = 1;
global.sustain_level = 0.5;
global.attack = 250;
global.decay = 500;
global.sustain = 1000;
global.release = 1000;

dbg_view("ADSR rumble", false);
dbg_slider(ref_create(global, "peak_strength"), 0, 1, "Peak strength");
dbg_slider(ref_create(global, "sustain_level"), 0, 1, "Sustain level");
dbg_slider(ref_create(global, "attack"), 0, 5000, "Attack (ms)");
dbg_slider(ref_create(global, "decay"), 0, 5000, "Decay (ms)");
dbg_slider(ref_create(global, "sustain"), 0, 5000, "Sustain (ms)");
dbg_slider(ref_create(global, "release"), 0, 5000, "Release (ms)");
dbg_button("Vibrate", function() {
    input_source_set(INPUT_GAMEPAD[0]);
    input_vibrate_adsr(
        global.peak_strength,
        global.sustain_level,
        0,
        global.attack,
        global.decay,
        global.sustain,
        global.release
    );
});
dbg_button("Cancel", input_vibrate_stop);