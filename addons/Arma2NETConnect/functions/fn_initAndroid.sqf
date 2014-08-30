
//Run forever, sending data
////https://community.bistudio.com/wiki/BIS_fnc_loop
//"Code and conditions are executed in non-scheduled environment."
//This should be better for performance

diag_log "Starting ArmaConnect";

["itemAdd", ["uniqueId", {

	//https://community.bistudio.com/wiki/assignedItems
	//https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
	if ("ItemGPS" in assignedItems player) then {
		//https://community.bistudio.com/wiki/worldName
		//get World name (Stratis, Altis, etc.)
		_map = worldName;
		
		//https://community.bistudio.com/wiki/getPos
		//get player position
		_playerPos = getPos player;
		
		//https://community.bistudio.com/wiki/getDir
		//get player rotation
		_degrees = getDir player;

		_return = "Arma2Net" callExtension format ["Arma2NETAndroid ['player', '%1', '%2', '%3', '%4']", _map, _playerPos select 0, _playerPos select 1, _degrees];
		while {isNil("_return") || _return == ""} do {
			_return = "Arma2Net" callExtension "Arma2NETConnect getresult";
			//apparently we can't use sleep in this loop structure, I guess this is OK for now...
			//sleep 0.5; //sleep for a half-second so we don't thrash the client with callExtension calls
		};
		
		//https://community.bistudio.com/wiki/diag_log
		//write to .rpt file
		diag_log format ["Return: %1", _return];
	};
	
	//https://community.bistudio.com/wiki/assignedItems
	//https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
	if ("ItemWatch" in assignedItems player) then {
		//https://community.bistudio.com/wiki/date
		//get current date and time
		_date = [date select 0, date select 1, date select 2]; //year, month, day
		//https://community.bistudio.com/wiki/BIS_fnc_timeToString
		_time = [daytime, "ARRAY"] call bis_fnc_TimeToString; //hour, minute, seconds, milliseconds
		_date = _date + _time;
		_datetime = format ["datetime,%1,%2,%3,%4,%5,%6,%7", _date select 0, _date select 1, _date select 2, _date select 3, _date select 4, _date select 5, _date select 6];
		
		_return = "Arma2Net" callExtension format ["Arma2NETAndroid ['%1']", _datetime];
		while {isNil("_return") || _return == ""} do {
			_return = "Arma2Net" callExtension "Arma2NETConnect getresult";
			//apparently we can't use sleep in this loop structure, I guess this is OK for now...
			//sleep 0.5; //sleep for a half-second so we don't thrash the client with callExtension calls
		};
	};


}, 1, "seconds"]] call BIS_fnc_loop;