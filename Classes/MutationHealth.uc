class MutationHealth extends Inventory;

var MutationEmitter MonsterEffect;
var Monster LuckyMonster;
var	MutationReplicationInfo MyRI;
var int InfectedMonsterCount;
var MutMMutations Mut;
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
			LuckyMonster.Health = RandRange(MyRI.MutationHealthMin,MyRI.MutationHealthMax);
			if(MyRI.MutationHealthColour ~= "Red")
				MonsterEffect = Spawn(MutationEmitters[9], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Yellow")
				MonsterEffect = Spawn(MutationEmitters[10], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Pink")
				MonsterEffect = Spawn(MutationEmitters[6], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Green")
				MonsterEffect = Spawn(MutationEmitters[4], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Orange")
				MonsterEffect = Spawn(MutationEmitters[5], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Purple")
				MonsterEffect = Spawn(MutationEmitters[7], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Blue")
				MonsterEffect = Spawn(MutationEmitters[2], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Cyan")
				MonsterEffect = Spawn(MutationEmitters[3], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "White")
				MonsterEffect = Spawn(MutationEmitters[0], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Black")
				MonsterEffect = Spawn(MutationEmitters[1], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Rainbow")
				MonsterEffect = Spawn(MutationEmitters[8], LuckyMonster,, LuckyMonster.Location, LuckyMonster.Rotation);
			else if(MyRI.MutationHealthColour ~= "Random")
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

			InfectedMonsterCount = 0;
			SetTimer(1.00,true);
		}
	}

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
				if(M != None && M != LuckyMonster && Mut != None && InfectedMonsterCount != MyRI.InfectLimit)
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
