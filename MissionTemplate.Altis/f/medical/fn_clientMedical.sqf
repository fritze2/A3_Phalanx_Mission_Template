[{player getVariable "ace_medical_inReviveState"}, {call phx_fnc_reviveTimer;}, []] call CBA_fnc_waitUntilAndExecute;

maxTime = 3;

hitOne = false;
hitTwo = false;
hitThree = false;
hitFour = false;
hitFive = false;
hitOneTime = 0;
hitTwoTime = 0;
hitThreeTime = 0;
hitFourTime = 0;
hitFiveTime = 0;

headCounter = 0;
bodyCounter = 0;
armsCounter = 0;
legsCounter = 0;
inRevive = false;

_hitThresholdEH = player addEventHandler ["Hit", {

	if (!alive player) exitWith {player removeEventHandler ["Hit", 0]};

	if (hitOne && hitTwo && hitThree && hitFour && !hitFive) then {
		hitFiveTime = diag_tickTime;
		if (hitFiveTime - hitOneTime <= maxTime) then {
			hitFive = true;
			player setDamage 1;
		} else {
			hitOne = false;
			hitTwo = false;
			hitThree = false;
			hitFour = false;
			hitFive = false;
		};
	};

	if (hitOne && hitTwo && hitThree && !hitFour) then {
		hitFourTime = diag_tickTime;
		if (hitFourTime - hitOneTime <= maxTime) then {
			hitFour = true;
		} else {
			hitOne = false;
			hitTwo = false;
			hitThree = false;
			hitFour = false;
			hitFive = false;
		};
	};

	if (hitOne && hitTwo && !hitThree) then {
		hitThreeTime = diag_tickTime;
		if (hitThreeTime - hitOneTime <= maxTime) then {
			hitThree = true;
		} else {
			hitOne = false;
			hitTwo = false;
			hitThree = false;
			hitFour = false;
			hitFive = false;
		};
	};

	if (hitOne && !hitTwo) then {
		hitTwoTime = diag_tickTime;
		if (hitTwoTime - hitOneTime <= maxTime) then {
			hitTwo = true;
		} else {
			hitOne = false;
			hitTwo = false;
			hitThree = false;
			hitFour = false;
			hitFive = false;
		};
	};

	if (!hitOne) then {
		hitOne = true;
		hitOneTime = diag_tickTime;
	};
}];

_reviveDamageEH = player addEventHandler ["HitPart", {

	if (!alive player) exitWith {player removeEventHandler ["HitPart", 0]};

	_selectionArray = _this select 0;
	_bodyPart = _selectionArray select 5;

	if (player getVariable "ace_medical_inReviveState") then {
		inRevive = true;
	};
	if (!(player getVariable "ACE_isUnconscious")) then {
		inRevive = false;
		headCounter = 0;
		bodyCounter = 0;
		armsCounter = 0;
		legsCounter = 0;
	};

	if (_bodyPart isEqualTo ["head"] && !phx_safeStartEnabled) then {
		headCounter = headCounter + 1;
		player setDamage 1;
	};
	if ((_bodyPart isEqualTo ["spine1"] || _bodyPart isEqualTo ["spine3"]) && inRevive) then {
		bodyCounter = bodyCounter + 1;
	};
	if ((_bodyPart isEqualTo ["rightarm"] || _bodyPart isEqualTo ["leftarm"] || _bodyPart isEqualTo ["rightforearm"] || _bodyPart isEqualTo ["leftforearm"]) && inRevive) then {
		armsCounter = armsCounter + 1;
	};
	if ((_bodyPart isEqualTo ["rightfoot"] || _bodyPart isEqualTo ["leftfoot"] || _bodyPart isEqualTo ["rightleg"] || _bodyPart isEqualTo ["leftleg"] || _bodyPart isEqualTo ["rightupleg"] || _bodyPart isEqualTo ["leftupleg"]) && inRevive) then {
		legsCounter = legsCounter + 1;
	};

	if (inRevive && (headCounter >= 1 || bodyCounter >= 5 || armsCounter >= 6 || legsCounter >= 8)) then {
		player setDamage 1;
	};
}];

_numberOfEpi = {"ACE_epinephrine" == _x} count (items player);
for "_i" from 1 to (_numberOfEpi) do {
	player removeItem "ACE_epinephrine";
};

if (typeOf player == "O_medic_F" || typeOf player == "B_medic_F" || typeOf player == "I_medic_F") then {
	for [{_i=1}, {_i<=6}, {_i=_i+1}] do {
		player addItem "ACE_epinephrine";
	};
	player setVariable ["Ace_medical_medicClass", 1];
	player addItem "ACE_bloodIV";
	player addItem "ACE_bloodIV";
	player addItem "ACE_bloodIV";
	player addItem "ACE_bloodIV";
};
//rightfoot, leftfoot, rightleg, leftleg, rightupleg, leftupleg, spine1, spine3, rightarm, leftarm, rightforearm, leftforearm, head
