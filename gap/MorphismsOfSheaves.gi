#############################################################################
##
##  SheafMap.gi                                             Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsMorphismOfCoherentSheavesOnProjRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsMorphismOfCoherentSheavesOnProjRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of maps between coherent sheaves on a projective scheme modelled by a map between graded modules. <P/>
##      (It is a representation of the &GAP; categories <C>IsMorphismOfSheavesOfModules</C>,
##       and <C>IsStaticMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsMorphismOfCoherentSheavesOnProjRep",
        IsMorphismOfSheavesOfModules and
        IsStaticMorphismOfFinitelyGeneratedObjectsRep,
        [ ] );

####################################
#
# global variables:
#
####################################

HOMALG_SHEAVES.FunctorOn :=
  [ IsSheafOfRingsOrSheafOnSchemeRep,
    IsMorphismOfCoherentSheavesOnProjRep,
    [ IsComplexOfFinitelyPresentedObjectsRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
    [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsCochainMorphismOfFinitelyPresentedObjectsRep ] ];

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgSheafMorphisms",
        NewFamily( "TheFamilyOfHomalgSheafMorphisms" ) );

# four new types:
BindGlobal( "TheTypeMorphismOfCoherentLeftSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeMorphismOfCoherentRightSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeEndomorphismOfCoherentLeftSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgEndomorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeEndomorphismOfCoherentRightSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgEndomorphism and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( SheafVersionOfMorphismAid,
        "for graded maps",
        [ IsHomalgGradedMap, IsCoherentSheafOnProjRep ],
        
  function( phi, range )
    local aid;
    
    if not HasMorphismAid( phi ) then
        Error( "expected the morphism to have an aid" );
    fi;
    
    aid := phi!.MorphismAid;
    
    if IsHomalgGradedMap( aid ) then
        return SheafMorphism( aid, "create", range );
    elif IsList( aid ) and Length( aid ) = 1 and IsHomalgGradedMap( aid[1] ) then
        return [ SheafMorphism( aid[1], range, "create" ) ];
    else
        Error( "unexpected data structure for the aid" );
    fi;
    
end );

##
InstallMethod( UpdateObjectsByMorphism,
        "for graded maps",
        [ IsMorphismOfCoherentSheavesOnProjRep and IsIsomorphism ],
        
  function( phi )
    
    UpdateObjectsByMorphism( UnderlyingGradedMap( phi ) );
    
    MatchPropertiesAndAttributes( Source( phi ), Range( phi ), LISHV.intrinsic_properties, LISHV.intrinsic_attributes );
    
end );

##
InstallMethod( PairOfPositionsOfTheDefaultPresentations,
        "for morphisms of coherent sheaves on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultPresentation( Source( phi ) );
    pos_t := PositionOfTheDefaultPresentation( Range( phi ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        return [ pos_s, pos_t ];
    else
        return [ pos_t, pos_s ];
    fi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep, IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( F, psi )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedModule( F ) ), HomalgRing( UnderlyingGradedMap( psi ) ) ) then
            Error( "the rings of the underlying graded (sub)module and map of graded modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( F ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( F ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( psi ) ) ) then
            Error( "the (sub)sheaf and morphism of sheaves must either be both in the category of left or right sheaves\n" );
        fi;
    fi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( phi, G )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedMap( phi ) ), HomalgRing( UnderlyingGradedModule( G ) ) ) then
            Error( "the rings of the underlying graded (sub)module and map of graded modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( G ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( G ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( phi ) ) ) then
            Error( "the (sub)sheaf and morphism of sheaves must either be both in the category of left or right sheaves\n" );
        fi;
    fi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi, psi )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedMap( phi ) ), HomalgRing( UnderlyingGradedMap( psi ) ) ) then
            Error( "the rings of the underlying maps of graded modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( psi ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( phi ) ) ) then
            Error( "the morphisms of sheaves must either be both in the category of left or right sheaves\n" );
        fi;
    fi;
    
end );

##
InstallMethod( homalgResetFilters,
        "for homalg maps",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( cm )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfMaps ) then
        HOMALG.PropertiesOfMaps :=
          [ IsZero,
            IsMorphism,
            IsGeneralizedMorphismWithFullDomain,
            IsSplitMonomorphism,
            IsMonomorphism,
            IsGeneralizedMonomorphism,
            IsSplitEpimorphism,
            IsEpimorphism,
            IsGeneralizedEpimorphism,
            IsIsomorphism,
            IsGeneralizedIsomorphism ];
    fi;
    
    for property in HOMALG.PropertiesOfMaps do
        ResetFilterObj( cm, property );
    od;
    
end );

##
InstallMethod( UnderlyingGradedMap,
        "for sheaves",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    if HasTruncatedModuleOfGlobalSections( phi ) then;
        return TruncatedModuleOfGlobalSections( phi );
    fi;
    
    return phi!.GradedModuleMapModelingTheSheaf;
    
end );

