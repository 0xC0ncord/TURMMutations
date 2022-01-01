class MutationMessages extends LocalMessage;

var(String) localized string DefaultMessage;
var(String) localized string InfectMessage;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if(Switch == 0)
    {
        return Default.DefaultMessage;
	}
	else if(Switch == 1)
	{
		return Default.InfectMessage;
	}
	else
	{
		return Default.DefaultMessage;
	}
}

defaultproperties
{
     DefaultMessage="A Monster Has Mutated"
     InfectMessage="A Monster Was Infected"
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     Lifetime=5
     DrawColor=(B=150,G=0,R=115)
}
