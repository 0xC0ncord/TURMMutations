//=============================================================================
// Mutation_Health.uc
// Copyright (C) 2021 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class Mutation_Health extends Mutation config(MMutations);

var config int HealthMin;
var config int HealthMax;

function ApplyMutation()
{
    local int NewHealth;

    NewHealth = RandRange(HealthMin, HealthMax);

    Instigator.Health += NewHealth;
    Instigator.HealthMax += NewHealth;
    Instigator.SuperHealthMax += NewHealth;
}

defaultproperties
{
    HealthMin=150
    HealthMax=500
    MutationColor=MC_Red
}
