event_inherited();

talking = noone;
talking_t = 0;

running = false;
casting_frame = 0;

hp = 3;

if (!audio_is_playing(bgm_idle_with_accordions)) {
    audio_play_sound(bgm_idle_with_accordions, 100, true);
}

is_hit = false;