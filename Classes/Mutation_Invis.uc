//=============================================================================
// Mutation_Invis.uc
// Copyright (C) 2021 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class Mutation_Invis extends Mutation;

simulated function ApplyMutation()
{
    local int i;

    Monster(Instigator).bInvis = true;

    for(i = 0; i < Instigator.Skins.Length; i++)
    {
        Instigator.Skins[i] = Monster(Instigator).InvisMaterial;
    }

    if(Instigator.IsA('BarnacleINI'))
    {
        Instigator.SetOverlayMaterial(Monster(Instigator).InvisMaterial, 86400, true);
    }
}

defaultproperties
{
}
