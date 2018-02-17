[] spawn {
  for [{_i=ace_medical_maxReviveTime}, {_i>0}, {_i=_i-1}] do {
    if (!(player getVariable "ACE_isUnconscious")) exitWith {
      hint "";
      headCounter = 0;
  		bodyCounter = 0;
  		armsCounter = 0;
  		legsCounter = 0;
      [{player getVariable "ace_medical_inReviveState"}, {call phx_fnc_reviveTimer;}, []] call CBA_fnc_waitUntilAndExecute
    };
    if (!alive player) exitWith {
      hint "";
      [{player getVariable "ace_medical_inReviveState"}, {call phx_fnc_reviveTimer;}, []] call CBA_fnc_waitUntilAndExecute
    };
    hint format ["You have %1 seconds left on the revive timer\nPress 'Escape' to manually respawn (spectate)", _i];
    sleep 1;
  };
};
