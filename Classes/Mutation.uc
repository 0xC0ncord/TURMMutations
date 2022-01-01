//=============================================================================
// Mutation.uc
// Copyright (C) 2021 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class Mutation extends Inventory;

var enum EMutationColor
{
    MC_None,
    MC_Random,
    MC_Black,
    MC_Blue,
    MC_Cyan,
    MC_Green,
    MC_Orange,
    MC_Pink,
    MC_Purple,
    MC_Rainbow,
    MC_Red,
    MC_Yellow,
    MC_White,
} MutationColor;

var class<FX_Mutation> EffectClass;
var FX_Mutation MonsterEffect;
var int InfectedMonsterCount;
var MutMMutations Mut;
var class<FX_Mutation> MutationEmitters[11];

replication
{
    reliable if(Role == ROLE_Authority && bNetInitial)
        EffectClass;
}

function PostBeginPlay()
{
    if(MutationColor == MC_Random)
        EffectClass = MutationEmitters[Rand(MutationColor - 2) + 2];
    else if(MutationColor != MC_None)
        EffectClass = MutationEmitters[MutationColor - 2];
}

simulated function PostNetBeginPlay()
{
    if(Level.NetMode == NM_DedicatedServer || Instigator == None)
        return;

    CreateEffect();

    ApplyMutation();
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    if(Mut == None)
    {
        Destroy();
        return;
    }

    Super.GiveTo(Other);

#ifdef __DEBUG__
    PRINTD("New mutation" @ Name @ "on" @ Other.Name);
#endif

    if(Level.NetMode != NM_DedicatedServer)
        CreateEffect();

    ApplyMutation();

    if(Mut.bCanInfectOtherMonsters && ItemName != "Infected")
        SetTimer(1.00, true);
}

simulated function CreateEffect()
{
    if(EffectClass != None)
    {
        MonsterEffect = Spawn(
            EffectClass,
            Instigator,
            ,
            Instigator.Location,
            Instigator.Rotation);
    }
}

simulated function ApplyMutation();

function Timer()
{
    local Monster M;

    if(Instigator == None)
    {
        Destroy();
        return;
    }

    if(FRand() <= Mut.InfectChance && InfectedMonsterCount < Mut.InfectLimit)
    {
        foreach CollidingActors(class'Monster', M, 50, Instigator.Location)
        {
            if(
                M != None
                && M != Instigator
                && PlayerController(M.Controller) == None
                && !M.Controller.IsA('FriendlyMonsterController')
                && !(!Mut.bAffectBosses && M.bBoss)
            )
            {
#ifdef __DEBUG__
                PRINTD(Name @ "trying to infect" @ M.Name);
#endif
                if(Mut.ApplyMutation(M, true))
                {
                    InfectedMonsterCount++;
                }
            }
        }
    }
}

simulated function Destroyed()
{
    if(MonsterEffect != None)
        MonsterEffect.Destroy();

    Super.Destroyed();
}

defaultproperties
{
     MutationEmitters(0)=Class'FX_MutationBlack'
     MutationEmitters(1)=Class'FX_MutationBlue'
     MutationEmitters(2)=Class'FX_MutationCyan'
     MutationEmitters(3)=Class'FX_MutationGreen'
     MutationEmitters(4)=Class'FX_MutationOrange'
     MutationEmitters(5)=Class'FX_MutationPink'
     MutationEmitters(6)=Class'FX_MutationPurple'
     MutationEmitters(7)=Class'FX_MutationRainbow'
     MutationEmitters(8)=Class'FX_MutationRed'
     MutationEmitters(9)=Class'FX_MutationYellow'
     MutationEmitters(10)=Class'FX_MutationWhite'
     ItemName="Mutation"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
     bReplicateInstigator=True
     bNetTemporary=True
}
