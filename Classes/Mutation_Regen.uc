class Mutation_Regen extends Mutation config(MMutations);

var config int RegenPerSecond;

var float NextEffectTime;

function BeginPlay()
{
    NextEffectTime = Level.TimeSeconds + 1;
}

function Tick(float dt)
{
    if(NextEffectTime <= Level.TimeSeconds)
    {
        NextEffectTime = Level.TimeSeconds + 1;
        Instigator.GiveHealth(RegenPerSecond, Instigator.HealthMax);
    }
}

defaultproperties
{
    RegenPerSecond=10
    MutationColor=MC_Green
}
