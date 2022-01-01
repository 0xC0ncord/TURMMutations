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
    MutationColor=MC_White
}
