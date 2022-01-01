//=============================================================================
// Mutation_Shield.uc
// Copyright (C) 2022 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class Mutation_Shield extends Mutation config(MMutations);

var config int ShieldMin;
var config int ShieldMax;

function ApplyMutation()
{
    local int NewShield;

    NewShield = RandRange(ShieldMin, ShieldMax);

    Instigator.ShieldStrength += NewShield;
    Monster(Instigator).ShieldStrengthMax += NewShield;
}

defaultproperties
{
    ShieldMin=50
    ShieldMax=250
}
