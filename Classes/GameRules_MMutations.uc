//=============================================================================
// GameRules_MMutations.uc
// Copyright (C) 2021 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class GameRules_MMutations extends GameRules;

function int NetDamage(int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
    local int DamageRV;

    DamageRV = Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

    if(
        DamageRV > 0
        && Monster(injured) != None
        && injured.ShieldStrength > 0
        && DamageType.default.bArmorStops
    )
    {
        Spawn(class'FX_MonsterShieldHit',,, HitLocation);
    }

    return DamageRV;
}

defaultproperties
{
}
