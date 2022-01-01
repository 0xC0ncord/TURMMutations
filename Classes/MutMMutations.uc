Class MutMMutations extends Mutator config(MMutations);

var int MonsterCounter;

var config bool AffectFriendlyMonsters;
var config bool CanInfectFriendlyMonsters;
var() config array<string> MutationList;
var config int MutationRegenPerSecond;
var config float MutationSpeedMin;
var config float MutationSpeedMax;
var config int MutationHealthMin;
var config int MutationHealthMax;
var config bool CanInfectOtherMonsters;
var config float InfectChance;
var config int InfectLimit;
var config float MaxMutationTime;
var config bool DisplayMessages;
var config array<string> TeleportExcludeMonster;
var config array<string> ExcludeMonster;
var config bool EnableAnnouncer;
var() config array<int> IgnoreWave;
var config bool AffectBosses;
var config bool TeleportAffectBosses;
var Sound NewMutant;
var Invasion Inv;
var float RandomTime;
var config string MutationTeleportColour;
var config string MutationHealthColour;
var config string MutationSpeedColour;
var config string MutationRegenColour;
var config int MutationTeleportDistance;
var config int MutationRegenMax;

function PostBeginPlay()
{
	local MutationReplicationInfo MyRI;

	Inv = Invasion(Level.Game);
	MonsterCounter = 0;

	MyRI = Spawn(class'MonsterMutationsv5.MutationReplicationInfo');
	MyRI.MutationRegenPerSecond = MutationRegenPerSecond;
	MyRI.MutationSpeedMin = MutationSpeedMin;
	MyRI.MutationSpeedMax = MutationSpeedMax;
	MyRI.MutationHealthMin = MutationHealthMin;
	MyRI.MutationHealthMax = MutationHealthMax;
	MyRI.MutationTeleportColour = MutationTeleportColour;
	MyRI.MutationHealthColour = MutationHealthColour;
	MyRI.MutationSpeedColour = MutationSpeedColour;
	MyRI.MutationRegenColour = MutationRegenColour;
	MyRI.CanInfectOtherMonsters = CanInfectOtherMonsters;
	MyRI.InfectChance = InfectChance;
	MyRI.InfectLimit = InfectLimit;
	MyRI.DisplayMessages = DisplayMessages;
	MyRI.MutationRegenMax = MutationRegenMax;
	MyRI.MutationTeleportDistance = MutationTeleportDistance;
	RandomTime = RandRange(1.00,MaxMutationTime);
	SetTimer(RandomTime,true);
}

function Timer()
{
	local int i;
	local int Wave;
	local Monster M;
	local Monster RandomMonster;
	local array<Monster> MonsterList;

	if(Inv != None)
	{
		for(Wave=0;Wave<IgnoreWave.Length;Wave++)
		{
			if(Inv.WaveNum + 1 == IgnoreWave[Wave])
			{
				SetTimer(1.00,true);
				return;
			}
		}
	}
	foreach DynamicActors(class'Monster',M)
	{
		if(M != None && M.Controller != None)
		{
			if(AffectFriendlyMonsters == true)
			{
				MonsterList[MonsterCounter] = M;
				MonsterCounter++;
			}
			else if(!M.Controller.IsA('FriendlyMonsterController') && !M.Controller.IsA('PetController'))
			{
				MonsterList[MonsterCounter] = M;
				MonsterCounter++;
			}
		}
	}

	if(MonsterList.Length > 0)
	{
		i = Rand(MonsterList.Length);
		RandomMonster = MonsterList[i];
		if(RandomMonster != None && RandomMonster.Health > 0)
		{
			ApplyMutation(RandomMonster, 0, 0);
		}
	}

	MonsterList.Remove(0, MonsterList.length);
	MonsterCounter = 0;
	RandomTime = RandRange(1.00,MaxMutationTime);
	SetTimer(RandomTime,true);
}

