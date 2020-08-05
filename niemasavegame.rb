define :git do |struna=0, prog=0|
  
  gitara = [:E2,:A3,:d3,:g4,:b4,:e5].map {|x| x = note(x)}
  r = gitara[struna]+prog
  return r
end
##| use_synth :tr
notes = [ git(0,5) ]
notes.push( notes[0]+5 , notes[0]+6 , git(1,5) )
notes.push( notes[1]-5, notes[0]+7 , notes[1]-3 , git(1,2) )
puts notes
live_loop :doopa , sync: "/live_loop/stopa" do
  density 2 do |n|
    notes.each { |x|
      density 2 do
        
        
        with_fx :lpf,cutoff:80, pre_amp:1,amp:2, mix:1, pre_mix:0.5 do
          ##| with_fx :flanger , mix:0.5 do
          synth :tri, note: x, attack:0.075,decay:0.425,decay_level:1,sustain_level:0.8, sustain:0.25,release:0.2275, pitch:-12, attack_level:0.5, cutoff:100, amp:1 do
            
            synth :dsaw, note: chord(x,:m), attack_level:0.5, attack:0.075,decay:0,sustain:0.25,release:0.25, cutoff: 50,  pitch:12, detune:0.25, amp:1.5
            
          end
          ##| end
        end
        sleep 1
      end
    }
  end
end
live_loop :stopa do
  density 2 do |n|
    sample :bd_zome, amp:0.5
    sleep 1
    sample :bd_zome, amp:0.5
    density n%2+1 do
      sleep 1
      sample :sn_zome, amp:0.5
      
    end
    sleep 1
  end
end