class MutationSpeed extends Inventory;

var MutationEmitter MonsterEffect;
var Monster LuckyMonster;
var MutMMutations Mut;
var	MutationReplicationInfo MyRI;
var int InfectedMonsterCount;
var class<MutationEmitter> MutationEmitters[11];

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	local MutationReplicationInfo RI;
	local MutMMutations M;
	local int i;

	if(Other == None)
	{
		destroy();
		return;
	}

	LuckyMonster = Monster(Other);
	if(LuckyMonster.bSimulateGravity == false)
	{
		destroy();
		return;
	}

	foreach DynamicActors(class'MonsterMutationsv5.MutMMutations', M)
	{
		if(M != None)
		{
			Mut = M;
		}
	}

	foreach DynamicActors(class'MonsterMutationsv5.MutationReplicationInfo', RI)
	{
		if(RI != None)
		{
			MyRI = RI;
			LuckyMonster.GroundSpeed = RandRange(MyRI.MutationSpeedMin,MyRI.MutationSpeedMax);
			LuckyMonster.WaterSpeed = LuckyMonster.GroundSpeed;
			LuckyMonster.AirSpeed = LuckyMonster.GroundSpeed;
			LuckyMonster.JumpZ = LuckyMonster.GroundSpeed;

			if(MyRI.MutationSpeedColour ~= "Red")
				MonsterEffect = Spawn(MutationEmitters[9], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Yellow")
				MonsterEffect = Spawn(MutationEmitters[10], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Pink")
				MonsterEffect = Spawn(MutationEmitters[6], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Green")
				MonsterEffect = Spawn(MutationEmitters[4], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Orange")
				MonsterEffect = Spawn(MutationEmitters[5], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Purple")
				MonsterEffect = Spawn(MutationEmitters[7], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Blue")
				MonsterEffect = Spawn(MutationEmitters[2], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Cyan")
				MonsterEffect = Spawn(MutationEmitters[3], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "White")
				MonsterEffect = Spawn(MutationEmitters[0], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Black")
				MonsterEffect = Spawn(MutationEmitters[1], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Rainbow")
				MonsterEffect = Spawn(MutationEmitters[8], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationSpeedColour ~= "Random")
			{
				i = Rand(11);
				MonsterEffect = Spawn(MutationEmitters[i], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			}
			else
				MonsterEffect = None;

			if(MonsterEffect != None)
			{
				MonsterEffect.SetBase(LuckyMonster);
			}
		}
	}

	InfectedMonsterCount = 0;
	SetTimer(1.00,true);

	Super.GiveTo(Other);
}

function Timer()
{
	local Monster M;
	local float decision;

	if(LuckyMonster == None)
	{
		Destroy();
	}
	else if(MyRI != None && ItemName != "Infected")
	{
		decision = fRand();

		if(decision < MyRI.InfectChance && InfectedMonsterCount != MyRI.InfectLimit)
		{
			foreach RadiusActors(class'Monster', M, 50, LuckyMonster.Location)
			{
				if(M != None && M != LuckyMonster &&  Mut != None && InfectedMonsterCount != MyRI.InfectLimit)
				{
					if(Mut.ApplyMutation(M, 1, 1) == true)
					{
						InfectedMonsterCount++;
					}
				}
			}
		}
	}
}

simulated function Destroyed()
{
	if(MonsterEffect != None)
	{
		MonsterEffect.Destroy();
	}
	super.Destroyed();
}

defaultproperties
{
     MutationEmitters(0)=Class'MonsterMutationsv5.MutationEmitter'
     MutationEmitters(1)=Class'MonsterMutationsv5.MutationEmitterBlack'
     MutationEmitters(2)=Class'MonsterMutationsv5.MutationEmitterBlue'
     MutationEmitters(3)=Class'MonsterMutationsv5.MutationEmitterCyan'
     MutationEmitters(4)=Class'MonsterMutationsv5.MutationEmitterGreen'
     MutationEmitters(5)=Class'MonsterMutationsv5.MutationEmitterOrange'
     MutationEmitters(6)=Class'MonsterMutationsv5.MutationEmitterPink'
     MutationEmitters(7)=Class'MonsterMutationsv5.MutationEmitterPurple'
     MutationEmitters(8)=Class'MonsterMutationsv5.MutationEmitterRainbow'
     MutationEmitters(9)=Class'MonsterMutationsv5.MutationEmitterRed'
     MutationEmitters(10)=Class'MonsterMutationsv5.MutationEmitterYellow'
     ItemName="Mutation"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
     bReplicateInstigator=True
}
