class MutationInvis extends Inventory;

var Monster LuckyMonster;
var MutMMutations Mut;
var	MutationReplicationInfo MyRI;
var int InfectedMonsterCount;

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	local MutMMutations M;
	local MutationReplicationInfo RI;
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
		}
	}

	LuckyMonster.bInvis = true;

	if(LuckyMonster.Mesh.IsA('VertMesh'))
	{
		for(i=0;i<LuckyMonster.Skins.Length;i++)
		{
			LuckyMonster.Skins[i] = LuckyMonster.InvisMaterial;
		}
	}

	if(LuckyMonster.IsA('BarnacleINI'))
	{
		LuckyMonster.SetOverlayMaterial(LuckyMonster.InvisMaterial, 999, true);
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

defaultproperties
{
     ItemName="Mutation"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
     bReplicateInstigator=True
}
