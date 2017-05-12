#############################################################################
##
##  read.g                Sheaves package                    Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Reading the implementation part of the Sheaves package.
##
#############################################################################

##
ReadPackage( "Sheaves", "gap/LinearSystems.gi" );

##
ReadPackage( "Sheaves", "gap/Sheaves.gi" );

##
ReadPackage( "Sheaves", "gap/MorphismsOfSheaves.gi" );

##
ReadPackage( "Sheaves", "gap/GeneralizedSheafMorphisms.gi" );

##
ReadPackage( "Sheaves", "gap/Subsheaves.gi" );

##
ReadPackage( "Sheaves", "gap/Schemes.gi" );

##
ReadPackage( "Sheaves", "gap/Divisors.gi" );

##
ReadPackage( "Sheaves", "gap/MorphismsOfSchemes.gi" );

##
ReadPackage( "Sheaves", "gap/Curves.gi" );

##
ReadPackage( "Sheaves", "gap/Tate.gi" );

##
ReadPackage( "Sheaves", "gap/LILIN.gi" );

##
ReadPackage( "Sheaves", "gap/LISHV.gi" );

##
ReadPackage( "Sheaves", "gap/LISHVMOR.gi" );

##
ReadPackage( "Sheaves", "gap/LISCM.gi" );

##
ReadPackage( "Sheaves", "gap/LIDIV.gi" );

##
ReadPackage( "Sheaves", "gap/UnderlyingMap.gi" );

##
ReadPackage( "Sheaves", "gap/UnderlyingModule.gi" );

##
ReadPackage( "Sheaves", "gap/BasicFunctors.gi" );

##
ReadPackage( "Sheaves", "gap/ToolFunctors.gi" );

##
ReadPackage( "Sheaves", "gap/OtherFunctors.gi" );

##
ReadPackage( "Sheaves", "gap/Tools.gi" );

if IsBound( MakeThreadLocal ) then
    Perform(
            [
             "HOMALG_SHEAVES",
             ],
            MakeThreadLocal );
fi;
