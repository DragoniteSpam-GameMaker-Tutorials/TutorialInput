var dx = 0, dy = 0;

running = false;

if (casting_frame == 0) {
    if (!talking) {
        if (input_check("left")) {
            dx = -1;
        }
        if (input_check("right")) {
            dx = 1;
        }
        if (input_check("up")) {
            dy = -1;
        }
        if (input_check("down")) {
            dy = 1;
        }
        if (input_check_pressed("cast")) {
            casting_frame = sprite_get_number(spr_duckling_cast) / 4;
        }
    }
    
    if (dx != 0 || dy != 0) {
        var mag = point_distance(0, 0, dx, dy);
        if (input_check("run")) {
            running = true;
            mag /= 1.5;
        }
        dx /= mag;
        dy /= mag;
        anim_frame = (anim_frame + 0.125) % 4;
        anim_dir = point_direction(0, 0, dx, dy) / 90;
    } else {
        anim_frame = 0;
    }
    
    x += dx * 2;
    y += dy * 2;
    
    if (input_check_pressed("action") && !talking) {
        var facing = collision_point(x + 24 * dcos(anim_dir * 90), y - 24 * dsin(anim_dir * 90), par_thingy, false, true);
        if (facing) {
            talking = facing;
            talking_t = 0;
        }
        audio_play_sound(se_coin, 110, false);
    }
    
    if (dx != 0 || dy != 0) {
        if (!audio_is_playing(se_footstep)) {
            audio_play_sound(se_footstep, 100, false);
        }
    }
} else {
    casting_frame = max(0, casting_frame - 0.25);
}

if (is_hit == false && place_meeting(x, y, obj_walky)) {
    is_hit = true;
    
    hp--;
    
    if (hp <= 0) {
        instance_destroy();
        //input_vibrate_pulse(1, 0, 3, 3_000);
        return;
    }
    
    //input_vibrate_constant(1, 0, 1_000);
    input_vibrate_curve(1, ac_cubic_io, 0, 2_000);
    
    call_later(2, time_source_units_seconds, function() {
        is_hit = false;
    });
}