//https://community.bistudio.com/wiki/Functions_Library_%28Arma_3%29
//https://community.bistudio.com/wiki/Config.cpp/bin_File_Format

class CfgPatches
{
	class Arma2NETConnect
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.08;
		requiredAddons[] = {};
		versionDesc = "Arma2NETConnect";
		author[] = {"Firefly2442"};
	};
};

class CfgFunctions
{
	class Arma2NETConnect
	{
		tag = "Arma2NETConnect";
		class functions
		{
			file = "\Arma2NETConnect\functions";
			class initAndroid{
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
			};
		};
	};
};
