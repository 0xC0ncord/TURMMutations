class Mutation_Speed extends Mutation config(MMutations);

var config float SpeedMultiplierMin;
var config float SpeedMultiplierMax;

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    if(!Other.bSimulateGravity)
    {
        Destroy();
        return;
    }

    Super.GiveTo(Other);
}

function ApplyMutation()
{
    local float Factor;

    Factor = 1.0 + RandRange(SpeedMultiplierMin, SpeedMultiplierMax);

    Instigator.GroundSpeed *= Factor;
    Instigator.WaterSpeed *= Factor;
    Instigator.AirSpeed *= Factor;
    Instigator.JumpZ *= Factor;
}

defaultproperties
{
    SpeedMultiplierMin=0.35
    SpeedMultiplierMax=0.75
    MutationColor=MC_Yellow
}
