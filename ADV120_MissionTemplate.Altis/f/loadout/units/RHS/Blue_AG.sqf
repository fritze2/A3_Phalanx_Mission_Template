// Set unit level -- 0=Default, 1=TL, 2=SL+
phx_loadout_unitLevel = 0;

// Add clothing
player forceAddUniform "rhs_uniform_FROG01_wd";
player addVest "rhsusf_spc_rifleman";
player addBackpack "rhsusf_assault_eagleaiii_coy";
player addHeadgear "rhsusf_lwh_helmet_marpatwd";

// Add gear
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 5 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";};
for "_i" from 1 to 3 do {player addItemToBackpack "rhsusf_100Rnd_762x51_m80a1epr";};
player addWeapon "rhs_weap_m16a4_carryhandle";
for "_i" from 1 to 4 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};

// Add items
phx_loadout_addBinocular = "Binocular";
call phx_fnc_loadout_handleItems;

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
