class FX_MutationTeleport extends Emitter;

#EXEC AUDIO IMPORT NAME=MutationTeleport FILE=Sounds\MutationTeleport.wav

simulated function PostNetBeginPlay()
{
    if(Level.NetMode != NM_DedicatedServer)
        PlaySound(Sound'MutationTeleport', SLOT_Interact, 2.5 * TransientSoundVolume, true, 2000);
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Right
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(RelativeTime=0.100000,Color=(B=55,G=70,R=200))
         ColorScale(1)=(RelativeTime=0.200000,Color=(G=255,R=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=255,G=128,R=255))
         ColorScale(3)=(RelativeTime=0.400000,Color=(G=255))
         ColorScale(4)=(RelativeTime=0.500000,Color=(G=128,R=255))
         ColorScale(5)=(RelativeTime=0.600000,Color=(B=255,R=128))
         ColorScale(6)=(RelativeTime=0.700000,Color=(B=255))
         MaxParticles=20
         StartLocationRange=(Z=(Min=-20.000000,Max=20.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=10.000000,Max=10.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=8.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=2.000000,Max=3.000000))
         ScaleSizeByVelocityMultiplier=(X=0.005000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(Z=(Min=5.000000,Max=8.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.200000,RelativeVelocity=(X=5.000000,Y=5.000000,Z=5.000000))
         VelocityScale(2)=(RelativeTime=0.400000,RelativeVelocity=(X=20.000000,Y=20.000000,Z=20.000000))
         VelocityScale(3)=(RelativeTime=1.000000,RelativeVelocity=(X=200.000000,Y=200.000000,Z=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'FX_MutationTeleport.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
     bNotOnDedServer=False
     bSkipActorPropertyReplication=True
     bNetTemporary=True
}
