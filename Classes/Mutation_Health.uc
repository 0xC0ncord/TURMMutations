class Mutation_Health extends Mutation config(MMutations);

var config int HealthMin;
var config int HealthMax;

function ApplyMutation()
{
    local int NewHealth;

    NewHealth = RandRange(HealthMin, HealthMax);

    Instigator.Health += NewHealth;
    Instigator.HealthMax += NewHealth;
    Instigator.SuperHealthMax += NewHealth;
}

defaultproperties
{
    HealthMin=150
    HealthMax=500
    MutationColor=MC_Red
}
