class Mutation_Teleport extends Mutation config(MMutations);

var config int TeleportDistance;
var config int TeleportIntervalMin;
var config int TeleportIntervalMax;

var float NextEffectTime;

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    if(!Other.bSimulateGravity || !Other.bMovable)
    {
        Destroy();
        return;
    }

    Super.GiveTo(Other);
}

function Tick(float dt)
{
    local vector OldLocation, TryLocation;
    local vector HitLocation, HitNormal;

    if(NextEffectTime > Level.TimeSeconds)
        return;

    if(Instigator.Controller != None && Instigator.Controller.Target != None)
    {
        if(VSize(Instigator.Location - Instigator.Controller.Target.Location) > TeleportDistance)
        {
            OldLocation = Instigator.Location;

            // teleport the monster somewhere immediately near its enemy,
            // with enough distance between then
            TryLocation = Instigator.Controller.Target.Location + (Normal(vector(RotRand())) * vect(1, 1, 0)) * (Instigator.Controller.Target.CollisionRadius + Instigator.CollisionRadius + 50);

            // if enemy is on ground, try and put monster on ground too
            if(Instigator.Controller.Target.Physics == PHYS_Walking)
            {
                Trace(HitLocation, HitNormal, TryLocation - vect(0, 0, 1) * Instigator.CollisionHeight, TryLocation);

                if(HitLocation != vect(0, 0, 0))
                    TryLocation = HitLocation + vect(0, 0, 1) * Instigator.CollisionHeight;
            }

            if(Instigator.SetLocation(TryLocation))
            {
                Spawn(class'FX_MutationTeleport', Instigator,, OldLocation, Instigator.Rotation);
                Spawn(class'FX_MutationTeleport', Instigator,, Instigator.Location, Instigator.Rotation);

                // make the monster face its enemy
                Instigator.SetRotation(rotator(Instigator.Controller.Target.Location - Instigator.Location * vect(1, 1, 0)));

                NextEffectTime = Level.TimeSeconds + RandRange(TeleportIntervalMin, TeleportIntervalMax);
            }
        }
    }
}

defaultproperties
{
    TeleportDistance=700
    TeleportIntervalMin=5
    TeleportIntervalMax=10
    MutationColor=MC_Purple
}
