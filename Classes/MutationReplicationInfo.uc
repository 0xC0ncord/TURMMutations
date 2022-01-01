class MutationReplicationInfo extends ReplicationInfo;

var int MutationRegenPerSecond;
var int MutationRegenMax;
var float MutationSpeedMin;
var float MutationSpeedMax;
var int MutationHealthMin;
var int MutationHealthMax;
var bool CanInfectOtherMonsters;
var float InfectChance;
var int InfectLimit;
var bool DisplayMessages;
var String MutationTeleportColour;
var String MutationHealthColour;
var String MutationSpeedColour;
var String MutationRegenColour;
var int MutationTeleportDistance;

replication
{
    reliable if(Role == ROLE_Authority)
		MutationRegenPerSecond, MutationSpeedMin, MutationSpeedMax, InfectLimit, MutationRegenMax;
	reliable if(Role == ROLE_Authority)
		MutationHealthMin, MutationHealthMax, CanInfectOtherMonsters, InfectChance, MutationTeleportDistance;
	reliable if(Role == ROLE_Authority)
		DisplayMessages, MutationTeleportColour, MutationHealthColour, MutationSpeedColour, MutationRegenColour;
}

defaultproperties
{
}
