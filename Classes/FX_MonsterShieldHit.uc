//=============================================================================
// FX_MonsterShieldHit.uc
// Copyright (C) 2021 0xC0ncord <concord@fuwafuwatime.moe>
//
// This program is free software; you can redistribute and/or modify
// it under the terms of the Open Unreal Mod License version 1.1.
//=============================================================================

class FX_MonsterShieldHit extends Emitter;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorMultiplierRange=(Z=(Min=0.400000,Max=0.600000))
        FadeOutStartTime=0.100000
        FadeInEndTime=0.050000
        MaxParticles=1
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=10.000000,Max=12.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(0)=SpriteEmitter'FX_MonsterShieldHit.SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Up
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UniformSize=True
        ScaleSizeYByVelocity=True
        AutomaticInitialSpawning=False
        ColorMultiplierRange=(Z=(Min=0.300000,Max=0.600000))
        FadeOutStartTime=0.100000
        FadeInEndTime=0.050000
        MaxParticles=3
        StartSizeRange=(X=(Min=3.000000,Max=4.000000))
        ScaleSizeByVelocityMultiplier=(Y=0.060000)
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Particles.Energy.SparkHead'
        LifetimeRange=(Min=0.200000,Max=0.250000)
        StartVelocityRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000),Z=(Min=-128.000000,Max=128.000000))
    End Object
    Emitters(1)=SpriteEmitter'FX_MonsterShieldHit.SpriteEmitter1'

    AutoDestroy=True
    bNoDelete=False
    bNotOnDedServer=False
    RemoteRole=ROLE_DumbProxy
    bSkipActorPropertyReplication=True
}
