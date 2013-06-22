# Microsoft Developer Studio Project File - Name="Meia" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=Meia - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Meia.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Meia.mak" CFG="Meia - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Meia - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "Meia - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "Meia - Win32 Release ICL" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "Meia"
# PROP Scc_LocalPath ".."
CPP=xicl6.exe
RSC=rc.exe

!IF  "$(CFG)" == "Meia - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\lib\Release"
# PROP Intermediate_Dir "..\obj\Release\Meia"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /Zi /O2 /I "h" /I "..\h" /D "NDEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /D "WIN32_LEAN_AND_MEAN" /D "NOMINMAX" /YX /FD /GF /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=xilink6.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\lib\Debug"
# PROP Intermediate_Dir "..\obj\Debug\Meia"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /I "h" /I "..\h" /D "_DEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /D "WIN32_LEAN_AND_MEAN" /D "NOMINMAX" /YX /FD /GF /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=xilink6.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Meia___Win32_Release_ICL"
# PROP BASE Intermediate_Dir "Meia___Win32_Release_ICL"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\lib\ReleaseICL"
# PROP Intermediate_Dir "..\obj\ReleaseICL\Meia"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /Zi /O2 /I "h" /I "..\h" /D "NDEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /D "WIN32_LEAN_AND_MEAN" /D "NOMINMAX" /YX /FD /GF /c
# ADD CPP /nologo /MT /W3 /GX /Zi /O2 /I "h" /I "..\h" /D "NDEBUG" /D "_USE_INTEL_COMPILER" /D "WIN32" /D "_MBCS" /D "_LIB" /D "WIN32_LEAN_AND_MEAN" /D "NOMINMAX" /YX /FD /GF /QxW /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=xilink6.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "Meia - Win32 Release"
# Name "Meia - Win32 Debug"
# Name "Meia - Win32 Release ICL"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\source\convert_isse.cpp
# End Source File
# Begin Source File

SOURCE=.\source\convert_mmx.cpp
# End Source File
# Begin Source File

SOURCE=.\source\convert_reference.cpp
# End Source File
# Begin Source File

SOURCE=.\source\convert_scalar.cpp
# End Source File
# Begin Source File

SOURCE=.\source\idct_mmx.cpp
# End Source File
# Begin Source File

SOURCE=.\source\idct_reference.cpp
# End Source File
# Begin Source File

SOURCE=.\source\idct_scalar.cpp
# End Source File
# Begin Source File

SOURCE=.\source\MPEGCache.cpp
# End Source File
# Begin Source File

SOURCE=.\source\MPEGDecoder.cpp
# End Source File
# Begin Source File

SOURCE=.\source\MPEGFile.cpp
# End Source File
# Begin Source File

SOURCE=.\source\predict_reference.cpp
# End Source File
# Begin Source File

SOURCE=.\source\tables.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\source\idct_scalar_asm.inl
# End Source File
# Begin Source File

SOURCE=.\h\MPEGCache.h
# End Source File
# Begin Source File

SOURCE=.\h\tables.h
# End Source File
# End Group
# Begin Group "Interface Header Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\h\vd2\Meia\MPEGConvert.h
# End Source File
# Begin Source File

SOURCE=..\h\vd2\Meia\MPEGDecoder.h
# End Source File
# Begin Source File

SOURCE=..\h\vd2\Meia\MPEGFile.h
# End Source File
# Begin Source File

SOURCE=..\h\vd2\Meia\MPEGIDCT.h
# End Source File
# Begin Source File

SOURCE=..\h\vd2\Meia\MPEGPredict.h
# End Source File
# End Group
# Begin Group "Assembly Files"

# PROP Default_Filter ".asm"
# Begin Source File

SOURCE=.\source\a_predict_isse.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\a_predict_isse.asm
InputName=a_predict_isse

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\a_predict_isse.asm
InputName=a_predict_isse

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\a_predict_isse.asm
InputName=a_predict_isse

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\source\a_predict_mmx.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\a_predict_mmx.asm
InputName=a_predict_mmx

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\a_predict_mmx.asm
InputName=a_predict_mmx

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\a_predict_mmx.asm
InputName=a_predict_mmx

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\source\a_predict_scalar.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\a_predict_scalar.asm
InputName=a_predict_scalar

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\a_predict_scalar.asm
InputName=a_predict_scalar

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\a_predict_scalar.asm
InputName=a_predict_scalar

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\source\a_predict_sse2.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\a_predict_sse2.asm
InputName=a_predict_sse2

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\a_predict_sse2.asm
InputName=a_predict_sse2

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\a_predict_sse2.asm
InputName=a_predict_sse2

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\source\a_yuv2rgb.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\a_yuv2rgb.asm
InputName=a_yuv2rgb

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\a_yuv2rgb.asm
InputName=a_yuv2rgb

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\a_yuv2rgb.asm
InputName=a_yuv2rgb

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\source\a_yuvtable.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\a_yuvtable.asm
InputName=a_yuvtable

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\a_yuvtable.asm
InputName=a_yuvtable

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\a_yuvtable.asm
InputName=a_yuvtable

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\source\mpeg_idct_mmx.asm

!IF  "$(CFG)" == "Meia - Win32 Release"

# Begin Custom Build -
IntDir=.\..\obj\Release\Meia
InputPath=.\source\mpeg_idct_mmx.asm
InputName=mpeg_idct_mmx

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# Begin Custom Build -
IntDir=.\..\obj\Debug\Meia
InputPath=.\source\mpeg_idct_mmx.asm
InputName=mpeg_idct_mmx

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

# Begin Custom Build -
IntDir=.\..\obj\ReleaseICL\Meia
InputPath=.\source\mpeg_idct_mmx.asm
InputName=mpeg_idct_mmx

"$(IntDir)\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	ml /nologo /c /coff /Zi /Fo$(IntDir)\$(InputName).obj $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Source Files - IDCT Test"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\source\idct_test.cpp

!IF  "$(CFG)" == "Meia - Win32 Release"

!ELSEIF  "$(CFG)" == "Meia - Win32 Debug"

# ADD CPP /O2 /Ob2
# SUBTRACT CPP /YX

!ELSEIF  "$(CFG)" == "Meia - Win32 Release ICL"

!ENDIF 

# End Source File
# End Group
# End Target
# End Project