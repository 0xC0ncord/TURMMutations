Class MutMMutations extends Mutator config(MMutations);

var() config array<string> MutationList;
var config bool bCanInfectOtherMonsters;
var config float InfectChance;
var config int InfectLimit;
var config bool bAllowMutationStacking;
var config float MaxMutationTime;
var config array<string> TeleportExcludeMonster;
var config array<string> ExcludeMonster;
var() config array<int> IgnoreWave;
var config bool bAffectBosses;
var config bool bTeleportAffectBosses;
var Invasion InvGame;

var array<class<Mutation> > Mutations;
var array<class<Monster> > ExcludedMonsters;
var array<class<Monster> > TeleportExcludedMonsters;

function PostBeginPlay()
{
    local int i;
    local class<Mutation> Mut;
    local class<Monster> M;

    InvGame = Invasion(Level.Game);

    for(i = 0; i < MutationList.Length; i++)
    {
        if(InStr(MutationList[i], ".") == -1)
            Mut = class<Mutation>(DynamicLoadObject(Left(string(Class), InStr(string(Class), ".")) $ "." $ MutationList[i], class'Class'));
        else
            Mut = class<Mutation>(DynamicLoadObject(MutationList[i], class'Class'));
        if(Mut != None)
            Mutations[Mutations.Length] = Mut;
    }

    for(i = 0; i < ExcludedMonsters.Length; i++)
    {
        M = class<Monster>(DynamicLoadObject(ExcludeMonster[i], class'Class'));
        if(M != None)
            ExcludedMonsters[ExcludedMonsters.Length] = M;
    }

    for(i = 0; i < TeleportExcludedMonsters.Length; i++)
    {
        M = class<Monster>(DynamicLoadObject(TeleportExcludeMonster[i], class'Class'));
        if(M != None)
            TeleportExcludedMonsters[TeleportExcludedMonsters.Length] = M;
    }

    SetTimer(RandRange(1.00, MaxMutationTime), true);
}

function Timer()
{
    local int Wave;
    local Controller C;
    local array<Monster> MonsterList;

    if(InvGame != None)
    {
        for(Wave = 0; Wave < IgnoreWave.Length; Wave++)
        {
            if(InvGame.WaveNum + 1 == IgnoreWave[Wave])
            {
                SetTimer(1.00, true);
                return;
            }
        }
    }
    for(C = Level.ControllerList; C != None; C = C.NextController)
    {
        if(
            Monster(C.Pawn) != None
            && C.Pawn.Health > 0
            && PlayerController(C) == None
            && !C.IsA('FriendlyMonsterController')
            && !(!bAffectBosses && Monster(C.Pawn).bBoss)
        )
        {
            MonsterList[MonsterList.Length] = Monster(C.Pawn);
        }
    }

    if(MonsterList.Length > 0)
        ApplyMutation(MonsterList[Rand(MonsterList.Length)]);

    SetTimer(RandRange(1.00, MaxMutationTime), true);
}

function bool ApplyMutation(Monster LuckyMonster, optional bool bInfection)
{
    local Inventory Inv, NewInv;
    local class<Inventory> MInv;
    local int i;

    MInv = Mutations[Rand(Mutations.Length)];
    for(Inv = LuckyMonster.Inventory; Inv != None; Inv = Inv.Inventory)
    {
        if(
            (Mutation(Inv) != None && !bAllowMutationStacking)
            || (Inv.Class == MInv)
        )
        {
            // stacking not allowed or monster
            // already has this mutation
            if(!bInfection)
                SetTimer(1.0, true);
            return false;
        }
    }

    for(i = 0; i < ExcludedMonsters.Length; i++)
    {
        if(LuckyMonster.Class == ExcludedMonsters[i])
        {
            // monster is excluded from being mutated
            if(!bInfection)
                SetTimer(1.0, true);
            return false;
        }
    }

    NewInv = Spawn(MInv, LuckyMonster);
    if(NewInv == None)
        return false;

    Mutation(NewInv).Mut = Self;

    if(
        (LuckyMonster.bSimulateGravity == false && Mutation_Speed(NewInv) != None)
        || (bTeleportAffectBosses == false && Mutation_Teleport(NewInv) != None && LuckyMonster.bBoss == true)
    )
    {
        // monster is not applicable for speed or is
        // a boss and we dont allow mutations on them
        if(!bInfection)
            SetTimer(1.0, true);
        return false;
    }
    else if(Mutation_Teleport(NewInv) != None)
    {
        for(i = 0; i < TeleportExcludedMonsters.Length; i++)
        {
            if(LuckyMonster.Class == TeleportExcludedMonsters[i])
            {
                // monster is not allowed to have teleport
                if(!bInfection)
                    SetTimer(1.0, true);
                return false;
            }
        }
    }
    if(NewInv != None)
    {
        NewInv.GiveTo(LuckyMonster);
        return true;
    }
}

defaultproperties
{
     MutationList(0)="Mutation_Invis"
     MutationList(1)="Mutation_Regen"
     MutationList(2)="Mutation_Teleport"
     MutationList(3)="Mutation_Health"
     MutationList(4)="Mutation_Speed"
     bCanInfectOtherMonsters=True
     bAllowMutationStacking=True
     InfectChance=0.200000
     InfectLimit=3
     MaxMutationTime=10.000000
     bAddToServerPackages=True
     GroupName="Monster Mutations"
     FriendlyName=".:TUR:. Monster Mutations"
     Description="Randomly mutates monsters to spice things up. Based on MonsterMutations v5 by Ini."
}