function bool ApplyMutation(Monster LuckyMonster, int PlaySound, int Message)
{
	local Inventory NewInv;
	local class<Inventory> MInv;
	local int i;
	local int e;
	local Pawn PlayerPawn;
	local class<Monster> TeleportMonster;
	local class<Monster> ExcludeMon;

	if(LuckyMonster != None && LuckyMonster.Health > 0)
	{
		i = Rand(MutationList.Length);
		MInv = class<Inventory>(DynamicLoadObject(MutationList[i],class'class'));
		if(LuckyMonster.FindInventoryType(MInv) != None || (AffectBosses == false && LuckyMonster.bBoss == true))
		{
			if(Message == 0)
			{
				SetTimer(1.00,true);
			}
			return false;
		}

		for(e=0;e<ExcludeMonster.Length;e++)
		{
			if(ExcludeMonster[e] != "None")
			{
				ExcludeMon = class<Monster>(DynamicLoadObject(ExcludeMonster[e],class'class'));
				if(LuckyMonster.class == ExcludeMon)
				{
					if(Message == 0)
					{
						SetTimer(1.00,true);
					}
					return false;
				}
			}
		}

		NewInv = spawn(MInv, LuckyMonster,,,);
		if(NewInv == None)
		{
			return false;
		}

		if((LuckyMonster.bSimulateGravity == false && NewInv.IsA('MutationSpeed')) || (TeleportAffectBosses == false && NewInv.IsA('MutationTeleport') && LuckyMonster.bBoss == true))
		{
			if(Message == 0)
			{
				SetTimer(1.00,true);
			}
			return false;
		}
		else if(NewInv.IsA('MutationTeleport'))
		{
			for(e=0;e<TeleportExcludeMonster.Length;e++)
			{
				if(TeleportExcludeMonster[e] != "None")
				{
					TeleportMonster = class<Monster>(DynamicLoadObject(TeleportExcludeMonster[e],class'class'));
					if(LuckyMonster.class == TeleportMonster)
					{
						if(Message == 0)
						{
							SetTimer(1.00,true);
						}
						return false;
					}
				}
			}
		}
		if(NewInv != None)
		{
			if(Message == 1)
			{
				NewInv.ItemName = "Infected";
				//infectious application
				if(!CanInfectFriendlyMonsters && LuckyMonster.Controller != None && (LuckyMonster.Controller.IsA('FriendlyMonsterController') || LuckyMonster.Controller.IsA('PetController')) )
				{
					return false;
				}
			}
			NewInv.GiveTo(LuckyMonster);
			foreach DynamicActors(class'Pawn',PlayerPawn)
			{
				if(PlayerPawn != None && PlayerPawn.Health > 0 && PlayerPawn.Controller != None && PlayerPawn.Controller.PlayerReplicationInfo != None)
				{
					if(DisplayMessages == true)
					{
						PlayerPawn.ReceiveLocalizedMessage( class'MonsterMutationsv5.MutationMessages', Message, None, None, None );
					}
					if(PlaySound == 0)
					{
						if(EnableAnnouncer == true)
						{
							PlayerController(PlayerPawn.Controller).ClientPlaySound(NewMutant);
						}
					}
				}
			}
			return true;
		}
	}
}

defaultproperties
{
     CanInfectFriendlyMonsters=True
     MutationList(0)="MonsterMutationsv5.MutationInvis"
     MutationList(1)="MonsterMutationsv5.MutationRegen"
     MutationList(2)="MonsterMutationsv5.MutationTeleport"
     MutationList(3)="MonsterMutationsv5.MutationHealth"
     MutationList(4)="MonsterMutationsv5.MutationSpeed"
     MutationRegenPerSecond=10
     MutationSpeedMin=1000.000000
     MutationSpeedMax=1800.000000
     MutationHealthMin=150
     MutationHealthMax=500
     CanInfectOtherMonsters=True
     InfectChance=1.000000
     InfectLimit=1
     MaxMutationTime=2.000000
     DisplayMessages=True
     TeleportExcludeMonster(0)="None"
     TeleportExcludeMonster(1)="None"
     TeleportExcludeMonster(2)="None"
     ExcludeMonster(0)="None"
     ExcludeMonster(1)="None"
     EnableAnnouncer=True
     NewMutant=Sound'AnnouncerFemale2K4.Generic.new_mutant'
     MutationTeleportColour="Purple"
     MutationHealthColour="Red"
     MutationSpeedColour="Yellow"
     MutationRegenColour="Green"
     MutationTeleportDistance=700
     MutationRegenMax=200
     bAddToServerPackages=True
     GroupName="Monster Mutations"
     FriendlyName="Monster Mutations v5"
     Description="Randomly Mutates monsters to spice things up"
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
