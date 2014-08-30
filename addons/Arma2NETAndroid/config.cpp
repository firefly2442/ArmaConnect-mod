//https://community.bistudio.com/wiki/Functions_Library_%28Arma_3%29
//https://community.bistudio.com/wiki/Config.cpp/bin_File_Format

class CfgPatches
{
	class Arma2NETAndroid
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.08;
		requiredAddons[] = {};
		versionDesc = "Arma2NETAndroid";
		author[] = {"Firefly2442"};
	};
};

class CfgFunctions
{
	class Arma2NETAndroid
	{
		tag = "Arma2NETAndroid";
		class functions
		{
			file = "\Arma2NETAndroid\functions";
			class initAndroid{
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
			};
		};
	};
};
