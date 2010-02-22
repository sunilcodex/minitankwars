 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
Tank Wreck cl_init.lua
	-Tank Wreck Entity clientside init
*/

include('shared.lua');
 
function ENT:Draw()
	self.Entity:DrawModel();
end