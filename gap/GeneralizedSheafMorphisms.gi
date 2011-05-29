
##
InstallMethod( TruncatedModuleOfGlobalSections,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep and HasMorphismAid ],
        
  function( phi )
    local psi;
    
    TruncatedModuleOfGlobalSections( MorphismAid( phi ) );
    
    if IsIdenticalObj( Range( UnderlyingGradedMap( phi ) ), TruncatedModuleOfGlobalSections( Range( phi ) ) ) then
        psi := UnderlyingGradedMap( phi );
    else
        psi := UnderlyingGradedMap( phi );
        psi := PreCompose( psi, NaturalMapToModuleOfGlobalSections( Range( psi ) ) );
    fi;
    
    SetTruncatedModuleOfGlobalSections( phi, psi );
    
    return psi;
    
end );

##
InstallMethod( GeneralizedMorphism,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local  psi;
    
    if not IsMorphismOfCoherentSheavesOnProjRep( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## prepare a copy of phi
    psi := GeneralizedMorphism( UnderlyingGradedMap( phi ), UnderlyingGradedMap( morphism_aid_map ) );
    psi := SheafMorphism( psi, Source( phi ), Range( phi ) );
    
    ## some properties of the morphism phi imply
    ## properties for the generalized morphism psi
    SetPropertiesOfGeneralizedMorphism( psi, phi );
    
    return psi;
    
end );
##
InstallMethod( RemoveMorphismAid,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local morphism, psi;
    
    if ( not HasMorphismAid( phi ) or ( HasIsZero( MorphismAid( phi ) ) and IsZero( MorphismAid( phi ) ) )
       and HasIsGeneralizedMorphism( phi ) and IsGeneralizedMorphism( phi ) )
       then
        morphism := true;
    fi;
    
    psi := RemoveMorphismAid( UnderlyingGradedMap( phi ) );
    psi := SheafMorphism( psi, Source( phi ), Range( phi ) );
    
    if IsBound( morphism ) then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( OnALocallyFreeSource,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local psi;
    
    psi := SheafMorphism( OnAFreeSource( UnderlyingGradedMap( phi ) ), "create", Range( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) or HasIsGeneralizedMorphism( phi ) and IsGeneralizedMorphism( phi ) then
        Assert( 1, IsMorphism( psi ) );
        SetIsMorphism( psi, true );
    fi;
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        Assert( 1, IsEpimorphism( psi ) );
        SetIsEpimorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( AddToMorphismAid,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, morphism_aid_map0;
    
    if not IsMorphismOfCoherentSheavesOnProjRep( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the new morphism aid map
    morphism_aid_map1 := OnALocallyFreeSource( morphism_aid_map );
    
    if HasMorphismAid( phi ) then
        ## we don't need the source of the old morphism aid map
        morphism_aid_map0 := OnALocallyFreeSource( MorphismAid( phi ) );
        morphism_aid_map1 := CoproductMorphism( morphism_aid_map0, morphism_aid_map1 );
    fi;
    
    return GeneralizedMorphism( phi, morphism_aid_map1 );
    
end );
