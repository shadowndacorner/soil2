function string.starts(String,Start)
	if ( _ACTION ) then
		return string.sub(String,1,string.len(Start))==Start
	end

	return false
end

function is_vs()
	return ( string.starts(_ACTION,"vs") )
end

configuration "windows"
   links {  }
   platforms {"x64"}

configuration "linux"
   links {  }

configuration "macosx"
   links { "png" }

workspace "SOIL2"
	location ("build/".. _ACTION .."/")
	targetdir("./bin")
	configurations { "Debug", "Release" }
	--objdir("obj/" .. os.get() .. "/")
	
	project "soil2-static-lib"
		kind "StaticLib"

		if is_vs() then
			language "C++"
			buildoptions { "/TP" }
			defines { "_CRT_SECURE_NO_WARNINGS" }
		else
			language "C"
		end
		
		targetdir "bin/%{cfg.buildcfg}"
		files { "include/SOIL2/*.c", "include/SOIL2/*.h", "src/*.c" }
		includedirs {"include/SOIL2"}
		
		configuration "Debug"
			defines { "DEBUG" }
			symbols "On"
			if not is_vs() then
				buildoptions{ "-Wall" }
			end
			targetname "soil2-debug"

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize" }
			targetname "soil2"