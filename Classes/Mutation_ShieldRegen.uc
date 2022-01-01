//=============================================================================
// Mutation_ShieldRegen.uc
// Copyright (C) 2022 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class Mutation_ShieldRegen extends Mutation_Regen config(MMutations);

function Tick(float dt)
{
    if(
        NextEffectTime <= Level.TimeSeconds
        && Instigator.ShieldStrength < Monster(Instigator).ShieldStrengthMax
    )
    {
        NextEffectTime = Level.TimeSeconds + 1;
        Instigator.ShieldStrength = Min(
            Instigator.ShieldStrength + RegenPerSecond,
            Monster(Instigator).ShieldStrengthMax);
    }
}

defaultproperties
{
    RegenPerSecond=10
    MutationColor=MC_Orange
}
