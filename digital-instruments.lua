-----------------------------------------------
-- Digital Instruments
--
-- Uses imgui for the UI element. See imgui_demo.lua
-- for documentation.
-----------------------------------------------

if not SUPPORTS_FLOATING_WINDOWS then
    logMsg('Please update your FlyWithLua to the latest version')
    return
end

require('graphics')
require('math')

dataref('gps1_crs', 'sim/cockpit/radios/gps_course_degtm')
dataref('nav1_obs', 'sim/cockpit/radios/nav1_obs_degm')
dataref('nav1_fromto', 'sim/cockpit/radios/nav1_fromto')
dataref('nav1_dme', 'sim/cockpit/radios/nav1_dme_dist_m')
dataref('gps2_crs', 'sim/cockpit/radios/gps2_course_degtm2')
dataref('nav2_obs', 'sim/cockpit/radios/nav2_obs_degm')
dataref('nav2_fromto', 'sim/cockpit/radios/nav2_fromto')
dataref('nav2_dme', 'sim/cockpit/radios/nav2_dme_dist_m')

local fromto_text = {[0]='OFF', [1]='TO', [2]='FROM'}

local wnd = float_wnd_create(180, 100, 1, true)
float_wnd_set_position(wnd, 100, SCREEN_HIGHT - 150)
float_wnd_set_title(wnd, 'Digital Instruments')
float_wnd_set_imgui_builder(wnd, 'DIGI_build_window')

local function clampAngle(angle)
	return math.fmod(angle + 3600, 360)
end

function DIGI_build_window(wnd, x, y)
    imgui.TextUnformatted('        NAV1    NAV2')
    imgui.TextUnformatted('GPS     ' .. string.format('%03d', clampAngle(gps1_crs)) .. string.format('     %03d', clampAngle(gps2_crs)))
    imgui.TextUnformatted('OBS     ' .. string.format('%03d', clampAngle(nav1_obs)) .. string.format('     %03d', clampAngle(nav2_obs)))
    imgui.TextUnformatted('FLAG    ' .. string.format('%-4s', fromto_text[nav1_fromto]) .. string.format('    %-4s', fromto_text[nav2_fromto]))
    imgui.TextUnformatted('DME     ' .. string.format('%.1f', nav1_dme) .. string.format('     %.1f', nav2_dme))
end

