Class FX_MutationBlue extends FX_Mutation;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         UniformSize=True
         UseRandomSubdivision=True
         UseVelocityScale=True
         ColorScale(1)=(Color=(B=255,G=255,R=255))
         ColorScale(2)=(Color=(B=255,G=255,R=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=2.000000,Y=2.000000,Z=2.000000))
         VelocityScale(1)=(RelativeTime=0.400000)
         VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(X=10.000000,Y=5.000000,Z=5.000000))
         WarmupTicksPerSecond=3.000000
         RelativeWarmupTime=0.400000
     End Object
     Emitters(0)=SpriteEmitter'FX_MutationBlue.SpriteEmitter0'

}
