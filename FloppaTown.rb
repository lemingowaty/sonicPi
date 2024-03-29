def git struna=0, prog=0
  gitara = [:E2,:A3,:d4,:g4,:b4,:e3]
  return note(gitara[struna])+prog
end
prog = 0
def pchE prog = 0
  x = [
    (git(0,prog)),
    (git(1,prog+2)),
    (git(2,prog+2))
  ]
  puts x
  return x
end



use_synth :tech_saws
use_synth_defaults sustain:0.15, release:0.2
akord0 = pchE
akord2 = pchE 5
akord1 = pchE 1
akord4 = pchE 7
akord5 = pchE 8
i = 0
puts akord0
puts akord2
live_loop :motyw do
  ##| with_fx :lpf , cutoff: 106,pre_mix:0.2 do
  
  ##| with_fx :echo,mix:0.8,max_phase:4,phase:0.25, decay:2 do
  play_chord akord2, amp:0.5
  play akord2[1],sustain:0.5,amp:0.5
  sleep 0.5
  
  ##
  play_chord akord2
  p = play akord2[2]+3 , sustain:2.875,amp:0.5
  sleep 0.5
  #
  play_chord akord0
  p.control note:akord2[2], decay:4
  sleep 0.5
  play_chord akord0
  p.control note:akord5[1]
  sleep 0.25
  p.control note:akord5[1]+2
  sleep 0.25
  ##
  if factor?(i, 2)
    p.control note: note(:E4)+12
  else
    p.control note: note(:E4)+8
  end
  play_chord akord0
  sleep 0.25
  if factor?(i, 2)
    p.control note: note(:E4)+8
  else
    p.control note: note(:E4)+13
  end
  play_chord akord5
  sleep 0.25
  p.control note: note(:E4)+12
  sleep 0.5
  #
  ##| end
  akord = play_chord pchE(10), sustain:1, release_sustain:1
  akord.control slide:1, slide_sustain:0.2
  sleep 0.25
  akord.control note:(pchE 8)[2], slide:0.25, slide_note:0.1, env_curve:3
  sleep 0.25
  akord.control note:(pchE 8)[1], slide:0.125
  sleep 0.125
  akord.control note:(pchE 10)[1]
  sleep 0.125
  akord.control note:(pchE 8)[2], sustain:0, slide_sustain:0, slide_release:0, release_level:0
  sleep 0.25
  ##
  ##| end
  i += 1
end
