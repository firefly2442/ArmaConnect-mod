
//Run forever, sending data
////https://community.bistudio.com/wiki/BIS_fnc_loop
//"Code and conditions are executed in non-scheduled environment."
//This should be better for performance

//https://community.bistudio.com/wiki/diag_log
//write to .rpt file
diag_log "Starting Arma2NETConnect";

["itemAdd", ["uniqueId", {

	//https://community.bistudio.com/wiki/assignedItems
	//https://community.bistudio.com/wiki/items
	//https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
	if ("ItemGPS" in assignedItems player || "ItemGPS" in items player) then {
		//https://community.bistudio.com/wiki/worldName
		//get World name (Stratis, Altis, etc.)
		_map = worldName;
		
		//https://community.bistudio.com/wiki/getPos
		//get player position
		_playerPos = getPos player;
		
		//https://community.bistudio.com/wiki/getDir
		//get player rotation
		_degrees = getDir player;

		//https://community.bistudio.com/wiki/vehicle
		//identify if the player is in a vehicle or not

		_return = "Arma2Net" callExtension format ["Arma2NETConnect ['player', '%1', '%2', '%3', '%4', '%5']", _map, _playerPos select 0, _playerPos select 1, _degrees, (vehicle player != player)];
		while {isNil("_return") || _return == ""} do {
			_return = "Arma2Net" callExtension "Arma2NETConnect getresult";
			//apparently we can't use sleep in this loop structure, I guess this is OK for now...
			//sleep 0.5; //sleep for a half-second so we don't thrash the client with callExtension calls
		};
	};
	
	//https://community.bistudio.com/wiki/assignedItems
	//https://community.bistudio.com/wiki/items
	//https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
	if ("ItemWatch" in assignedItems player || "ItemWatch" in items player) then {
		//https://community.bistudio.com/wiki/date
		//get current date and time
		_date = [date select 0, date select 1, date select 2]; //year, month, day
		//https://community.bistudio.com/wiki/BIS_fnc_timeToString
		_time = [daytime, "ARRAY"] call bis_fnc_TimeToString; //hour, minute, seconds, milliseconds
		_date = _date + _time;
		_datetime = format ["datetime,%1,%2,%3,%4,%5,%6,%7", _date select 0, _date select 1, _date select 2, _date select 3, _date select 4, _date select 5, _date select 6];
		
		_return = "Arma2Net" callExtension format ["Arma2NETConnect ['%1']", _datetime];
		while {isNil("_return") || _return == ""} do {
			_return = "Arma2Net" callExtension "Arma2NETConnect getresult";
			//apparently we can't use sleep in this loop structure, I guess this is OK for now...
			//sleep 0.5; //sleep for a half-second so we don't thrash the client with callExtension calls
		};
	};

	//Overcast (0-1)
		//https://community.bistudio.com/wiki/overcast
		//https://community.bistudio.com/wiki/overcastForecast
	//Fog (0-1)
		//https://community.bistudio.com/wiki/fog
		//https://community.bistudio.com/wiki/fogForecast
	//Rain (0-1)
		//https://community.bistudio.com/wiki/rain
	//Lightning (0-1)
		//https://community.bistudio.com/wiki/lightnings
	//Waves (0-1)
		//https://community.bistudio.com/wiki/waves
	//Wind
		//Strength (0-1)
			//https://community.bistudio.com/wiki/windStr
		//Gusts (0-1)
			//https://community.bistudio.com/wiki/gusts
		//Wind direction (vector [x, y, z] in m/s)
			//https://community.bistudio.com/wiki/wind
		//Wind direction in degrees (0-360)
			//https://community.bistudio.com/wiki/windDir
	//Humidity (0-1)
		//https://community.bistudio.com/wiki/humidity

	//calculate wind speed (in meters per second) through magnitude calculation of vector
	//https://community.bistudio.com/wiki/Category:Command_Group:_Math
	_windSpeed = sqrt(((wind select 0) ^ 2) + ((wind select 1) ^ 2) + ((wind select 2) ^ 2));
	_weather = format ["weather,%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13,%14,%15,%16,%17,%18,%19,%20", overcast, overcastForecast, fog, fogForecast, rain, -1, lightnings, -1, waves, -1, windStr, -1, gusts, -1, _windSpeed, -1, windDir, -1, humidity, -1];

	//send weather data
	_return = "Arma2Net" callExtension format ["Arma2NETConnect ['%1']", _weather];
	while {isNil("_return") || _return == ""} do {
		_return = "Arma2Net" callExtension "Arma2NETConnect getresult";
		//apparently we can't use sleep in this loop structure, I guess this is OK for now...
		//sleep 0.5; //sleep for a half-second so we don't thrash the client with callExtension calls
	};

}, 0.5, "seconds"]] call BIS_fnc_loop;