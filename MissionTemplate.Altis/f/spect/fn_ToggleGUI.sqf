#include "macros.hpp"
private _forbiddenControls = [F_CAM_MOUSEHANDLER,F_CAM_MINIMAP,F_CAM_FULLMAP,F_CAM_SPECHELP,F_CAM_HELPCANCEL,F_CAM_SPECHELP,F_CAM_HELPFRAME,F_CAM_HELPBACK];
{
    if (!(_x in _forbiddenControls)) then {
        ctrlShow [_x,!f_cam_hideUI];
    };
    nil
} count f_cam_controls;