##
InstallMethod( PushPresentationByIsomorphism,
        "for homalg maps",
        [ IsMorphismOfCoherentSheavesOnProjRep and IsIsomorphism ],
        
  function( phi )
    
    #!!!!!!!! this is wrong in general !!!!!!!!!
#     if not HasTruncatedModuleOfGlobalSections( phi ) then
#         Error( "this method only works when the map is given between the truncated modules of global sections" );
#     fi;
    
    SetIsIsomorphism( UnderlyingGradedMap( phi ), true );
    
    PushPresentationByIsomorphism( UnderlyingGradedMap( phi ) );
    
    UpdateObjectsByMorphism( phi );
    
    return Range( phi );
    
end );

####################################
#
# constructors
#
####################################

InstallMethod( SheafMorphism,
        "For graded morphisms",
        [ IsHomalgGradedMap, IsString, IsObject ],
  function( phi, s, B )
    
    if s = "create" then
        return SheafMorphism( phi, Proj( Source( phi ) ), B );
    else
        Error( "unknown string ", s );
    fi;
    
end );

InstallMethod( SheafMorphism,
        "For graded morphisms",
        [ IsHomalgGradedMap, IsObject, IsString ],
  function( phi, A, s )
    
    if s = "create" then
        return SheafMorphism( phi, A, Proj( Range( phi ) ) );
    else
        Error( "unknown string ", s );
    fi;
    
end );

InstallMethod( SheafMorphism,
        "For graded morphisms",
        [ IsHomalgGradedMap, IsCoherentSheafOnProjRep, IsCoherentSheafOnProjRep ],
  function( phi, F, G )
    local i, M, source, target, type, morphism;
    
    for i in F!.ListOfKnownUnderlyingModules do
        M := F!.SetOfUnderlyingModules!.(i);
#         if CheckHasTruncatedModuleOfGlobalSections( F, M ) and 
#            IsIdenticalObj( F!.SetOfUnderlyingModules!.(F!.ListOfKnownUnderlyingModules[Length(F!.ListOfKnownUnderlyingModules)]), Source( phi ) )then
#             source := F!.ListOfKnownUnderlyingModules[Length(F!.ListOfKnownUnderlyingModules)];
#             break;
#         fi;
        if IsIdenticalObj( M, Source( phi ) ) then
            source := i;
            break;
        fi;
    od;
    for i in G!.ListOfKnownUnderlyingModules do
        M := G!.SetOfUnderlyingModules!.(i);
#         if CheckHasTruncatedModuleOfGlobalSections( G, M ) and 
#            IsIdenticalObj( G!.SetOfUnderlyingModules!.(G!.ListOfKnownUnderlyingModules[Length(G!.ListOfKnownUnderlyingModules)]), Range( phi ) )then
#             target := G!.ListOfKnownUnderlyingModules[Length(G!.ListOfKnownUnderlyingModules)];
#             break;
#         fi;
        if IsIdenticalObj( M, Range( phi ) ) then
            target := i;
            break;
        fi;
    od;
    
    if not IsBound( source ) then
        Error( "the underlying graded modules for the source and second parameter do not match" );
    fi;
    if not IsBound( target ) then
        Error( "the underlying graded modules for the range and third parameter do not match" );
    fi;

    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        if IsIdenticalObj( F, G ) then
            type := TheTypeEndomorphismOfCoherentLeftSheavesOnProj;
        else
            type := TheTypeMorphismOfCoherentLeftSheavesOnProj;
        fi;
    else
        if IsIdenticalObj( F, G ) then
            type := TheTypeEndomorphismOfCoherentRightSheavesOnProj;
        else
            type := TheTypeMorphismOfCoherentRightSheavesOnProj;
        fi;
    fi;

    morphism := rec( GradedModuleMapModelingTheSheaf := phi );
    
    ## Objectify:
    ObjectifyWithAttributes(
        morphism, type,
        Source, F,
        Range, G
    );
    
    if HasMorphismAid( phi ) then
       
       SetMorphismAid( morphism, SheafVersionOfMorphismAid( phi, G ) );
       
    fi;
    
    return morphism;
    
end );

InstallMethod( SheafZeroMorphism,
        "For graded modules",
        [ IsCoherentSheafOnProjRep, IsCoherentSheafOnProjRep ],
  function( F, G )
  
    return SheafMorphism( GradedZeroMap( UnderlyingGradedModule( F ), UnderlyingGradedModule( G ) ), F, G );
  
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for morphisms of coherent sheaves on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep ], ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( o )
    
    Display( UnderlyingGradedMap( o ) );
    
    Print( "the morphism of coherent sheaves on the projective space is given by the above graded map\n" );
    
end );

