function Speach(word)
     if word == 'hi' then
          PlayPedAmbientSpeechNative(GETPED(), 'GENERIC_HI', 'Speech_Params_Force_Normal_Clear')
     elseif word == 'whatever' then
          PlayPedAmbientSpeechNative(GETPED(), 'GENERIC_WHATEVER', 'Speech_Params_Force_Frontend')
     elseif word == 'thanks' then
          PlayPedAmbientSpeechNative(GETPED(), 'GENERIC_THANKS', 'Speech_Params_Force_Shouted_Critical')
     end
end
