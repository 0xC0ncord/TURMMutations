Class FX_Mutation extends Emitter;

simulated function PostNetBeginPlay()
{
    local Rotator NewRot;

    if(Owner != None)
    {
        Emitters[0].StartSizeRange.X.Max += (Owner.CollisionHeight / 10);
        Emitters[0].StartSizeRange.X.Min += (Owner.CollisionHeight / 10);
        Emitters[0].SphereRadiusRange.Min += (Owner.CollisionHeight / 10);
        Emitters[0].SphereRadiusRange.Max += (Owner.CollisionHeight / 10);
        Emitters[0].StartLocationShape = PTLS_Sphere;
        Emitters[0].VelocityScale[2].RelativeVelocity.Z = 15.000000;
        Emitters[0].StartVelocityRange.Z.Min = 0;

        if(Owner.IsA('Barnacle') || Owner.IsA('Tentacle'))
        {
            NewRot.Pitch = -16500;
            SetRotation(default.Rotation + NewRot);
            Emitters[0].VelocityScale[1].RelativeTime = 0.900000;
        }
    }
    else
    {
        Destroy();
    }
}

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
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=30.000000,Max=30.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=2.000000,Y=2.000000,Z=2.000000))
         VelocityScale(1)=(RelativeTime=0.400000)
         VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(Z=15.000000))
         WarmupTicksPerSecond=3.000000
         RelativeWarmupTime=0.400000
     End Object
     Emitters(0)=SpriteEmitter'FX_Mutation.SpriteEmitter0'

     bNoDelete=False
     Physics=PHYS_Trailer
     bTrailerAllowRotation=True
}
