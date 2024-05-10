--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.5) ~  Much Love, Ferib 

]]--

local StrToNumber = tonumber;
local Byte = string.byte;
local Char = string.char;
local Sub = string.sub;
local Subg = string.gsub;
local Rep = string.rep;
local Concat = table.concat;
local Insert = table.insert;
local LDExp = math.ldexp;
local GetFEnv = getfenv or function()
	return _ENV;
end;
local Setmetatable = setmetatable;
local PCall = pcall;
local Select = select;
local Unpack = unpack or table.unpack;
local ToNumber = tonumber;
local function VMCall(ByteString, vmenv, ...)
	local DIP = 1;
	local repeatNext;
	ByteString = Subg(Sub(ByteString, 5), "..", function(byte)
		if (Byte(byte, 2) == 79) then
			local FlatIdent_95CAC = 0;
			while true do
				if (FlatIdent_95CAC == 0) then
					repeatNext = StrToNumber(Sub(byte, 1, 1));
					return "";
				end
			end
		else
			local a = Char(StrToNumber(byte, 16));
			if repeatNext then
				local b = Rep(a, repeatNext);
				repeatNext = nil;
				return b;
			else
				return a;
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local Res = (Bit / (2 ^ (Start - 1))) % (2 ^ (((End - 1) - (Start - 1)) + 1));
			return Res - (Res % 1);
		else
			local Plc = 2 ^ (Start - 1);
			return (((Bit % (Plc + Plc)) >= Plc) and 1) or 0;
		end
	end
	local function gBits8()
		local a = Byte(ByteString, DIP, DIP);
		DIP = DIP + 1;
		return a;
	end
	local function gBits16()
		local FlatIdent_76979 = 0;
		local a;
		local b;
		while true do
			if (FlatIdent_76979 == 1) then
				return (b * 256) + a;
			end
			if (FlatIdent_76979 == 0) then
				a, b = Byte(ByteString, DIP, DIP + 2);
				DIP = DIP + 2;
				FlatIdent_76979 = 1;
			end
		end
	end
	local function gBits32()
		local a, b, c, d = Byte(ByteString, DIP, DIP + 3);
		DIP = DIP + 4;
		return (d * 16777216) + (c * 65536) + (b * 256) + a;
	end
	local function gFloat()
		local FlatIdent_24A02 = 0;
		local Left;
		local Right;
		local IsNormal;
		local Mantissa;
		local Exponent;
		local Sign;
		while true do
			if (FlatIdent_24A02 == 3) then
				if (Exponent == 0) then
					if (Mantissa == 0) then
						return Sign * 0;
					else
						local FlatIdent_63487 = 0;
						while true do
							if (FlatIdent_63487 == 0) then
								Exponent = 1;
								IsNormal = 0;
								break;
							end
						end
					end
				elseif (Exponent == 2047) then
					return ((Mantissa == 0) and (Sign * (1 / 0))) or (Sign * NaN);
				end
				return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
			end
			if (FlatIdent_24A02 == 0) then
				Left = gBits32();
				Right = gBits32();
				FlatIdent_24A02 = 1;
			end
			if (FlatIdent_24A02 == 2) then
				Exponent = gBit(Right, 21, 31);
				Sign = ((gBit(Right, 32) == 1) and -1) or 1;
				FlatIdent_24A02 = 3;
			end
			if (FlatIdent_24A02 == 1) then
				IsNormal = 1;
				Mantissa = (gBit(Right, 1, 20) * (2 ^ 32)) + Left;
				FlatIdent_24A02 = 2;
			end
		end
	end
	local function gString(Len)
		local Str;
		if not Len then
			local FlatIdent_44839 = 0;
			while true do
				if (FlatIdent_44839 == 0) then
					Len = gBits32();
					if (Len == 0) then
						return "";
					end
					break;
				end
			end
		end
		Str = Sub(ByteString, DIP, (DIP + Len) - 1);
		DIP = DIP + Len;
		local FStr = {};
		for Idx = 1, #Str do
			FStr[Idx] = Char(Byte(Sub(Str, Idx, Idx)));
		end
		return Concat(FStr);
	end
	local gInt = gBits32;
	local function _R(...)
		return {...}, Select("#", ...);
	end
	local function Deserialize()
		local FlatIdent_25011 = 0;
		local Instrs;
		local Functions;
		local Lines;
		local Chunk;
		local ConstCount;
		local Consts;
		while true do
			if (FlatIdent_25011 == 1) then
				Chunk = {Instrs,Functions,nil,Lines};
				ConstCount = gBits32();
				Consts = {};
				FlatIdent_25011 = 2;
			end
			if (FlatIdent_25011 == 3) then
				for Idx = 1, gBits32() do
					Functions[Idx - 1] = Deserialize();
				end
				return Chunk;
			end
			if (0 == FlatIdent_25011) then
				Instrs = {};
				Functions = {};
				Lines = {};
				FlatIdent_25011 = 1;
			end
			if (FlatIdent_25011 == 2) then
				for Idx = 1, ConstCount do
					local FlatIdent_A36C = 0;
					local Type;
					local Cons;
					while true do
						if (FlatIdent_A36C == 0) then
							Type = gBits8();
							Cons = nil;
							FlatIdent_A36C = 1;
						end
						if (FlatIdent_A36C == 1) then
							if (Type == 1) then
								Cons = gBits8() ~= 0;
							elseif (Type == 2) then
								Cons = gFloat();
							elseif (Type == 3) then
								Cons = gString();
							end
							Consts[Idx] = Cons;
							break;
						end
					end
				end
				Chunk[3] = gBits8();
				for Idx = 1, gBits32() do
					local FlatIdent_7FAC9 = 0;
					local Descriptor;
					while true do
						if (0 == FlatIdent_7FAC9) then
							Descriptor = gBits8();
							if (gBit(Descriptor, 1, 1) == 0) then
								local FlatIdent_455BF = 0;
								local Type;
								local Mask;
								local Inst;
								while true do
									if (FlatIdent_455BF == 2) then
										if (gBit(Mask, 1, 1) == 1) then
											Inst[2] = Consts[Inst[2]];
										end
										if (gBit(Mask, 2, 2) == 1) then
											Inst[3] = Consts[Inst[3]];
										end
										FlatIdent_455BF = 3;
									end
									if (FlatIdent_455BF == 1) then
										Inst = {gBits16(),gBits16(),nil,nil};
										if (Type == 0) then
											local FlatIdent_8CEDF = 0;
											while true do
												if (FlatIdent_8CEDF == 0) then
													Inst[3] = gBits16();
													Inst[4] = gBits16();
													break;
												end
											end
										elseif (Type == 1) then
											Inst[3] = gBits32();
										elseif (Type == 2) then
											Inst[3] = gBits32() - (2 ^ 16);
										elseif (Type == 3) then
											local FlatIdent_33EA4 = 0;
											while true do
												if (FlatIdent_33EA4 == 0) then
													Inst[3] = gBits32() - (2 ^ 16);
													Inst[4] = gBits16();
													break;
												end
											end
										end
										FlatIdent_455BF = 2;
									end
									if (FlatIdent_455BF == 0) then
										Type = gBit(Descriptor, 2, 3);
										Mask = gBit(Descriptor, 4, 6);
										FlatIdent_455BF = 1;
									end
									if (FlatIdent_455BF == 3) then
										if (gBit(Mask, 3, 3) == 1) then
											Inst[4] = Consts[Inst[4]];
										end
										Instrs[Idx] = Inst;
										break;
									end
								end
							end
							break;
						end
					end
				end
				FlatIdent_25011 = 3;
			end
		end
	end
	local function Wrap(Chunk, Upvalues, Env)
		local Instr = Chunk[1];
		local Proto = Chunk[2];
		local Params = Chunk[3];
		return function(...)
			local Instr = Instr;
			local Proto = Proto;
			local Params = Params;
			local _R = _R;
			local VIP = 1;
			local Top = -1;
			local Vararg = {};
			local Args = {...};
			local PCount = Select("#", ...) - 1;
			local Lupvals = {};
			local Stk = {};
			for Idx = 0, PCount do
				if (Idx >= Params) then
					Vararg[Idx - Params] = Args[Idx + 1];
				else
					Stk[Idx] = Args[Idx + 1];
				end
			end
			local Varargsz = (PCount - Params) + 1;
			local Inst;
			local Enum;
			while true do
				Inst = Instr[VIP];
				Enum = Inst[1];
				if (Enum <= 84) then
					if (Enum <= 41) then
						if (Enum <= 20) then
							if (Enum <= 9) then
								if (Enum <= 4) then
									if (Enum <= 1) then
										if (Enum > 0) then
											Stk[Inst[2]] = {};
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = {};
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											do
												return Stk[Inst[2]];
											end
										else
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										end
									elseif (Enum <= 2) then
										local FlatIdent_5BA5E = 0;
										local A;
										while true do
											if (FlatIdent_5BA5E == 1) then
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 2;
											end
											if (FlatIdent_5BA5E == 8) then
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_5BA5E = 9;
											end
											if (FlatIdent_5BA5E == 0) then
												A = nil;
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 1;
											end
											if (FlatIdent_5BA5E == 3) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 4;
											end
											if (FlatIdent_5BA5E == 4) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 5;
											end
											if (FlatIdent_5BA5E == 6) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 7;
											end
											if (FlatIdent_5BA5E == 7) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 8;
											end
											if (FlatIdent_5BA5E == 9) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												break;
											end
											if (FlatIdent_5BA5E == 5) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 6;
											end
											if (FlatIdent_5BA5E == 2) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												FlatIdent_5BA5E = 3;
											end
										end
									elseif (Enum == 3) then
										if (Stk[Inst[2]] == Inst[4]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local B;
										local A;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									end
								elseif (Enum <= 6) then
									if (Enum > 5) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									else
										Stk[Inst[2]][Inst[3]] = Inst[4];
									end
								elseif (Enum <= 7) then
									local A;
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								elseif (Enum == 8) then
									Stk[Inst[2]] = Inst[3];
								else
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								end
							elseif (Enum <= 14) then
								if (Enum <= 11) then
									if (Enum == 10) then
										local B;
										local A;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										B = Stk[Inst[4]];
										if not B then
											VIP = VIP + 1;
										else
											Stk[Inst[2]] = B;
											VIP = Inst[3];
										end
									else
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
									end
								elseif (Enum <= 12) then
									local FlatIdent_5346B = 0;
									local A;
									while true do
										if (FlatIdent_5346B == 0) then
											A = nil;
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_5346B = 1;
										end
										if (FlatIdent_5346B == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											break;
										end
										if (FlatIdent_5346B == 3) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											FlatIdent_5346B = 4;
										end
										if (1 == FlatIdent_5346B) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_5346B = 2;
										end
										if (FlatIdent_5346B == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]]();
											FlatIdent_5346B = 5;
										end
										if (FlatIdent_5346B == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_5346B = 3;
										end
									end
								elseif (Enum == 13) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] ~= Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 17) then
								if (Enum <= 15) then
									Stk[Inst[2]]();
								elseif (Enum > 16) then
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
								else
									local FlatIdent_5998C = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_5998C == 7) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											FlatIdent_5998C = 8;
										end
										if (6 == FlatIdent_5998C) then
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_5998C = 7;
										end
										if (FlatIdent_5998C == 1) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5998C = 2;
										end
										if (FlatIdent_5998C == 3) then
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											FlatIdent_5998C = 4;
										end
										if (5 == FlatIdent_5998C) then
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											FlatIdent_5998C = 6;
										end
										if (FlatIdent_5998C == 2) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_5998C = 3;
										end
										if (FlatIdent_5998C == 9) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											break;
										end
										if (FlatIdent_5998C == 0) then
											B = nil;
											A = nil;
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_5998C = 1;
										end
										if (FlatIdent_5998C == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_5998C = 5;
										end
										if (FlatIdent_5998C == 8) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_5998C = 9;
										end
									end
								end
							elseif (Enum <= 18) then
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 19) then
								Stk[Inst[2]] = Wrap(Proto[Inst[3]], nil, Env);
							else
								local FlatIdent_28014 = 0;
								local A;
								while true do
									if (FlatIdent_28014 == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_28014 = 1;
									end
									if (FlatIdent_28014 == 4) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_28014 = 5;
									end
									if (FlatIdent_28014 == 2) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_28014 = 3;
									end
									if (FlatIdent_28014 == 6) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_28014 = 7;
									end
									if (FlatIdent_28014 == 1) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_28014 = 2;
									end
									if (FlatIdent_28014 == 9) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										break;
									end
									if (FlatIdent_28014 == 8) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_28014 = 9;
									end
									if (FlatIdent_28014 == 3) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_28014 = 4;
									end
									if (FlatIdent_28014 == 5) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_28014 = 6;
									end
									if (FlatIdent_28014 == 7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_28014 = 8;
									end
								end
							end
						elseif (Enum <= 30) then
							if (Enum <= 25) then
								if (Enum <= 22) then
									if (Enum == 21) then
										local FlatIdent_81225 = 0;
										local B;
										local A;
										while true do
											if (FlatIdent_81225 == 0) then
												B = nil;
												A = nil;
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_81225 = 1;
											end
											if (FlatIdent_81225 == 1) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Upvalues[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												FlatIdent_81225 = 2;
											end
											if (FlatIdent_81225 == 3) then
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_81225 = 4;
											end
											if (FlatIdent_81225 == 4) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_81225 = 5;
											end
											if (FlatIdent_81225 == 2) then
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_81225 = 3;
											end
											if (FlatIdent_81225 == 7) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												FlatIdent_81225 = 8;
											end
											if (FlatIdent_81225 == 11) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												VIP = Inst[3];
												break;
											end
											if (6 == FlatIdent_81225) then
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												FlatIdent_81225 = 7;
											end
											if (FlatIdent_81225 == 8) then
												Inst = Instr[VIP];
												A = Inst[2];
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												Stk[A] = B[Inst[4]];
												VIP = VIP + 1;
												FlatIdent_81225 = 9;
											end
											if (FlatIdent_81225 == 10) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_81225 = 11;
											end
											if (FlatIdent_81225 == 5) then
												A = Inst[2];
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												Stk[A] = B[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_81225 = 6;
											end
											if (FlatIdent_81225 == 9) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_81225 = 10;
											end
										end
									elseif (Inst[2] < Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum <= 23) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
								elseif (Enum > 24) then
									local FlatIdent_5962D = 0;
									while true do
										if (FlatIdent_5962D == 3) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 4;
										end
										if (FlatIdent_5962D == 5) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 6;
										end
										if (FlatIdent_5962D == 8) then
											VIP = Inst[3];
											break;
										end
										if (FlatIdent_5962D == 6) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 7;
										end
										if (FlatIdent_5962D == 0) then
											Upvalues[Inst[3]] = Stk[Inst[2]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 1;
										end
										if (FlatIdent_5962D == 1) then
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 2;
										end
										if (FlatIdent_5962D == 2) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 3;
										end
										if (7 == FlatIdent_5962D) then
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 8;
										end
										if (FlatIdent_5962D == 4) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_5962D = 5;
										end
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 27) then
								if (Enum > 26) then
									local FlatIdent_829F9 = 0;
									local A;
									local Results;
									local Edx;
									while true do
										if (FlatIdent_829F9 == 0) then
											A = Inst[2];
											Results = {Stk[A](Stk[A + 1])};
											FlatIdent_829F9 = 1;
										end
										if (1 == FlatIdent_829F9) then
											Edx = 0;
											for Idx = A, Inst[4] do
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
											end
											break;
										end
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								end
							elseif (Enum <= 28) then
								local A;
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							elseif (Enum > 29) then
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							end
						elseif (Enum <= 35) then
							if (Enum <= 32) then
								if (Enum > 31) then
									local FlatIdent_3ACCC = 0;
									local A;
									while true do
										if (FlatIdent_3ACCC == 0) then
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											break;
										end
									end
								else
									local FlatIdent_77478 = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_77478 == 3) then
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_77478 = 4;
										end
										if (FlatIdent_77478 == 8) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											FlatIdent_77478 = 9;
										end
										if (FlatIdent_77478 == 4) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_77478 = 5;
										end
										if (FlatIdent_77478 == 2) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_77478 = 3;
										end
										if (FlatIdent_77478 == 7) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_77478 = 8;
										end
										if (FlatIdent_77478 == 6) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_77478 = 7;
										end
										if (FlatIdent_77478 == 10) then
											if (Stk[Inst[2]] < Stk[Inst[4]]) then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
											break;
										end
										if (FlatIdent_77478 == 9) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_77478 = 10;
										end
										if (5 == FlatIdent_77478) then
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_77478 = 6;
										end
										if (0 == FlatIdent_77478) then
											B = nil;
											A = nil;
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_77478 = 1;
										end
										if (1 == FlatIdent_77478) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_77478 = 2;
										end
									end
								end
							elseif (Enum <= 33) then
								if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum == 34) then
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							else
								do
									return Stk[Inst[2]];
								end
							end
						elseif (Enum <= 38) then
							if (Enum <= 36) then
								local FlatIdent_1E5DB = 0;
								local A;
								while true do
									if (FlatIdent_1E5DB == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1E5DB = 1;
									end
									if (FlatIdent_1E5DB == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_1E5DB = 3;
									end
									if (FlatIdent_1E5DB == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_1E5DB = 4;
									end
									if (FlatIdent_1E5DB == 1) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										FlatIdent_1E5DB = 2;
									end
									if (FlatIdent_1E5DB == 6) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										break;
									end
									if (FlatIdent_1E5DB == 4) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1E5DB = 5;
									end
									if (FlatIdent_1E5DB == 5) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_1E5DB = 6;
									end
								end
							elseif (Enum == 37) then
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 39) then
							local FlatIdent_6E214 = 0;
							local A;
							while true do
								if (FlatIdent_6E214 == 8) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									FlatIdent_6E214 = 9;
								end
								if (2 == FlatIdent_6E214) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_6E214 = 3;
								end
								if (FlatIdent_6E214 == 7) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_6E214 = 8;
								end
								if (FlatIdent_6E214 == 5) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_6E214 = 6;
								end
								if (FlatIdent_6E214 == 6) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_6E214 = 7;
								end
								if (9 == FlatIdent_6E214) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									break;
								end
								if (FlatIdent_6E214 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_6E214 = 2;
								end
								if (0 == FlatIdent_6E214) then
									A = nil;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_6E214 = 1;
								end
								if (FlatIdent_6E214 == 4) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_6E214 = 5;
								end
								if (3 == FlatIdent_6E214) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_6E214 = 4;
								end
							end
						elseif (Enum == 40) then
							Upvalues[Inst[3]] = Stk[Inst[2]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						else
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
						end
					elseif (Enum <= 62) then
						if (Enum <= 51) then
							if (Enum <= 46) then
								if (Enum <= 43) then
									if (Enum > 42) then
										local FlatIdent_2C7C4 = 0;
										local A;
										while true do
											if (FlatIdent_2C7C4 == 0) then
												A = Inst[2];
												do
													return Stk[A], Stk[A + 1];
												end
												break;
											end
										end
									else
										local A;
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									end
								elseif (Enum <= 44) then
									local FlatIdent_8239F = 0;
									while true do
										if (FlatIdent_8239F == 0) then
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											FlatIdent_8239F = 1;
										end
										if (FlatIdent_8239F == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											break;
										end
										if (FlatIdent_8239F == 3) then
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											FlatIdent_8239F = 4;
										end
										if (FlatIdent_8239F == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_8239F = 3;
										end
										if (FlatIdent_8239F == 1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											FlatIdent_8239F = 2;
										end
									end
								elseif (Enum == 45) then
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A = Inst[2];
									do
										return Unpack(Stk, A, A + Inst[3]);
									end
								end
							elseif (Enum <= 48) then
								if (Enum > 47) then
									if (Inst[2] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 49) then
								local FlatIdent_69D54 = 0;
								local A;
								while true do
									if (FlatIdent_69D54 == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_69D54 = 1;
									end
									if (FlatIdent_69D54 == 4) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										FlatIdent_69D54 = 5;
									end
									if (FlatIdent_69D54 == 5) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_69D54 = 6;
									end
									if (FlatIdent_69D54 == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_69D54 = 4;
									end
									if (FlatIdent_69D54 == 6) then
										Stk[Inst[2]] = Env[Inst[3]];
										break;
									end
									if (FlatIdent_69D54 == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										FlatIdent_69D54 = 2;
									end
									if (FlatIdent_69D54 == 2) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_69D54 = 3;
									end
								end
							elseif (Enum == 50) then
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local FlatIdent_4058F = 0;
								local B;
								local A;
								while true do
									if (FlatIdent_4058F == 8) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 9;
									end
									if (FlatIdent_4058F == 14) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_4058F = 15;
									end
									if (FlatIdent_4058F == 10) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_4058F = 11;
									end
									if (12 == FlatIdent_4058F) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 13;
									end
									if (FlatIdent_4058F == 1) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										FlatIdent_4058F = 2;
									end
									if (0 == FlatIdent_4058F) then
										B = nil;
										A = nil;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_4058F = 1;
									end
									if (FlatIdent_4058F == 7) then
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 8;
									end
									if (FlatIdent_4058F == 5) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_4058F = 6;
									end
									if (FlatIdent_4058F == 18) then
										Stk[Inst[2]] = Inst[3];
										break;
									end
									if (FlatIdent_4058F == 13) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 14;
									end
									if (FlatIdent_4058F == 9) then
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_4058F = 10;
									end
									if (FlatIdent_4058F == 2) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 3;
									end
									if (6 == FlatIdent_4058F) then
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 7;
									end
									if (11 == FlatIdent_4058F) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 12;
									end
									if (FlatIdent_4058F == 4) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_4058F = 5;
									end
									if (FlatIdent_4058F == 15) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_4058F = 16;
									end
									if (16 == FlatIdent_4058F) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_4058F = 17;
									end
									if (17 == FlatIdent_4058F) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Env[Inst[3]] = Stk[Inst[2]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 18;
									end
									if (FlatIdent_4058F == 3) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4058F = 4;
									end
								end
							end
						elseif (Enum <= 56) then
							if (Enum <= 53) then
								if (Enum == 52) then
									local FlatIdent_C342 = 0;
									local A;
									while true do
										if (FlatIdent_C342 == 2) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_C342 = 3;
										end
										if (4 == FlatIdent_C342) then
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_C342 = 5;
										end
										if (0 == FlatIdent_C342) then
											A = nil;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_C342 = 1;
										end
										if (FlatIdent_C342 == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_C342 = 4;
										end
										if (FlatIdent_C342 == 5) then
											Stk[Inst[2]] = Env[Inst[3]];
											break;
										end
										if (FlatIdent_C342 == 1) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											FlatIdent_C342 = 2;
										end
									end
								else
									local A = Inst[2];
									local Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									local Edx = 0;
									for Idx = A, Top do
										local FlatIdent_8E3FD = 0;
										while true do
											if (FlatIdent_8E3FD == 0) then
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
												break;
											end
										end
									end
								end
							elseif (Enum <= 54) then
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							elseif (Enum == 55) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								local FlatIdent_D07E = 0;
								local A;
								while true do
									if (FlatIdent_D07E == 0) then
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										break;
									end
								end
							end
						elseif (Enum <= 59) then
							if (Enum <= 57) then
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							elseif (Enum == 58) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							end
						elseif (Enum <= 60) then
							Stk[Inst[2]] = Inst[3] ~= 0;
						elseif (Enum == 61) then
							local FlatIdent_37E3 = 0;
							local A;
							while true do
								if (3 == FlatIdent_37E3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									FlatIdent_37E3 = 4;
								end
								if (0 == FlatIdent_37E3) then
									A = nil;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_37E3 = 1;
								end
								if (FlatIdent_37E3 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_37E3 = 6;
								end
								if (FlatIdent_37E3 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_37E3 = 2;
								end
								if (FlatIdent_37E3 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_37E3 = 5;
								end
								if (FlatIdent_37E3 == 7) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_37E3 == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_37E3 = 7;
								end
								if (FlatIdent_37E3 == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_37E3 = 3;
								end
							end
						else
							local FlatIdent_1BD19 = 0;
							local A;
							while true do
								if (FlatIdent_1BD19 == 2) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									FlatIdent_1BD19 = 3;
								end
								if (1 == FlatIdent_1BD19) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Stk[A + 1]);
									FlatIdent_1BD19 = 2;
								end
								if (FlatIdent_1BD19 == 9) then
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_1BD19 == 7) then
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_1BD19 = 8;
								end
								if (FlatIdent_1BD19 == 0) then
									A = nil;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_1BD19 = 1;
								end
								if (FlatIdent_1BD19 == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_1BD19 = 7;
								end
								if (FlatIdent_1BD19 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_1BD19 = 5;
								end
								if (8 == FlatIdent_1BD19) then
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_1BD19 = 9;
								end
								if (FlatIdent_1BD19 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_1BD19 = 6;
								end
								if (FlatIdent_1BD19 == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									FlatIdent_1BD19 = 4;
								end
							end
						end
					elseif (Enum <= 73) then
						if (Enum <= 67) then
							if (Enum <= 64) then
								if (Enum == 63) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local FlatIdent_79884 = 0;
									local NewProto;
									local NewUvals;
									local Indexes;
									while true do
										if (FlatIdent_79884 == 2) then
											for Idx = 1, Inst[4] do
												local FlatIdent_90271 = 0;
												local Mvm;
												while true do
													if (FlatIdent_90271 == 1) then
														if (Mvm[1] == 157) then
															Indexes[Idx - 1] = {Stk,Mvm[3]};
														else
															Indexes[Idx - 1] = {Upvalues,Mvm[3]};
														end
														Lupvals[#Lupvals + 1] = Indexes;
														break;
													end
													if (FlatIdent_90271 == 0) then
														VIP = VIP + 1;
														Mvm = Instr[VIP];
														FlatIdent_90271 = 1;
													end
												end
											end
											Stk[Inst[2]] = Wrap(NewProto, NewUvals, Env);
											break;
										end
										if (FlatIdent_79884 == 1) then
											Indexes = {};
											NewUvals = Setmetatable({}, {__index=function(_, Key)
												local Val = Indexes[Key];
												return Val[1][Val[2]];
											end,__newindex=function(_, Key, Value)
												local Val = Indexes[Key];
												Val[1][Val[2]] = Value;
											end});
											FlatIdent_79884 = 2;
										end
										if (FlatIdent_79884 == 0) then
											NewProto = Proto[Inst[3]];
											NewUvals = nil;
											FlatIdent_79884 = 1;
										end
									end
								end
							elseif (Enum <= 65) then
								local FlatIdent_5E6B6 = 0;
								local A;
								while true do
									if (FlatIdent_5E6B6 == 4) then
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_5E6B6 = 5;
									end
									if (FlatIdent_5E6B6 == 3) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_5E6B6 = 4;
									end
									if (FlatIdent_5E6B6 == 0) then
										A = nil;
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_5E6B6 = 1;
									end
									if (FlatIdent_5E6B6 == 6) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (FlatIdent_5E6B6 == 1) then
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_5E6B6 = 2;
									end
									if (FlatIdent_5E6B6 == 5) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										FlatIdent_5E6B6 = 6;
									end
									if (FlatIdent_5E6B6 == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_5E6B6 = 3;
									end
								end
							elseif (Enum == 66) then
								local FlatIdent_6BDA4 = 0;
								local B;
								local A;
								while true do
									if (2 == FlatIdent_6BDA4) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_6BDA4 = 3;
									end
									if (0 == FlatIdent_6BDA4) then
										B = nil;
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_6BDA4 = 1;
									end
									if (FlatIdent_6BDA4 == 3) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										FlatIdent_6BDA4 = 4;
									end
									if (FlatIdent_6BDA4 == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_6BDA4 = 2;
									end
									if (FlatIdent_6BDA4 == 4) then
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_6BDA4 = 5;
									end
									if (FlatIdent_6BDA4 == 5) then
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_6BDA4 = 6;
									end
									if (FlatIdent_6BDA4 == 6) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
								end
							else
								local A = Inst[2];
								Stk[A] = Stk[A]();
							end
						elseif (Enum <= 70) then
							if (Enum <= 68) then
								local A;
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							elseif (Enum == 69) then
								Stk[Inst[2]] = Upvalues[Inst[3]];
							elseif (Stk[Inst[2]] < Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 71) then
							local FlatIdent_35F25 = 0;
							local A;
							while true do
								if (0 == FlatIdent_35F25) then
									A = nil;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_35F25 = 1;
								end
								if (FlatIdent_35F25 == 3) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									FlatIdent_35F25 = 4;
								end
								if (6 == FlatIdent_35F25) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
									break;
								end
								if (FlatIdent_35F25 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_35F25 = 6;
								end
								if (FlatIdent_35F25 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_35F25 = 2;
								end
								if (FlatIdent_35F25 == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_35F25 = 3;
								end
								if (FlatIdent_35F25 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									FlatIdent_35F25 = 5;
								end
							end
						elseif (Enum == 72) then
							Stk[Inst[2]] = {};
						else
							local B;
							local A;
							A = Inst[2];
							Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Inst[2] < Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 78) then
						if (Enum <= 75) then
							if (Enum == 74) then
								Stk[Inst[2]] = Env[Inst[3]];
							else
								local FlatIdent_6CF78 = 0;
								local B;
								local A;
								while true do
									if (FlatIdent_6CF78 == 1) then
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										FlatIdent_6CF78 = 2;
									end
									if (FlatIdent_6CF78 == 4) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_6CF78 = 5;
									end
									if (FlatIdent_6CF78 == 0) then
										B = nil;
										A = nil;
										A = Inst[2];
										FlatIdent_6CF78 = 1;
									end
									if (FlatIdent_6CF78 == 5) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_6CF78 = 6;
									end
									if (FlatIdent_6CF78 == 6) then
										if (Stk[Inst[2]] < Inst[4]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
										break;
									end
									if (FlatIdent_6CF78 == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_6CF78 = 4;
									end
									if (2 == FlatIdent_6CF78) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_6CF78 = 3;
									end
								end
							end
						elseif (Enum <= 76) then
							local Edx;
							local Results;
							local A;
							Env[Inst[3]] = Stk[Inst[2]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results = {Stk[A](Stk[A + 1])};
							Edx = 0;
							for Idx = A, Inst[4] do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						elseif (Enum == 77) then
							local Edx;
							local Results;
							local A;
							A = Inst[2];
							Results = {Stk[A](Stk[A + 1])};
							Edx = 0;
							for Idx = A, Inst[4] do
								local FlatIdent_84C31 = 0;
								while true do
									if (0 == FlatIdent_84C31) then
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
										break;
									end
								end
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						else
							local A;
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum <= 81) then
						if (Enum <= 79) then
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]]();
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						elseif (Enum > 80) then
							Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
						else
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]]();
							VIP = VIP + 1;
							Inst = Instr[VIP];
							for Idx = Inst[2], Inst[3] do
								Stk[Idx] = nil;
							end
						end
					elseif (Enum <= 82) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						VIP = Inst[3];
					elseif (Enum == 83) then
						local FlatIdent_2DD98 = 0;
						local B;
						local A;
						while true do
							if (FlatIdent_2DD98 == 1) then
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								FlatIdent_2DD98 = 2;
							end
							if (FlatIdent_2DD98 == 3) then
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								FlatIdent_2DD98 = 4;
							end
							if (FlatIdent_2DD98 == 4) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_2DD98 = 5;
							end
							if (FlatIdent_2DD98 == 6) then
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_2DD98 = 7;
							end
							if (FlatIdent_2DD98 == 5) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_2DD98 = 6;
							end
							if (FlatIdent_2DD98 == 0) then
								B = nil;
								A = nil;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_2DD98 = 1;
							end
							if (7 == FlatIdent_2DD98) then
								Stk[Inst[2]] = Inst[3];
								break;
							end
							if (FlatIdent_2DD98 == 2) then
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								FlatIdent_2DD98 = 3;
							end
						end
					else
						local FlatIdent_15F51 = 0;
						local A;
						local Results;
						local Edx;
						while true do
							if (FlatIdent_15F51 == 0) then
								A = Inst[2];
								Results = {Stk[A](Unpack(Stk, A + 1, Top))};
								FlatIdent_15F51 = 1;
							end
							if (1 == FlatIdent_15F51) then
								Edx = 0;
								for Idx = A, Inst[4] do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								break;
							end
						end
					end
				elseif (Enum <= 126) then
					if (Enum <= 105) then
						if (Enum <= 94) then
							if (Enum <= 89) then
								if (Enum <= 86) then
									if (Enum == 85) then
										local A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
									else
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
									end
								elseif (Enum <= 87) then
									Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
								elseif (Enum > 88) then
									local FlatIdent_81F6A = 0;
									local A;
									while true do
										if (FlatIdent_81F6A == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											for Idx = Inst[2], Inst[3] do
												Stk[Idx] = nil;
											end
											FlatIdent_81F6A = 5;
										end
										if (2 == FlatIdent_81F6A) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											FlatIdent_81F6A = 3;
										end
										if (1 == FlatIdent_81F6A) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_81F6A = 2;
										end
										if (FlatIdent_81F6A == 0) then
											A = nil;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_81F6A = 1;
										end
										if (5 == FlatIdent_81F6A) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											VIP = Inst[3];
											break;
										end
										if (FlatIdent_81F6A == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_81F6A = 4;
										end
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								end
							elseif (Enum <= 91) then
								if (Enum == 90) then
									local FlatIdent_72401 = 0;
									while true do
										if (FlatIdent_72401 == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											break;
										end
										if (FlatIdent_72401 == 0) then
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											FlatIdent_72401 = 1;
										end
										if (FlatIdent_72401 == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_72401 = 3;
										end
										if (FlatIdent_72401 == 1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											FlatIdent_72401 = 2;
										end
										if (FlatIdent_72401 == 3) then
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											FlatIdent_72401 = 4;
										end
									end
								else
									local FlatIdent_29662 = 0;
									local A;
									while true do
										if (FlatIdent_29662 == 3) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_29662 = 4;
										end
										if (FlatIdent_29662 == 7) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											break;
										end
										if (FlatIdent_29662 == 1) then
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											FlatIdent_29662 = 2;
										end
										if (FlatIdent_29662 == 2) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_29662 = 3;
										end
										if (6 == FlatIdent_29662) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											FlatIdent_29662 = 7;
										end
										if (FlatIdent_29662 == 4) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_29662 = 5;
										end
										if (FlatIdent_29662 == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_29662 = 6;
										end
										if (FlatIdent_29662 == 0) then
											A = nil;
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_29662 = 1;
										end
									end
								end
							elseif (Enum <= 92) then
								local FlatIdent_3974D = 0;
								local A;
								while true do
									if (2 == FlatIdent_3974D) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_3974D = 3;
									end
									if (0 == FlatIdent_3974D) then
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_3974D = 1;
									end
									if (FlatIdent_3974D == 4) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_3974D = 5;
									end
									if (FlatIdent_3974D == 7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_3974D = 8;
									end
									if (FlatIdent_3974D == 1) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_3974D = 2;
									end
									if (FlatIdent_3974D == 3) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_3974D = 4;
									end
									if (FlatIdent_3974D == 9) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										break;
									end
									if (FlatIdent_3974D == 8) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_3974D = 9;
									end
									if (FlatIdent_3974D == 5) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_3974D = 6;
									end
									if (FlatIdent_3974D == 6) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_3974D = 7;
									end
								end
							elseif (Enum > 93) then
								local FlatIdent_1C13F = 0;
								local A;
								while true do
									if (FlatIdent_1C13F == 4) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1C13F = 5;
									end
									if (FlatIdent_1C13F == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_1C13F = 3;
									end
									if (FlatIdent_1C13F == 5) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (FlatIdent_1C13F == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_1C13F = 4;
									end
									if (FlatIdent_1C13F == 1) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										FlatIdent_1C13F = 2;
									end
									if (FlatIdent_1C13F == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1C13F = 1;
									end
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 99) then
							if (Enum <= 96) then
								if (Enum > 95) then
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return;
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3] ~= 0;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 97) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							elseif (Enum > 98) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							else
								local Results;
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									local FlatIdent_93E71 = 0;
									while true do
										if (0 == FlatIdent_93E71) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results = {Stk[A](Unpack(Stk, A + 1, Top))};
								Edx = 0;
								for Idx = A, Inst[4] do
									local FlatIdent_3A75D = 0;
									while true do
										if (FlatIdent_3A75D == 0) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 102) then
							if (Enum <= 100) then
								local FlatIdent_571C2 = 0;
								local A;
								while true do
									if (FlatIdent_571C2 == 0) then
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										break;
									end
								end
							elseif (Enum == 101) then
								local FlatIdent_360C0 = 0;
								local B;
								local A;
								while true do
									if (FlatIdent_360C0 == 4) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_360C0 = 5;
									end
									if (FlatIdent_360C0 == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_360C0 = 2;
									end
									if (FlatIdent_360C0 == 0) then
										B = nil;
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_360C0 = 1;
									end
									if (FlatIdent_360C0 == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_360C0 = 4;
									end
									if (FlatIdent_360C0 == 6) then
										VIP = Inst[3];
										break;
									end
									if (FlatIdent_360C0 == 2) then
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										FlatIdent_360C0 = 3;
									end
									if (5 == FlatIdent_360C0) then
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_360C0 = 6;
									end
								end
							else
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] - Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 103) then
							local Edx;
							local Results;
							local B;
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results = {Stk[A](Stk[A + 1])};
							Edx = 0;
							for Idx = A, Inst[4] do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						elseif (Enum == 104) then
							local FlatIdent_47DDA = 0;
							local A;
							while true do
								if (FlatIdent_47DDA == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									FlatIdent_47DDA = 7;
								end
								if (FlatIdent_47DDA == 3) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_47DDA = 4;
								end
								if (FlatIdent_47DDA == 4) then
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_47DDA = 5;
								end
								if (0 == FlatIdent_47DDA) then
									A = nil;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_47DDA = 1;
								end
								if (FlatIdent_47DDA == 1) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_47DDA = 2;
								end
								if (FlatIdent_47DDA == 2) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_47DDA = 3;
								end
								if (FlatIdent_47DDA == 7) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_47DDA == 5) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_47DDA = 6;
								end
							end
						else
							local FlatIdent_384E6 = 0;
							local B;
							local A;
							while true do
								if (FlatIdent_384E6 == 5) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_384E6 = 6;
								end
								if (FlatIdent_384E6 == 6) then
									do
										return Stk[Inst[2]];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return;
									end
									break;
								end
								if (2 == FlatIdent_384E6) then
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									FlatIdent_384E6 = 3;
								end
								if (FlatIdent_384E6 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_384E6 = 5;
								end
								if (3 == FlatIdent_384E6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									FlatIdent_384E6 = 4;
								end
								if (FlatIdent_384E6 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_384E6 = 2;
								end
								if (FlatIdent_384E6 == 0) then
									B = nil;
									A = nil;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_384E6 = 1;
								end
							end
						end
					elseif (Enum <= 115) then
						if (Enum <= 110) then
							if (Enum <= 107) then
								if (Enum == 106) then
									local A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Top));
								else
									local A;
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								end
							elseif (Enum <= 108) then
								do
									return;
								end
							elseif (Enum > 109) then
								local FlatIdent_104FA = 0;
								while true do
									if (FlatIdent_104FA == 1) then
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_104FA = 2;
									end
									if (FlatIdent_104FA == 3) then
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_104FA = 4;
									end
									if (FlatIdent_104FA == 4) then
										do
											return Stk[Inst[2]];
										end
										break;
									end
									if (FlatIdent_104FA == 0) then
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_104FA = 1;
									end
									if (FlatIdent_104FA == 2) then
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_104FA = 3;
									end
								end
							else
								local FlatIdent_79739 = 0;
								local A;
								while true do
									if (FlatIdent_79739 == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_79739 = 3;
									end
									if (FlatIdent_79739 == 0) then
										A = nil;
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_79739 = 1;
									end
									if (FlatIdent_79739 == 7) then
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										break;
									end
									if (FlatIdent_79739 == 3) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_79739 = 4;
									end
									if (FlatIdent_79739 == 6) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										FlatIdent_79739 = 7;
									end
									if (FlatIdent_79739 == 5) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_79739 = 6;
									end
									if (FlatIdent_79739 == 1) then
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_79739 = 2;
									end
									if (FlatIdent_79739 == 4) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_79739 = 5;
									end
								end
							end
						elseif (Enum <= 112) then
							if (Enum > 111) then
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local FlatIdent_FF71 = 0;
								local A;
								while true do
									if (FlatIdent_FF71 == 1) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_FF71 = 2;
									end
									if (FlatIdent_FF71 == 4) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_FF71 = 5;
									end
									if (FlatIdent_FF71 == 5) then
										Stk[Inst[2]] = Inst[3];
										break;
									end
									if (FlatIdent_FF71 == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_FF71 = 3;
									end
									if (FlatIdent_FF71 == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_FF71 = 1;
									end
									if (FlatIdent_FF71 == 3) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										FlatIdent_FF71 = 4;
									end
								end
							end
						elseif (Enum <= 113) then
							Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];
						elseif (Enum == 114) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						else
							local A = Inst[2];
							local T = Stk[A];
							local B = Inst[3];
							for Idx = 1, B do
								T[Idx] = Stk[A + Idx];
							end
						end
					elseif (Enum <= 120) then
						if (Enum <= 117) then
							if (Enum == 116) then
								if (Stk[Inst[2]] ~= Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 118) then
							local A = Inst[2];
							local Cls = {};
							for Idx = 1, #Lupvals do
								local FlatIdent_2BB2A = 0;
								local List;
								while true do
									if (FlatIdent_2BB2A == 0) then
										List = Lupvals[Idx];
										for Idz = 0, #List do
											local FlatIdent_24439 = 0;
											local Upv;
											local NStk;
											local DIP;
											while true do
												if (FlatIdent_24439 == 1) then
													DIP = Upv[2];
													if ((NStk == Stk) and (DIP >= A)) then
														Cls[DIP] = NStk[DIP];
														Upv[1] = Cls;
													end
													break;
												end
												if (FlatIdent_24439 == 0) then
													Upv = List[Idz];
													NStk = Upv[1];
													FlatIdent_24439 = 1;
												end
											end
										end
										break;
									end
								end
							end
						elseif (Enum > 119) then
							local FlatIdent_48BB9 = 0;
							local A;
							while true do
								if (FlatIdent_48BB9 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_48BB9 = 2;
								end
								if (FlatIdent_48BB9 == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_48BB9 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									FlatIdent_48BB9 = 6;
								end
								if (FlatIdent_48BB9 == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_48BB9 = 3;
								end
								if (FlatIdent_48BB9 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									FlatIdent_48BB9 = 5;
								end
								if (FlatIdent_48BB9 == 3) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_48BB9 = 4;
								end
								if (FlatIdent_48BB9 == 0) then
									A = nil;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_48BB9 = 1;
								end
							end
						else
							local FlatIdent_61610 = 0;
							local B;
							local A;
							while true do
								if (FlatIdent_61610 == 3) then
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									FlatIdent_61610 = 4;
								end
								if (FlatIdent_61610 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_61610 = 5;
								end
								if (1 == FlatIdent_61610) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_61610 = 2;
								end
								if (FlatIdent_61610 == 6) then
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
									break;
								end
								if (FlatIdent_61610 == 2) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_61610 = 3;
								end
								if (FlatIdent_61610 == 0) then
									B = nil;
									A = nil;
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_61610 = 1;
								end
								if (FlatIdent_61610 == 5) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_61610 = 6;
								end
							end
						end
					elseif (Enum <= 123) then
						if (Enum <= 121) then
							Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
						elseif (Enum > 122) then
							local Edx;
							local Results, Limit;
							local B;
							local A;
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Stk[A + 1]));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						else
							local B;
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						end
					elseif (Enum <= 124) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
					elseif (Enum == 125) then
						local A = Inst[2];
						local C = Inst[4];
						local CB = A + 2;
						local Result = {Stk[A](Stk[A + 1], Stk[CB])};
						for Idx = 1, C do
							Stk[CB + Idx] = Result[Idx];
						end
						local R = Result[1];
						if R then
							local FlatIdent_56024 = 0;
							while true do
								if (FlatIdent_56024 == 0) then
									Stk[CB] = R;
									VIP = Inst[3];
									break;
								end
							end
						else
							VIP = VIP + 1;
						end
					else
						local A;
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
					end
				elseif (Enum <= 147) then
					if (Enum <= 136) then
						if (Enum <= 131) then
							if (Enum <= 128) then
								if (Enum > 127) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									local FlatIdent_11006 = 0;
									local B;
									local A;
									while true do
										if (0 == FlatIdent_11006) then
											B = nil;
											A = nil;
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_11006 = 1;
										end
										if (7 == FlatIdent_11006) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_11006 = 8;
										end
										if (FlatIdent_11006 == 4) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_11006 = 5;
										end
										if (FlatIdent_11006 == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_11006 = 6;
										end
										if (FlatIdent_11006 == 8) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Stk[A](Unpack(Stk, A + 1, Inst[3]));
											end
											FlatIdent_11006 = 9;
										end
										if (1 == FlatIdent_11006) then
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_11006 = 2;
										end
										if (10 == FlatIdent_11006) then
											Inst = Instr[VIP];
											do
												return;
											end
											break;
										end
										if (FlatIdent_11006 == 9) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Unpack(Stk, A, Top);
											end
											VIP = VIP + 1;
											FlatIdent_11006 = 10;
										end
										if (FlatIdent_11006 == 2) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_11006 = 3;
										end
										if (FlatIdent_11006 == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											FlatIdent_11006 = 4;
										end
										if (FlatIdent_11006 == 6) then
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_11006 = 7;
										end
									end
								end
							elseif (Enum <= 129) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							elseif (Enum > 130) then
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							end
						elseif (Enum <= 133) then
							if (Enum > 132) then
								local FlatIdent_4FB53 = 0;
								local A;
								while true do
									if (FlatIdent_4FB53 == 5) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_4FB53 = 6;
									end
									if (FlatIdent_4FB53 == 3) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_4FB53 = 4;
									end
									if (FlatIdent_4FB53 == 0) then
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_4FB53 = 1;
									end
									if (FlatIdent_4FB53 == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4FB53 = 2;
									end
									if (FlatIdent_4FB53 == 7) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										break;
									end
									if (FlatIdent_4FB53 == 6) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_4FB53 = 7;
									end
									if (FlatIdent_4FB53 == 4) then
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_4FB53 = 5;
									end
									if (FlatIdent_4FB53 == 2) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_4FB53 = 3;
									end
								end
							else
								local FlatIdent_83DF4 = 0;
								local Results;
								local Edx;
								local Limit;
								local B;
								local A;
								while true do
									if (FlatIdent_83DF4 == 6) then
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Stk[A + 1]));
										FlatIdent_83DF4 = 7;
									end
									if (FlatIdent_83DF4 == 8) then
										A = Inst[2];
										Results = {Stk[A](Unpack(Stk, A + 1, Top))};
										Edx = 0;
										for Idx = A, Inst[4] do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										FlatIdent_83DF4 = 9;
									end
									if (3 == FlatIdent_83DF4) then
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_83DF4 = 4;
									end
									if (FlatIdent_83DF4 == 0) then
										Results = nil;
										Edx = nil;
										Results, Limit = nil;
										B = nil;
										A = nil;
										FlatIdent_83DF4 = 1;
									end
									if (FlatIdent_83DF4 == 1) then
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_83DF4 = 2;
									end
									if (4 == FlatIdent_83DF4) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_83DF4 = 5;
									end
									if (FlatIdent_83DF4 == 5) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										FlatIdent_83DF4 = 6;
									end
									if (FlatIdent_83DF4 == 9) then
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (FlatIdent_83DF4 == 2) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_83DF4 = 3;
									end
									if (FlatIdent_83DF4 == 7) then
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											local FlatIdent_5E1D0 = 0;
											while true do
												if (FlatIdent_5E1D0 == 0) then
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
													break;
												end
											end
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_83DF4 = 8;
									end
								end
							end
						elseif (Enum <= 134) then
							Env[Inst[3]] = Stk[Inst[2]];
						elseif (Enum > 135) then
							Stk[Inst[2]] = not Stk[Inst[3]];
						else
							Upvalues[Inst[3]] = Stk[Inst[2]];
						end
					elseif (Enum <= 141) then
						if (Enum <= 138) then
							if (Enum == 137) then
								local A = Inst[2];
								local T = Stk[A];
								for Idx = A + 1, Inst[3] do
									Insert(T, Stk[Idx]);
								end
							elseif (Stk[Inst[2]] < Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 139) then
							local FlatIdent_7973C = 0;
							local A;
							while true do
								if (FlatIdent_7973C == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_7973C = 4;
								end
								if (FlatIdent_7973C == 4) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_7973C = 5;
								end
								if (FlatIdent_7973C == 5) then
									if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
									break;
								end
								if (FlatIdent_7973C == 2) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									FlatIdent_7973C = 3;
								end
								if (FlatIdent_7973C == 0) then
									A = nil;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_7973C = 1;
								end
								if (1 == FlatIdent_7973C) then
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_7973C = 2;
								end
							end
						elseif (Enum == 140) then
							local B = Stk[Inst[4]];
							if not B then
								VIP = VIP + 1;
							else
								Stk[Inst[2]] = B;
								VIP = Inst[3];
							end
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Stk[A](Unpack(Stk, A + 1, Inst[3]));
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Unpack(Stk, A, Top);
							end
						end
					elseif (Enum <= 144) then
						if (Enum <= 142) then
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						elseif (Enum == 143) then
							local FlatIdent_81A83 = 0;
							local A;
							while true do
								if (FlatIdent_81A83 == 3) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_81A83 = 4;
								end
								if (FlatIdent_81A83 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_81A83 = 2;
								end
								if (FlatIdent_81A83 == 0) then
									A = nil;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_81A83 = 1;
								end
								if (FlatIdent_81A83 == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_81A83 = 3;
								end
								if (FlatIdent_81A83 == 4) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									break;
								end
							end
						else
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						end
					elseif (Enum <= 145) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					elseif (Enum == 146) then
						Stk[Inst[2]] = Stk[Inst[3]] - Inst[4];
					else
						local FlatIdent_9195A = 0;
						local B;
						local A;
						while true do
							if (FlatIdent_9195A == 6) then
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_9195A = 7;
							end
							if (FlatIdent_9195A == 4) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								FlatIdent_9195A = 5;
							end
							if (0 == FlatIdent_9195A) then
								B = nil;
								A = nil;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								FlatIdent_9195A = 1;
							end
							if (FlatIdent_9195A == 1) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								FlatIdent_9195A = 2;
							end
							if (FlatIdent_9195A == 5) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_9195A = 6;
							end
							if (FlatIdent_9195A == 8) then
								VIP = Inst[3];
								break;
							end
							if (FlatIdent_9195A == 3) then
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								FlatIdent_9195A = 4;
							end
							if (2 == FlatIdent_9195A) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_9195A = 3;
							end
							if (FlatIdent_9195A == 7) then
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_9195A = 8;
							end
						end
					end
				elseif (Enum <= 158) then
					if (Enum <= 152) then
						if (Enum <= 149) then
							if (Enum == 148) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							end
						elseif (Enum <= 150) then
							Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
						elseif (Enum > 151) then
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local A = Inst[2];
							do
								return Unpack(Stk, A, Top);
							end
						end
					elseif (Enum <= 155) then
						if (Enum <= 153) then
							local FlatIdent_30A09 = 0;
							while true do
								if (FlatIdent_30A09 == 0) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_30A09 = 1;
								end
								if (FlatIdent_30A09 == 1) then
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_30A09 = 2;
								end
								if (5 == FlatIdent_30A09) then
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_30A09 == 2) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_30A09 = 3;
								end
								if (4 == FlatIdent_30A09) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_30A09 = 5;
								end
								if (FlatIdent_30A09 == 3) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_30A09 = 4;
								end
							end
						elseif (Enum == 154) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] < Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local FlatIdent_2B812 = 0;
							local A;
							local B;
							while true do
								if (FlatIdent_2B812 == 0) then
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_2B812 = 1;
								end
								if (FlatIdent_2B812 == 1) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									break;
								end
							end
						end
					elseif (Enum <= 156) then
						local FlatIdent_8EAFE = 0;
						local A;
						while true do
							if (FlatIdent_8EAFE == 9) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								break;
							end
							if (1 == FlatIdent_8EAFE) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 2;
							end
							if (FlatIdent_8EAFE == 4) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 5;
							end
							if (FlatIdent_8EAFE == 3) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 4;
							end
							if (FlatIdent_8EAFE == 8) then
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_8EAFE = 9;
							end
							if (FlatIdent_8EAFE == 2) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 3;
							end
							if (0 == FlatIdent_8EAFE) then
								A = nil;
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 1;
							end
							if (FlatIdent_8EAFE == 6) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 7;
							end
							if (FlatIdent_8EAFE == 7) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 8;
							end
							if (FlatIdent_8EAFE == 5) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_8EAFE = 6;
							end
						end
					elseif (Enum == 157) then
						Stk[Inst[2]] = Stk[Inst[3]];
					else
						local A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
					end
				elseif (Enum <= 163) then
					if (Enum <= 160) then
						if (Enum > 159) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
						else
							local B;
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						end
					elseif (Enum <= 161) then
						local FlatIdent_3B02 = 0;
						local A;
						while true do
							if (6 == FlatIdent_3B02) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_3B02 = 7;
							end
							if (8 == FlatIdent_3B02) then
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_3B02 = 9;
							end
							if (FlatIdent_3B02 == 3) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								FlatIdent_3B02 = 4;
							end
							if (FlatIdent_3B02 == 2) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_3B02 = 3;
							end
							if (FlatIdent_3B02 == 5) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_3B02 = 6;
							end
							if (FlatIdent_3B02 == 9) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								break;
							end
							if (4 == FlatIdent_3B02) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_3B02 = 5;
							end
							if (FlatIdent_3B02 == 7) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_3B02 = 8;
							end
							if (FlatIdent_3B02 == 0) then
								A = nil;
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								FlatIdent_3B02 = 1;
							end
							if (FlatIdent_3B02 == 1) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								FlatIdent_3B02 = 2;
							end
						end
					elseif (Enum == 162) then
						local A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					else
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						VIP = Inst[3];
					end
				elseif (Enum <= 166) then
					if (Enum <= 164) then
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
					elseif (Enum > 165) then
						local B;
						local T;
						local Edx;
						local Results, Limit;
						local A;
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Results, Limit = _R(Stk[A](Stk[A + 1]));
						Top = (Limit + A) - 1;
						Edx = 0;
						for Idx = A, Top do
							local FlatIdent_39CE7 = 0;
							while true do
								if (FlatIdent_39CE7 == 0) then
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
									break;
								end
							end
						end
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Results, Limit = _R(Stk[A](Stk[A + 1]));
						Top = (Limit + A) - 1;
						Edx = 0;
						for Idx = A, Top do
							local FlatIdent_EF32 = 0;
							while true do
								if (0 == FlatIdent_EF32) then
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
									break;
								end
							end
						end
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						T = Stk[A];
						B = Inst[3];
						for Idx = 1, B do
							T[Idx] = Stk[A + Idx];
						end
					else
						local FlatIdent_38823 = 0;
						local B;
						local A;
						while true do
							if (FlatIdent_38823 == 1) then
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								FlatIdent_38823 = 2;
							end
							if (FlatIdent_38823 == 2) then
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								FlatIdent_38823 = 3;
							end
							if (0 == FlatIdent_38823) then
								B = nil;
								A = nil;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								FlatIdent_38823 = 1;
							end
							if (FlatIdent_38823 == 3) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_38823 = 4;
							end
							if (4 == FlatIdent_38823) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
								break;
							end
						end
					end
				elseif (Enum <= 167) then
					local A;
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Inst[4];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Env[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
				elseif (Enum == 168) then
					local A;
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Env[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
				else
					local A;
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Inst[4];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Env[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
				end
				VIP = VIP + 1;
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
return VMCall("LOL!6B3O00028O00026O00104003063O00506172656E7403043O004E616D6503083O004C6F676F5465787403103O004261636B67726F756E64436F6C6F723303063O00436F6C6F723303073O0066726F6D524742025O00E06F4003163O004261636B67726F756E645472616E73706172656E637902295C8FC2F528F03F030C3O00426F72646572436F6C6F7233030F3O00426F7264657253697A65506978656C03043O0053697A6503053O005544696D322O033O006E657702AC130F60FC2OB13F02399BE400277FC33F026O001440026O00204003083O00506F736974696F6E02AEA72DE02B9BB53F02D8B15D5F3CE3893F025C79F47F4184EA3F0248BFBA805084C23F03043O00466F6E7403043O00456E756D03073O0048696768776179026O002240026O00084002EA3167C05448983F021E5BF21FA2D6DD3F02B6D9E29FFC92A93F026291D5DF21F4B03F03073O00556E6B6E6F776E03043O005465787403023O004F59030A3O0054657874436F6C6F7233026O002C4003083O005465787453697A65026O003D40030B3O00546578745772612O7065642O01026O001C40029A5O99D93F026B3EF9BF5448B83F02BD4FD4206C7B9C3F024DC4B6A05240C93F02D33FC87F6F2DEE3F030A3O00436F6D62617454657874027O004003073O004D61696E47756903043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C61796572030C3O0057616974466F724368696C6403093O00506C61796572477569030E3O005A496E6465784265686176696F7203073O005369626C696E6703093O004F70656E4672616D6502CD5OCCDC3F03063O00436F6D626174030A3O00546578745363616C65642O033O00466C79026O002440026O002840029C3A8260FDDBD03F029EC94DC0EE75CF3F02C90C3000485EE03F02E7A12C403FFAB13F03073O0044656E6B4F6E6503053O0053702O6564026O002A40026O00364003093O00636F726F7574696E6503043O0077726170026O003740026O00344002D28184DF8819CF3F02E965DC20CF78C63F030B3O00436861745370612O6D6572026O003540026O002640026O00F03F026O00304003043O004361706503063O0056697375616C026O00314002607FE91F0A47D33F03053O005654657874026O003240026O001840027B14AE47E17AF03F03073O0056697369626C65010003083O00496E7374616E6365030A3O005465787442752O746F6E03053O004672616D6503083O005549436F726E657203093O00546578744C6162656C03083O004B692O6C61757261026O002E40026O00334003093O004861636B4672616D6503093O005363722O656E47756902834898FF16B8D83F02D3C1FA3F8739D43F00EA022O0012083O00014O0056000100163O0026033O0020000100020004263O0020000100100900030003000200300500040004000500100900040003000100124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090004000600170030050004000A000B00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B0004000C001700302O0004000D000100122O0017000F3O00202O00170017001000122O001800113O00122O001900013O00122O001A00123O00122O001B00016O0017001B000200102O0004000E00170012083O00133O0026033O0048000100140004263O0048000100100900080003000600124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090008000600170030050008000A000B00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B0008000C001700302O0008000D000100122O0017000F3O00202O00170017001000122O001800163O00122O001900013O00122O001A00173O00122O001B00016O0017001B000200102O00080015001700125C0017000F3O00202O00170017001000122O001800183O00122O001900013O00122O001A00193O00122O001B00016O0017001B000200102O0008000E001700122O0017001B3O00202O00170017001A00203B00170017001C0010090008001A00170012083O001D3O0026033O006A0001001E0004263O006A00010030050002000D000100125C0017000F3O00202O00170017001000122O0018001F3O00122O001900013O00122O001A00203O00122O001B00016O0017001B000200102O00020015001700122O0017000F3O00202O001700170010001208001800213O001211001900013O00122O001A00223O00122O001B00016O0017001B000200102O0002000E001700122O0017001B3O00202O00170017001A00202O00170017002300102O0002001A001700302O00020024002500124A001700073O00208F00170017000800122O001800093O00122O001900273O00122O001A00016O0017001A00020010090002002600170030050002002800290030050002002A002B0012083O00023O000E30002C008F00013O0004263O008F000100124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090006000600170030050006000A002D00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B0006000C001700302O0006000D000100122O0017000F3O00202O00170017001000122O0018002E3O00122O001900013O00122O001A002F3O00122O001B00016O0017001B000200102O00060015001700124A0017000F3O00206800170017001000122O001800303O00122O001900013O00122O001A00313O00122O001B00016O0017001B000200102O0006000E001700102O00070003000600302O00080004003200124O00143O0026033O00AF000100330004263O00AF0001003005000100040034001236001700353O00202O00170017003600202O00170017003700202O00170017003800122O001900396O00170019000200102O00010003001700122O0017001B3O00202O00170017003A00202O00170017003B0010090001003A001700300500020004003C00100900020003000100124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090002000600170030050002000A003D00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A00020010090002000C00170012083O001E3O0026033O00C60001001D0004263O00C6000100300500080024003E00124A001700073O00208F00170017000800122O001800093O00122O001900013O00122O001A00016O0017001A000200102900080026001700302O0008003F002B00302O00080028002700302O0008002A002B00302O00090004004000102O00090003000600122O001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090009000600170012083O00413O000E30004200E800013O0004263O00E80001003005000A000D000100125C0017000F3O00202O00170017001000122O001800433O00122O001900013O00122O001A00443O00122O001B00016O0017001B000200102O000A0015001700122O0017000F3O00202O001700170010001208001800453O001211001900013O00122O001A00463O00122O001B00016O0017001B000200102O000A000E001700122O0017001B3O00202O00170017001A00202O00170017004700102O000A001A001700302O000A0024004800124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A0002001009000A00260017003005000A003F002B003005000A002800270012083O00493O0026033O00FD0001004A0004263O00FD00012O0056001300133O00021400135O0012220017004B3O00202O00170017004C4O001800136O0017000200024O0017000100014O001400143O00064000140001000100012O009D3O000B3O0012220017004B3O00202O00170017004C4O001800146O0017000200024O0017000100014O001500153O00064000150002000100012O009D3O000C3O0012083O004D3O0026033O00252O01004E0004263O00252O0100124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B0010000C001700302O0010000D000100122O0017000F3O00202O00170017001000122O0018004F3O00122O001900013O00122O001A00503O00122O001B00016O0017001B000200102O00100015001700125C0017000F3O00202O00170017001000122O001800453O00122O001900013O00122O001A00463O00122O001B00016O0017001B000200102O0010000E001700122O0017001B3O00202O00170017001A00203B0017001700470010090010001A001700300500100024005100124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A00020010090010002600170030050010003F002B0012083O00523O0026033O003C2O0100530004263O003C2O010030050009003F002B0030A400090028002700302O0009002A002B00302O000A0004004800102O000A0003000600122O001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A0002001009000A00060017003005000A000A005400124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A0002001009000A000C00170012083O00423O0026033O00532O0100550004263O00532O01003005000C0024005600124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A0002001029000C0026001700302O000C003F002B00302O000C0028002700302O000C002A002B00302O000D0004005700102O000D0003000500122O001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A0002001009000D000600170012083O00583O0026033O00722O0100580004263O00722O01003005000D000A002D00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B000D000C001700302O000D000D000100122O0017000F3O00202O00170017001000122O001800593O00122O001900013O00122O001A002F3O00122O001B00016O0017001B000200102O000D0015001700124A0017000F3O00202O00170017001000122O001800303O00122O001900013O00122O001A00313O00122O001B00016O0017001B000200102O000D000E001700102O000E0003000D00302O000F0004005A00102O000F0003000D0012083O005B3O0026033O00902O01005C0004263O00902O0100124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090005000600170030050005000A005D00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B0005000C001700302O0005000D000100122O0017000F3O00202O00170017001000122O001800543O00122O001900013O00122O001A00543O00122O001B00016O0017001B000200102O0005000E00170030050005005E005F00300500060004003E0010090006000300050012083O002C3O0026033O00BB2O0100540004263O00BB2O0100124A001700603O00203100170017001000122O001800616O0017000200024O000900173O00122O001700603O00202O00170017001000122O001800616O0017000200024O000A00173O00122O001700603O00203100170017001000122O001800616O0017000200024O000B00173O00122O001700603O00202O00170017001000122O001800616O0017000200024O000C00173O00122O001700603O00203100170017001000122O001800626O0017000200024O000D00173O00122O001700603O00202O00170017001000122O001800636O0017000200024O000E00173O00122O001700603O00203B001700170010001208001800644O009E0017000200022O003A000F00173O00122O001700603O00202O00170017001000122O001800616O0017000200024O001000173O00124O00333O0026033O00D62O0100270004263O00D62O0100124A0017000F3O00201300170017001000122O001800453O00122O001900013O00122O001A00463O00122O001B00016O0017001B000200102O000B000E001700122O0017001B3O00202O00170017001A00202O001700170047001009000B001A0017003005000B0024006500124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200100D000B0026001700302O000B003F002B00302O000B0028002700302O000B002A002B00302O000C0004005600124O00663O0026033O00FE2O01005B0004263O00FE2O0100124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A0002001009000F00060017003005000F000A000B00124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B000F000C001700302O000F000D000100122O0017000F3O00202O00170017001000122O001800163O00122O001900013O00122O001A00173O00122O001B00016O0017001B000200102O000F0015001700125C0017000F3O00202O00170017001000122O001800183O00122O001900013O00122O001A00193O00122O001B00016O0017001B000200102O000F000E001700122O0017001B3O00202O00170017001A00203B00170017001C001009000F001A0017003005000F002400570012083O00673O0026033O0012020100130004263O0012020100124A0017001B3O00201700170017001A00202O00170017001C00102O0004001A001700302O00040024002500122O001700073O00208F00170017000800122O001800093O00122O001900013O00122O001A00016O0017001A000200107000040026001700302O0004003F002B00302O00040028002700302O0004002A002B00302O00050004006800102O00050003000100124O005C3O0026033O003D020100010004263O003D020100124A001700603O00203100170017001000122O001800696O0017000200024O000100173O00122O001700603O00202O00170017001000122O001800616O0017000200024O000200173O00122O001700603O00203100170017001000122O001800636O0017000200024O000300173O00122O001700603O00202O00170017001000122O001800646O0017000200024O000400173O00122O001700603O00203100170017001000122O001800626O0017000200024O000500173O00122O001700603O00202O00170017001000122O001800626O0017000200024O000600173O00122O001700603O00203B001700170010001208001800634O009E0017000200022O003A000700173O00122O001700603O00202O00170017001000122O001800646O0017000200024O000800173O00124O00543O0026033O0052020100520004263O005202010030050010002800270030050010002A002B2O0056001100113O00064000110003000100012O009D3O00023O0012220017004B3O00202O00170017004C4O001800116O0017000200024O0017000100014O001200123O00064000120004000100012O009D3O00093O00120C0017004B3O00202O00170017004C4O001800126O0017000200024O00170001000100124O004A3O0026033O007A020100660004263O007A0201001009000C0003000600124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A0002001009000C00060017003005000C000A005400124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B000C000C001700302O000C000D000100122O0017000F3O00202O00170017001000122O001800433O00122O001900013O00122O001A006A3O00122O001B00016O0017001B000200102O000C0015001700125C0017000F3O00202O00170017001000122O001800453O00122O001900013O00122O001A00463O00122O001B00016O0017001B000200102O000C000E001700122O0017001B3O00202O00170017001A00203B001700170047001009000C001A00170012083O00553O0026033O0091020100670004263O0091020100124A001700073O00208F00170017000800122O001800093O00122O001900013O00122O001A00016O0017001A0002001029000F0026001700302O000F003F002B00302O000F0028002700302O000F002A002B00302O00100004005100102O00100003000D00122O001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A00020010090010000600170030050010000A00540012083O004E3O0026033O00AF020100490004263O00AF0201003005000A002A002B003005000B00040065001009000B0003000600124A001700073O00208F00170017000800122O001800093O00122O001900093O00122O001A00096O0017001A0002001009000B00060017003005000B000A005400124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B000B000C001700302O000B000D000100122O0017000F3O00202O00170017001000122O001800433O00122O001900013O00122O001A006B3O00122O001B00016O0017001B000200102O000B001500170012083O00273O0026033O00D7020100410004263O00D702010030050009000A005400124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A000200106B0009000C001700302O0009000D000100122O0017000F3O00202O00170017001000122O001800433O00122O001900013O00122O001A00503O00122O001B00016O0017001B000200102O00090015001700125C0017000F3O00202O00170017001000122O001800453O00122O001900013O00122O001A00463O00122O001B00016O0017001B000200102O0009000E001700122O0017001B3O00202O00170017001A00203B0017001700470010090009001A001700300500090024004000124A001700073O00208F00170017000800122O001800013O00122O001900013O00122O001A00016O0017001A00020010090009002600170012083O00533O0026033O00020001004D0004263O0002000100124A0017004B3O00200B00170017004C4O001800156O0017000200024O0017000100014O001600163O00064000160005000100012O009D3O00103O00124F0017004B3O00202O00170017004C4O001800166O0017000200024O00170001000100044O00E802010004263O000200012O00768O006C3O00013O00063O00093O00028O00026O00F03F027O004003083O00496E7374616E63652O033O006E6577030B3O004C6F63616C53637269707403063O00506172656E7403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E656374001C3O0012083O00014O0056000100033O0026033O0008000100020004263O000800012O0056000300033O00064000033O000100012O009D3O00023O0012083O00033O0026033O0012000100010004263O0012000100124A000400043O00205F00040004000500122O000500066O000600036O0004000600024O000100046O00025O00124O00023O0026033O0002000100030004263O0002000100203B0004000100070020A500040004000800202O0004000400094O000600036O00040006000100044O001B00010004263O000200012O006C3O00013O00013O000B3O000100028O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203083O0048756D616E6F696403093O0057616C6B53702O6564026O0037402O01026O003040002E4O00457O0026033O0017000100010004263O001700010012083O00024O0056000100013O0026033O0005000100020004263O00050001001208000100023O00260300010008000100020004263O000800012O003C000200014O003900025O00122O000200033O00202O00020002000400202O00020002000500202O00020002000600202O00020002000700302O00020008000900044O002D00010004263O000800010004263O002D00010004263O000500010004263O002D00012O00457O0026033O002D0001000A0004263O002D00010012083O00024O0056000100013O000E300002001C00013O0004263O001C0001001208000100023O0026030001001F000100020004263O001F00012O003C00026O003900025O00122O000200033O00202O00020002000400202O00020002000500202O00020002000600202O00020002000700302O00020008000B00044O002D00010004263O001F00010004263O002D00010004263O001C00012O006C3O00017O004B3O00028O00026O00F03F027O0040026O000840026O001040026O001440030C3O00476574517565756554797065030C3O00676574736572766572706F73030D3O004765744D61746368537461746503083O006861736846756E6303073O007265717569726503043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503023O00545303053O0067616D657303073O0062656477617273030E3O00626564776172732D73776F726473030D3O00426564776172734D656C2O6573026O00184003043O00536C6F7703063O00434672616D652O033O006E657703063O00416E676C657303043O006D6174682O033O00726164025O00806B40026O00594003043O0054696D65026O00D03F026O001C4003063O00412O7365747303093O00566965776D6F64656C03093O00526967687448616E64030A3O005269676874577269737403023O00433003103O00476574436C6F73657374506C6179657203073O004765744265647303093O0053657443616D65726103073O004973416C697665030A3O0052756E5365727669636503123O00436C69656E7448616E646C657253746F7265030D3O00506C617965725363726970747303023O00756903053O0073746F7265030B3O00436C69656E7453746F7265030F3O0053776F7264436F6E74726F2O6C6572030B3O00436F6E74726F2O6C657273030E3O00436F6D626174436F6E7374616E7403063O00636F6D626174030F3O00636F6D6261742D636F6E7374616E7403103O00436F6D626174436F6E74726F2O6C6572030E3O004B6E6F636B6261636B5461626C6503053O006465627567030A3O00676574757076616C756503063O0064616D616765030E3O006B6E6F636B6261636B2D7574696C030D3O004B6E6F636B6261636B5574696C031A3O0063616C63756C6174654B6E6F636B6261636B56656C6F6369747903103O00537072696E74436F6E74726F2O6C6572030F3O0044616D616765496E64696361746F7203193O0044616D616765496E64696361746F72436F6E74726F2O6C657203143O00737061776E44616D616765496E64696361746F72030C3O0054772O656E5365727669636503093O00576F726B7370616365030D3O0043752O72656E7443616D65726103063O00506172656E7403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E656374030B3O004C6F63616C506C6179657203043O006B6E697403053O00736574757003083O00496E7374616E6365030B3O004C6F63616C53637269707403073O00506C61796572730055012O0012083O00014O0056000100103O0026033O0006000100020004263O000600012O0056000400063O0012083O00033O0026033O000A000100030004263O000A00012O0056000700093O0012083O00043O0026033O000E000100040004263O000E00012O0056000A000C3O0012083O00053O0026033O0013000100010004263O00130001001208000100014O0056000200033O0012083O00023O000E300005001700013O0004263O001700012O0056000D000F3O0012083O00063O0026033O0002000100060004263O000200012O0056001000103O0026030001002F000100040004263O002F0001001208001100013O00260300110021000100030004263O00210001001208000100053O0004263O002F000100260300110027000100020004263O0027000100021400125O001286001200074O0056000900093O001208001100033O0026030011001D000100010004263O001D0001000214001200013O001286001200083O000214001200023O001286001200093O001208001100023O0004263O001D00010026030001004C000100050004263O004C0001001208001100013O00260300110038000100020004263O00380001000214001200033O0012860012000A4O0056000B000B3O001208001100033O0026030011003C000100030004263O003C0001001208000100063O0004263O004C0001000E3000010032000100110004263O00320001000214000900043O00125D0012000B3O00122O0013000C3O00202O00130013000D00122O0015000E6O00130015000200202O00130013000F00202O00130013001000202O00130013001100202O0013001300124O00120002000200202O000A0012001300122O001100023O00044O0032000100260300010063000100060004263O00630001001208001100013O00260300110056000100020004263O00560001000640000C0005000100022O009D3O00094O009D3O00044O0056000D000D3O001208001100033O000E300003005A000100110004263O005A0001001208000100143O0004263O006300010026030011004F000100010004263O004F0001000640000B0006000100032O009D3O00094O009D3O00044O009D3O000A4O0056000C000C3O001208001100023O0004263O004F0001002603000100B4000100140004263O00B40001001208001100013O000E30000100A2000100110004263O00A20001000640000D0007000100012O009D3O00044O00A600123O00014O001300026O00143O000200122O001500163O00202O00150015001700122O001600013O00122O001700013O00122O001800046O00150018000200122O001600163O00202O00160016001800122O001700193O00202O00170017001A00122O0018001B6O00170002000200122O001800193O00202O00180018001A00122O0019001C6O00180002000200122O001900193O00202O00190019001A00122O001A001C6O0019001A6O00163O00024O00150015001600102O00140016001500302O0014001D001E4O00153O000200122O001600163O00202O00160016001700122O001700023O00122O001800033O00122O001900016O00160019000200122O001700163O00202O00170017001800122O001800193O00202O00180018001A00122O001900016O00180002000200122O001900193O00202O00190019001A00122O001A00016O00190002000200122O001A00193O00202O001A001A001A00122O001B00016O001A001B6O00173O00024O00160016001700102O00150016001600302O0015001D001E4O0013000200010010090012001500132O009D000E00123O001208001100023O000E30000300A6000100110004263O00A600010012080001001F3O0004263O00B4000100260300110066000100020004263O0066000100124A0012000C3O00206100120012000D00122O0014000E6O00120014000200202O00120012002000202O00120012002100202O00120012002200202O00120012002300202O000F001200244O001000103O00122O001100033O00044O00660001000E30000300CE000100010004263O00CE0001001208001100013O002603001100C1000100020004263O00C1000100064000120008000100022O009D3O00034O009D3O00043O001286001200253O00064000120009000100012O009D3O00043O001286001200263O001208001100033O002603001100C9000100010004263O00C900010002140012000A3O001286001200273O0006400012000B000100012O009D3O00043O001286001200283O001208001100023O002603001100B7000100030004263O00B70001001208000100043O0004263O00CE00010004263O00B700010026030001001D2O0100020004263O001D2O01001208001100013O000E300002000B2O0100110004263O000B2O0100124A0012000C3O00203300120012000D00122O001400296O0012001400024O000800126O00123O000700122O0013000B3O00202O00140004002B00202O00140014000F00202O00140014002C00202O00140014002D4O00130002000200202O00130013002E00102O0012002A001300202O00130005003000202O00130013002F00102O0012002F001300122O0013000B3O00122O0014000C3O00202O00140014000D00122O0016000E6O00140016000200202O00140014000F00202O00140014003200202O0014001400334O00130002000200202O00130013003100102O00120031001300202O00130005003000202O00130013003400102O00120034001300122O001300363O00202O00130013003700122O0014000B3O00122O0015000C3O00202O00150015000D00122O0017000E6O00150017000200202O00150015000F00202O00150015003800202O0015001500394O00140002000200202O00140014003A00202O00140014003B00122O001500026O00130015000200102O00120035001300202O00130005003000202O00130013003C00102O0012003C001300202O00130005003000202O00130013003E00202O00130013003F00102O0012003D001300122O001200113O00122O001100033O002603001100182O0100010004263O00182O0100124A0012000C3O00207200120012000D00122O001400406O0012001400024O000600123O00122O0012000C3O00202O00120012000D00122O001400416O00120014000200202O00070012004200122O001100023O000E30000300D1000100110004263O00D10001001208000100033O0004263O001D2O010004263O00D100010026030001002C2O01001F0004263O002C2O010006400010000C000100062O009D3O00044O009D3O000B4O009D3O000D4O009D3O000E4O009D3O00074O009D3O000F3O00207A00110002004300202O00110011004400202O0011001100454O001300106O00110013000100044O00542O010026030001001A000100010004263O001A0001001208001100013O002603001100332O0100030004263O00332O01001208000100023O0004263O001A0001000E30000200422O0100110004263O00422O0100203B000400030046001285001200363O00202O00120012003700122O0013000B3O00202O00140004002B00202O00140014000F00202O0014001400474O00130002000200202O00130013004800122O001400146O0012001400024O000500123O00122O001100033O000E300001002F2O0100110004263O002F2O0100124A001200493O00204200120012001700122O0013004A6O00148O0012001400024O000200123O00122O0012000C3O00202O00120012000D00122O0014004B6O0012001400024O000300123O00122O001100023O00044O002F2O010004263O001A00010004263O00542O010004263O000200012O006C3O00013O000D3O00073O00028O0003073O006265647761727303123O00436C69656E7448616E646C657253746F726503083O00676574537461746503043O0047616D6503093O00717565756554797065030C3O00626564776172735F7465737400113O0012083O00014O0056000100013O0026033O0002000100010004263O0002000100124A000200023O00208300020002000300202O0002000200044O0002000200024O000100023O00202O00020001000500202O00020002000600062O0002000E000100010004263O000E0001001208000200074O0023000200023O0004263O000200012O006C3O00017O000A3O00028O00026O00F03F03043O006D61746803053O00726F756E6403013O005A026O00084003073O00566563746F72332O033O006E657703013O005803013O0059012F3O001208000100014O0056000200043O001208000500013O00260300050003000100010004263O0003000100260300010014000100020004263O0014000100124A000600033O00208D00060006000400202O00073O000500202O0007000700064O0006000200024O000400063O00122O000600073O00202O0006000600084O000700026O000800036O000900046O000600096O00065O00260300010002000100010004263O00020001001208000600013O00260300060026000100010004263O0026000100124A000700033O00208200070007000400202O00083O000900202O0008000800064O0007000200024O000200073O00122O000700033O00202O00070007000400202O00083O000A00202O0008000800064O0007000200024O000300073O00122O000600023O000E3000020017000100060004263O00170001001208000100023O0004263O000200010004263O001700010004263O000200010004263O000300010004263O000200012O006C3O00017O00053O0003073O006265647761727303123O00436C69656E7448616E646C657253746F726503083O00676574537461746503043O0047616D65030A3O006D61746368537461746500083O0012693O00013O00206O000200206O00036O0002000200206O000400206O00056O00028O00017O00013O0003053O0076616C756501044O004800013O0001001009000100014O0023000100024O006C3O00017O000F3O00028O00027O0040026O00F03F03053O006974656D7303053O0061726D6F7203093O00436861726163746572030E3O0046696E6446697273744368696C64030F3O00496E76656E746F7279466F6C64657203043O006E65787403063O00747970656F6603053O007461626C6503083O006974656D5479706503083O00696E7374616E636503053O0056616C756503053O007063612O6C017D3O001208000100014O0056000200033O000E3000020005000100010004263O000500012O0023000300023O000E300003006A000100010004263O006A00010006320002000F000100010004263O000F00012O004800043O00022O006E00055O00102O0004000400054O00055O00102O0004000500054O000400023O00203B00043O00060006980004006900013O0004263O0069000100203B00043O000600209B000400040007001208000600084O00A20004000600020006980004006900013O0004263O00690001001208000400014O0056000500063O000E3000030063000100040004263O006300010026030005004E000100030004263O004E000100124A000700094O009D000800034O0056000900093O0004263O004B0001001208000C00014O0056000D000D3O002603000C0024000100010004263O00240001001208000D00013O002603000D0027000100010004263O0027000100124A000E00094O009D000F000B4O0056001000103O0004263O0039000100124A0013000A4O009D001400124O009E001300020002002603001300390001000B0004263O0039000100203B00130012000C0006980013003900013O0004263O0039000100209B00130006000700203B00150012000C2O00A20013001500020010090012000D001300067D000E002D000100020004263O002D000100124A000E000A4O009D000F000B4O009E000E00020002002603000E004B0001000B0004263O004B000100203B000E000B000C000698000E004B00013O0004263O004B000100209B000E0006000700203B0010000B000C2O00A2000E00100002001009000B000D000E0004263O004B00010004263O002700010004263O004B00010004263O0024000100067D00070022000100020004263O002200010004263O006900010026030005001C000100010004263O001C0001001208000700013O00260300070055000100030004263O00550001001208000500033O0004263O001C000100260300070051000100010004263O0051000100203B00083O000600202F00080008000700122O000A00086O0008000A000200202O00060008000E00062O0006005F000100010004263O005F00012O0023000300023O001208000700033O0004263O005100010004263O001C00010004263O006900010026030004001A000100010004263O001A0001001208000500014O0056000600063O001208000400033O0004263O001A0001001208000100023O00260300010002000100010004263O000200010006323O0074000100010004263O007400012O004800043O00022O006E00055O00102O0004000400054O00055O00102O0004000500054O000400023O00124A0004000F3O00064000053O000100012O009D8O004D0004000200054O000300056O000200043O00122O000100033O00044O000200012O006C3O00013O00013O00093O0003073O007265717569726503043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503023O00545303093O00696E76656E746F7279030E3O00696E76656E746F72792D7574696C030D3O00496E76656E746F72795574696C030C3O00676574496E76656E746F7279000F3O00127F3O00013O00122O000100023O00202O00010001000300122O000300046O00010003000200202O00010001000500202O00010001000600202O0001000100076O0002000200206O000800206O00094O00019O0000019O008O00017O00053O00028O0003043O006E65787403053O006974656D7303083O006974656D5479706503043O0066696E64011C3O001208000100013O00260300010001000100010004263O0001000100124A000200024O005900038O000400016O00030002000200202O0003000300034O000400043O00044O0016000100203B0007000600040006210007001300013O0004263O0013000100203B00070006000400209B0007000700052O009D00096O00A20007000900020006980007001600013O0004263O001600012O009D000700064O009D000800054O002B000700033O00067D0002000A000100020004263O000A00012O0056000200024O0023000200023O0004263O000100012O006C3O00017O00063O00028O00026O00F03F023O00C088C300C203043O006E65787403053O006974656D73012O005A3O0012083O00014O0056000100033O0026033O0007000100010004263O00070001001208000100014O0056000200023O0012083O00023O000E300002000200013O0004263O000200012O0056000300033O001208000400013O0026030004000B000100010004263O000B000100260300010051000100010004263O00510001001208000500013O00260300050014000100020004263O00140001001208000100023O0004263O0051000100260300050010000100010004263O00100001001208000600034O0041000300036O000200063O00122O000600046O00078O000800016O00070002000200202O0007000700054O000800083O00044O004D0001001208000B00014O0056000C000D3O002603000B0027000100010004263O00270001001208000C00014O0056000D000D3O001208000B00023O000E30000200220001000B0004263O00220001002603000C003C000100010004263O003C0001001208000E00014O003C000F00013O00064000103O000100062O009D3O000E4O009D3O000C4O009D3O000F4O009D3O000D4O00453O00024O009D3O000A3O002603000F0037000100060004263O003700010004263O003A00012O009D001100104O000F0011000100010004263O003400012O0076000F6O0076000E5O002603000C0029000100020004263O002900010006460002004B0001000D0004263O004B0001001208000E00013O002603000E0041000100010004263O004100012O009D0003000A4O009D0002000D3O0004263O004B00010004263O004100010004263O004B00010004263O002900010004263O004B00010004263O002200012O0076000B6O007600095O00067D00060020000100020004263O00200001001208000500023O0004263O00100001000E300002000A000100010004263O000A00012O0023000300023O0004263O000A00010004263O000B00010004263O000A00010004263O005900010004263O000200012O006C3O00013O00013O00053O00026O00F03F028O0003053O007461626C6503043O0066696E6403083O006974656D54797065001A4O00457O0026033O0008000100010004263O000800010012083O00014O00873O00014O003C8O00873O00024O006C3O00014O00457O0026035O000100020004265O000100124A3O00033O0020185O00044O000100046O000200053O00202O0002000200056O000200026O00038O00033O00064O0016000100010004263O001600012O006C3O00013O0012083O00014O00877O0004265O00012O006C3O00017O00103O0003093O00436861726163746572030B3O0048616E64496E764974656D03053O0056616C756503043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F72616765030D3O0072627874735F696E636C756465030C3O006E6F64655F6D6F64756C6573030E3O0046696E6446697273744368696C6403063O004072627874732O033O006E65742O033O006F7574030B3O005F4E65744D616E61676564030A3O00536574496E764974656D030C3O00496E766F6B6553657276657203043O0068616E6401184O002D00015O00202O00010001000100202O00010001000200202O00010001000300062O0001001700013O0004263O0017000100124A000100043O0020A000010001000500122O000300066O00010003000200202O00010001000700202O00010001000800202O00010001000900122O0003000A6O00010003000200202O00010001000B00202O00010001000C00202O00010001000D00202O00010001000E00202O00010001000F4O00033O000100102O000300106O0001000300012O006C3O00017O00103O0003043O006D61746803043O006875676503043O006E657874030A3O00476574506C617965727303043O005465616D03073O004973416C69766503093O0043686172616374657203153O0046696E6446697273744368696C644F66436C612O73030A3O00466F7263654669656C64028O00026O00F03F03153O0044697374616E636546726F6D43686172616374657203083O0048756D616E6F696403083O00522O6F745061727403063O00434672616D6503013O007000443O001267000100013O00202O00010001000200122O000200036O00035O00202O0003000300044O00030002000400044O0040000100203B0007000600052O0045000800013O00203B00080008000500062100070040000100080004263O0040000100124A000700064O009D000800064O009E0007000200020006980007004000013O0004263O0040000100203B00070006000700209B000700070008001208000900094O00A200070009000200063200070040000100010004263O004000010012080007000A4O0056000800093O0026030007001E0001000A0004263O001E00010012080008000A4O0056000900093O0012080007000B3O002603000700190001000B0004263O00190001002603000800200001000A0004263O002000012O0045000A00013O00201F000A000A000C00202O000C0006000700202O000C000C000800122O000E000D6O000C000E000200202O000C000C000E00202O000C000C000F00202O000C000C00104O000A000C00024O0009000A3O00062O00090040000100010004263O00400001001208000A000A4O0056000B000B3O002603000A00310001000A0004263O00310001001208000B000A3O002603000B00340001000A0004263O003400012O009D3O00064O009D000100093O0004263O004000010004263O003400010004263O004000010004263O003100010004263O004000010004263O002000010004263O004000010004263O0019000100067D00020007000100020004263O000700012O00233O00024O006C3O00017O00113O0003053O00706169727303043O0067616D65030A3O004765745365727669636503093O00576F726B7370616365030B3O004765744368696C6472656E03063O00737472696E6703053O006C6F77657203043O004E616D652O033O00626564030E3O0046696E6446697273744368696C6403063O00436F766572730003053O00436F6C6F7203043O005465616D03093O005465616D436F6C6F7203053O007461626C6503063O00696E7365727400274O00847O00122O000100013O00122O000200023O00202O00020002000300122O000400046O00020004000200202O0002000200054O000200036O00013O000300044O0023000100124A000600063O00203B00060006000700203B0007000500082O009E00060002000200260300060023000100090004263O0023000100209B00060005000A0012080008000B4O00A2000600080002002674000600230001000C0004263O0023000100209B00060005000A00128B0008000B6O00060008000200202O00060006000D4O00075O00202O00070007000E00202O00070007000F00062O00060023000100070004263O0023000100124A000600103O00203B0006000600112O009D00076O009D000800054O005500060008000100067D0001000A000100020004263O000A00012O00233O00024O006C3O00017O00033O0003093O00776F726B7370616365030D3O0043752O72656E7443616D657261030D3O0043616D6572615375626A65637401043O00124A000100013O00203B000100010002001009000100034O006C3O00017O00093O00028O00026O00F03F03093O00436861726163746572030E3O0046696E6446697273744368696C6403043O004865616403083O0048756D616E6F6964027O004003063O004865616C746802295C8FC2F528BC3F01503O001208000100014O0056000200023O00260300010002000100010004263O00020001001208000200013O001208000300013O0026030003001C000100020004263O001C000100260300020005000100010004263O00050001001208000400013O00260300040016000100010004263O001600010006323O0010000100010004263O001000012O00457O00203B00053O000300063200050015000100010004263O001500012O003C00056O0023000500023O001208000400023O0026030004000B000100020004263O000B0001001208000200023O0004263O000500010004263O000B00010004263O0005000100260300030006000100010004263O0006000100260300020039000100020004263O00390001001208000400013O00260300040034000100010004263O0034000100203B00053O000300209B000500050004001208000700054O00A20005000700020006320005002B000100010004263O002B00012O003C00056O0023000500023O00203B00053O000300209B000500050004001208000700064O00A200050007000200063200050033000100010004263O003300012O003C00056O0023000500023O001208000400023O00260300040021000100020004263O00210001001208000200073O0004263O003900010004263O002100010026030002004A000100070004263O004A0001001208000400013O0026030004003C000100010004263O003C000100203B00053O000300204B00050005000400122O000700066O00050007000200202O00050005000800262O00050047000100090004263O004700012O003C00056O0023000500024O003C000500014O0023000500023O0004263O003C0001001208000300023O0004263O000600010004263O000500010004263O004F00010004263O000200012O006C3O00017O00323O00030D3O004B692O6C6175726152616E6765026O00344003043O007461736B03043O0077616974030D3O004765744D617463685374617465028O0003053O00706169727303043O0067616D65030A3O004765745365727669636503073O00506C6179657273030B3O004765744368696C6472656E03043O005465616D03073O004973416C69766503093O0043686172616374657203153O0046696E6446697273744368696C644F66436C612O73030A3O00466F7263654669656C64026O00F03F030E3O0046696E6446697273744368696C6403103O0048756D616E6F6964522O6F745061727403083O00506F736974696F6E03093O004D61676E697475646503113O00542O6F6C636865636B4B692O6C6175726103043O00742O6F6C00030D3O004B692O6C6175726153702O656403053O00737061776E03113O005265706C69636174656453746F72616765030D3O0072627874735F696E636C756465030C3O006E6F64655F6D6F64756C657303063O004072627874732O033O006E65742O033O006F7574030B3O005F4E65744D616E6167656403083O0053776F7264486974030A3O0046697265536572766572030D3O0063686172676564412O7461636B030B3O00636861726765526174696F030E3O00656E74697479496E7374616E636503083O0076616C6964617465030E3O00746172676574506F736974696F6E03083O006861736846756E63030C3O0073656C66506F736974696F6E026O002C4003063O00434672616D6503063O006C2O6F6B4174030A3O004C2O6F6B566563746F72026O00104003073O00566563746F72332O033O006E657703063O00776561706F6E00B73O0012083O00023O0012863O00013O00124A3O00033O00200E5O00046O0001000100124O00058O0001000200264O0002000100060004263O0002000100124A3O00033O00203B5O00042O00433O000100020006983O00B600013O0004263O00B6000100124A3O00073O001262000100083O00202O00010001000900122O0003000A6O00010003000200202O00010001000B4O000100029O00000200044O00B3000100203B00050004000C2O004500065O00203B00060006000C000621000500B3000100060004263O00B3000100124A0005000D4O009D000600044O009E000500020002000698000500B300013O0004263O00B3000100124A0005000D4O004500066O009E000500020002000698000500B300013O0004263O00B3000100203B00050004000E00209B00050005000F001208000700104O00A2000500070002000632000500B3000100010004263O00B30001001208000500064O0056000600073O00260300050033000100060004263O00330001001208000600064O0056000700073O001208000500113O0026030005002E000100110004263O002E0001000E3000060035000100060004263O0035000100203B00080004000E00209A00080008001200122O000A00136O0008000A000200202O0008000800144O00095O00202O00090009000E00202O00090009001200122O000B00136O0009000B000200202O0009000900144O00080008000900202O00070008001500122O000800013O00062O000700B3000100080004263O00B300012O0045000800014O004300080001000200124A000900163O0006320009004F000100010004263O004F00012O0045000900023O00203B000A000800172O0020000900020001002674000800AD000100180004263O00AD00012O003C000900013O001286000900193O00124A0009001A3O000640000A3O000100042O00458O00453O00034O00453O00044O00453O00054O004900090002000100122O000900083O00202O00090009000900122O000B001B6O0009000B000200202O00090009001C00202O00090009001D00202O00090009001200122O000B001E6O0009000B000200202O00090009001F00202O00090009002000202O00090009002100202O00090009002200202O0009000900234O000B3O00044O000C3O000100302O000C0025000600102O000B0024000C00202O000C0004000E00102O000B0026000C4O000C3O000200122O000D00293O00202O000E0004000E00202O000E000E001200122O001000136O000E0010000200202O000E000E00144O000D0002000200102O000C0028000D00122O000D00296O000E5O00202O000E000E000E00202O000E000E001200122O001000136O000E0010000200202O000E000E00144O000F5O00202O000F000F000E00202O000F000F001200122O001100136O000F0011000200202O000F000F001400202O00100004000E00202O00100010001200122O001200136O00100012000200202O0010001000144O000F000F001000202O000F000F0015000E2O002B009F0001000F0004263O009F000100124A000F002C3O002012000F000F002D4O00105O00202O00100010000E00202O00100010001200122O001200136O00100012000200202O00100010001400202O00110004000E00202O00110011001200122O001300136O00110013000200202O0011001100144O000F0011000200202O000F000F002E00202O000F000F002F00062O000F00A5000100010004263O00A5000100124A000F00303O00208F000F000F003100122O001000063O00122O001100063O00122O001200066O000F001200022O0051000E000E000F2O0007000D0002000200102O000C002A000D00102O000B0027000C00202O000C0008001700102O000B0032000C4O0009000B000100044O00B300012O003C00095O001286000900193O0004263O00B300010004263O003500010004263O00B300010004263O002E000100067D3O0017000100020004263O001700010004263O000900012O006C3O00013O00013O001F3O00028O00026O00F03F03093O00436861726163746572030E3O0046696E6446697273744368696C6403083O0048756D616E6F696403083O00416E696D61746F72030D3O004C6F6164416E696D6174696F6E03043O00506C6179027O004003103O00436F7374756D416E696D6174696F6E7303053O00706169727303043O00536C6F7703043O0067616D65030A3O0047657453657276696365030C3O0054772O656E5365727669636503063O0043726561746503093O00566965776D6F64656C03093O00526967687448616E64030A3O005269676874577269737403093O0054772O656E496E666F2O033O006E657703043O0054696D6503023O00433003063O00434672616D6503043O007461736B03043O0077616974027B14AE47E17A843F03083O00496E7374616E636503093O00416E696D6174696F6E030B3O00416E696D6174696F6E496403173O00726278612O73657469643A2O2F3439343731303833313400703O0012083O00014O0056000100033O0026033O0069000100020004263O006900012O0056000300033O00260300010016000100020004263O001600012O004500045O00201E00040004000300202O00040004000400122O000600056O00040006000200202O00040004000400122O000600066O0004000600024O000300043O00202O0004000300074O000600026O00040006000200202O0004000400084O00040002000100122O000100093O00260300010056000100090004263O0056000100124A0004000A3O0006980004006F00013O0004263O006F0001001208000400013O00260300040021000100020004263O002100012O003C000500013O0012860005000A3O0004263O006F00010026030004001C000100010004263O001C0001001208000500013O000E3000020028000100050004263O00280001001208000400023O0004263O001C0001000E3000010024000100050004263O002400012O003C00065O00124C0006000A3O00122O0006000B6O000700013O00202O00070007000C4O00060002000800044O00500001001208000B00013O002603000B0032000100010004263O0032000100124A000C000D3O002066000C000C000E00122O000E000F6O000C000E000200202O000C000C00104O000E00023O00202O000E000E001100202O000E000E001200202O000E000E001300122O000F00143O00202O000F000F001500202O0010000A00164O000F000200024O00103O00014O001100033O00202O0012000A00184O00110011001200102O0010001700114O000C0010000200202O000C000C00084O000C0002000100122O000C00193O00202O000C000C001A00202O000D000A001600202O000D000D001B4O000C0002000100044O005000010004263O0032000100067D00060031000100020004263O00310001001208000500023O0004263O002400010004263O001C00010004263O006F000100260300010005000100010004263O00050001001208000400013O000E300002005D000100040004263O005D0001001208000100023O0004263O00050001000E3000010059000100040004263O0059000100124A0005001C3O00208E00050005001500122O0006001D6O0005000200024O000200053O00302O0002001E001F00122O000400023O00044O005900010004263O000500010004263O006F00010026033O0002000100010004263O00020001001208000100014O0056000200023O0012083O00023O0004263O000200012O006C3O00017O000C3O00028O00026O00F03F027O004003083O00496E7374616E63652O033O006E6577030B3O004C6F63616C53637269707403043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203063O00506172656E7403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E65637400333O0012083O00014O0056000100043O0026033O0007000100010004263O00070001001208000100014O0056000200023O0012083O00023O0026033O000B000100020004263O000B00012O0056000300043O0012083O00033O000E300003000200013O0004263O0002000100260300010019000100010004263O0019000100124A000500043O00202400050005000500122O000600066O00078O0005000700024O000200053O00122O000500073O00202O00050005000800202O00030005000900122O000100023O00260300010027000100020004263O00270001001208000500013O00260300050022000100010004263O002200012O0056000400043O00064000043O000100012O009D3O00033O001208000500023O0026030005001C000100020004263O001C0001001208000100033O0004263O002700010004263O001C00010026030001000D000100030004263O000D000100203B00050002000A0020A500050005000B00202O00050005000C4O000700046O00050007000100044O003200010004263O000D00010004263O003200010004263O000200012O006C3O00013O00013O00363O00028O00027O0040026O00F03F03063O00506172656E74026O000840030A3O0043616E436F2O6C696465010003083O00496E7374616E63652O033O006E657703093O00426C6F636B4D65736803043O005061727403093O0043686172616374657203043O004E616D6503043O0043617065026O001840030C3O0044657369726564416E676C65023O00C079A8B9BF026O001C4003053O005061727430030C3O0043752O72656E74416E676C65023O00604ABFC4BF03043O0053697A6503073O00566563746F7233029A5O99C93F027B14AE47E17AB43F03083O004D6174657269616C03043O00456E756D030D3O00536D2O6F7468506C617374696303053O00436F6C6F7203063O00436F6C6F723302AE2D3C2F151BBB3F03053O00446563616C026O002040026O00144003023O00433003063O00434672616D65023O00C0A57767BE026O00F0BF03023O00433102DF43EABF2OCCDC3F03053O005061727431030A3O00552O706572546F72736F026O00104003053O004D6F746F7203043O004D65736803053O005363616C65026O002240025O00803140026O00E03F030B3O00566572746578436F6C6F7203043O004661636503083O004E6F726D616C496403043O004261636B03073O005465787475726501BA3O001208000100014O0056000200053O00260300010014000100020004263O00140001001208000600013O0026030006000A000100030004263O000A0001001009000300040002001208000100053O0004263O0014000100260300060005000100010004263O00050001003005000200060007001247000700083O00202O00070007000900122O0008000A6O0007000200024O000300073O00122O000600033O00044O00050001000E3000010028000100010004263O00280001001208000600013O00260300060022000100010004263O0022000100124A000700083O00208000070007000900122O0008000B6O0007000200024O000200076O00075O00202O00070007000C00102O00020004000700122O000600033O00260300060017000100030004263O001700010030050002000D000E001208000100033O0004263O002800010004263O00170001002603000100360001000F0004263O00360001001208000600013O00260300060030000100030004263O00300001003005000400100011001208000100123O0004263O003600010026030006002B000100010004263O002B0001001009000400130002003005000400140015001208000600033O0004263O002B000100260300010053000100030004263O00530001001208000600013O000E3000010047000100060004263O0047000100124A000700173O00208F00070007000900122O000800183O00122O000900183O00122O000A00196O0007000A000200109900020016000700122O0007001B3O00202O00070007001A00202O00070007001C00102O0002001A000700122O000600033O00260300060039000100030004263O0039000100124A0007001E3O00208F00070007000900122O0008001F3O00122O0009001F3O00122O000A001F6O0007000A00020010090002001D0007001208000100023O0004263O005300010004263O00390001000E3000120065000100010004263O00650001001208000600013O000E300003005B000100060004263O005B00010030050005000D0020001208000100213O0004263O0065000100260300060056000100010004263O0056000100124A000700083O00203700070007000900122O000800206O0007000200024O000500073O00102O00050004000200122O000600033O00044O005600010026030001008C000100220004263O008C000100124A000600243O0020A800060006000900122O000700013O00122O000800023O00122O000900013O00122O000A00253O00122O000B00013O00122O000C00033O00122O000D00013O00122O000E00033O00122O000F00013O00122O001000263O00122O001100013O00122O001200256O00060012000200102O00040023000600122O000600243O00202O00060006000900122O000700013O00122O000800033O00122O000900283O00122O000A00253O00122O000B00013O00122O000C00033O00122O000D00013O00122O000E00033O00122O000F00013O00122O001000263O00122O001100013O00122O001200256O00060012000200102O0004002700064O00065O00202O00060006000C00202O00060006002A00102O00040029000600122O0001000F3O0026030001009E0001002B0004263O009E0001001208000600013O00260300060098000100010004263O0098000100124A000700083O00208100070007000900122O0008002C6O0007000200024O000400073O00102O00040004000200122O000600033O0026030006008F000100030004263O008F00010030050004000D002C001208000100223O0004263O009E00010004263O008F0001002603000100B0000100050004263O00B000010030050003000D002D00123D000600173O00202O00060006000900122O0007002F3O00122O000800303O00122O000900316O00060009000200102O0003002E000600122O000600173O00202O00060006000900122O000700033O00122O000800033O00122O000900036O00060009000200102O00030032000600122O0001002B3O000E3000210002000100010004263O0002000100124A0006001B3O0020A300060006003400202O00060006003500102O00050033000600102O000500363O00044O00B900010004263O000200012O006C3O00017O000E3O00028O00026O00F03F03063O00506172656E74030E3O0046696E6446697273744368696C6403093O004861636B4672616D6503043O007761726E03133O004861636B4672616D65206E6F7420666F756E64027O0040026O00084003083O00496E7374616E63652O033O006E6577030B3O004C6F63616C53637269707403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E65637400373O0012083O00014O0056000100043O0026033O001E000100020004263O001E000100203B00050002000300203F00050005000400122O000700056O0005000700024O000300053O00062O0003001D000100010004263O001D0001001208000500014O0056000600063O0026030005000D000100010004263O000D0001001208000600013O00260300060010000100010004263O00100001001208000700013O000E3000010013000100070004263O0013000100124A000800063O001208000900074O00200008000200012O006C3O00013O0004263O001300010004263O001000010004263O001D00010004263O000D00010012083O00083O0026033O0024000100080004263O002400012O0056000400043O00064000043O000100012O009D3O00033O0012083O00093O000E300001002E00013O0004263O002E000100124A0005000A3O00207800050005000B00122O0006000C6O00078O0005000700024O000100053O00202O00020001000300124O00023O0026033O0002000100090004263O0002000100203B00050002000D00209B00050005000E2O009D000700044O00550005000700010004263O003600010004263O000200012O006C3O00013O00013O00013O0003073O0056697369626C6500064O00609O0000015O00202O0001000100014O000100013O00104O000100016O00017O000D3O00028O00026O00F03F027O0040026O000840026O00104003043O007761697403083O00496E7374616E63652O033O006E6577030B3O004C6F63616C536372697074026O00374003063O00506172656E7403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E65637400603O0012083O00014O0056000100063O0026033O0007000100010004263O00070001001208000100014O0056000200023O0012083O00023O000E300002000B00013O0004263O000B00012O0056000300043O0012083O00033O0026033O005A000100040004263O005A00010026030001001C000100030004263O001C0001001208000700013O00260300070017000100010004263O0017000100064000053O000100022O009D3O00044O009D3O00034O0056000600063O001208000700023O00260300070010000100020004263O00100001001208000100043O0004263O001C00010004263O0010000100260300010029000100020004263O00290001001208000700013O00260300070023000100020004263O00230001001208000100033O0004263O002900010026030007001F000100010004263O001F00012O003C00046O0056000500053O001208000700023O0004263O001F000100260300010033000100050004263O0033000100124A000700064O00430007000100020006980007005F00013O0004263O005F00012O009D000700064O000F0007000100010004263O002B00010004263O005F000100260300010045000100010004263O00450001001208000700013O0026030007003A000100020004263O003A0001001208000100023O0004263O0045000100260300070036000100010004263O0036000100124A000800073O00205E00080008000800122O000900096O000A8O0008000A00024O000200083O00122O0003000A3O00122O000700023O00044O003600010026030001000D000100040004263O000D0001001208000700013O0026030007004C000100020004263O004C0001001208000100053O0004263O000D000100260300070048000100010004263O0048000100064000060001000100022O009D3O00044O009D3O00033O00209300080002000B00202O00080008000C00202O00080008000D4O000A00056O0008000A000100122O000700023O00044O004800010004263O000D00010004263O005F0001000E300003000200013O0004263O000200012O0056000500063O0012083O00043O0004263O000200012O006C3O00013O00023O00083O00028O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203083O0048756D616E6F696403093O0057616C6B53702O6564026O003040002C4O00457O0006983O001700013O0004263O001700010012083O00014O0056000100013O0026033O0005000100010004263O00050001001208000100013O00260300010008000100010004263O000800012O003C00026O003900025O00122O000200023O00202O00020002000300202O00020002000400202O00020002000500202O00020002000600302O00020007000800044O002B00010004263O000800010004263O002B00010004263O000500010004263O002B00010012083O00014O0056000100013O0026033O0019000100010004263O00190001001208000100013O0026030001001C000100010004263O001C00012O003C000200014O001900025O00122O000200023O00202O00020002000300202O00020002000400202O00020002000500202O0002000200064O000300013O00102O00020007000300044O002B00010004263O001C00010004263O002B00010004263O001900012O006C3O00017O000F3O00028O00026O00F03F03043O0067616D65030A3O004765745365727669636503073O00506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030E3O0046696E6446697273744368696C6403083O0048756D616E6F696403093O00776F726B7370616365030D3O0043752O72656E7443616D65726103063O00434672616D65030A3O004C2O6F6B566563746F7203103O0048756D616E6F6964522O6F745061727403083O0056656C6F6369747900243O0012083O00014O0056000100023O0026033O0007000100010004263O00070001001208000100014O0056000200023O0012083O00023O0026033O0002000100020004263O0002000100260300010009000100010004263O0009000100124A000300033O00207700030003000400122O000500056O00030005000200202O00030003000600202O0002000300074O00035O00062O0003002300013O0004263O0023000100209B000300020008001225000500096O00030005000200122O0004000A3O00202O00040004000B00202O00050004000C00202O00050005000D4O000600016O00060005000600202O00070002000E00102O0007000F000600044O002300010004263O000900010004263O002300010004263O000200012O006C3O00017O001B3O00028O00027O0040026O000840026O00F03F026O00104003063O00506172656E7403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E65637403043O0067616D65030A3O004765745365727669636503073O00506C6179657273030C3O0054772O656E5365727669636503103O0055736572496E7075745365727669636503083O004C69676874696E67030C3O0057616974466F724368696C64031B3O0044656661756C744368617453797374656D436861744576656E747303113O005361794D652O736167655265717565737403053O005374617473030B3O00482O747053657276696365030A3O0052756E5365727669636503093O00576F726B737061636503083O00496E7374616E63652O033O006E6577030B3O004C6F63616C536372697074030B3O004C6F63616C506C6179657203113O00436F2O6C656374696F6E5365727669636503113O005265706C69636174656453746F7261676500993O0012083O00014O0056000100103O0026033O0006000100020004263O000600012O00560009000C3O0012083O00033O0026033O000B000100010004263O000B0001001208000100014O0056000200043O0012083O00043O0026033O000F000100040004263O000F00012O0056000500083O0012083O00023O0026033O0093000100050004263O00930001000E300005001B000100010004263O001B000100064000103O000100012O009D3O000F3O00207A00110002000600202O00110011000700202O0011001100084O001300106O00110013000100044O00980001000E300004003D000100010004263O003D0001001208001100013O00260300110022000100020004263O00220001001208000100023O0004263O003D00010026030011002F000100040004263O002F000100124A001200093O00200400120012000A00122O0014000B6O0012001400024O000800123O00122O001200093O00202O00120012000A00122O0014000C6O0012001400024O000900123O00122O001100023O0026030011001E000100010004263O001E000100124A001200093O00200400120012000A00122O0014000D6O0012001400024O000600123O00122O001200093O00202O00120012000A00122O0014000E6O0012001400024O000700123O00122O001100043O0004263O001E000100260300010056000100030004263O00560001001208001100013O0026030011004B000100010004263O004B000100209B00120005000F001253001400106O00120014000200202O00120012000F00122O001400116O0012001400024O000E00126O000F000F3O00122O001100043O000E300002004F000100110004263O004F0001001208000100053O0004263O0056000100260300110040000100040004263O00400001000640000F0001000100012O009D3O000E4O0056001000103O001208001100023O0004263O004000010026030001007B000100020004263O007B0001001208001100013O00260300110066000100010004263O0066000100124A001200093O00200400120012000A00122O001400126O0012001400024O000A00123O00122O001200093O00202O00120012000A00122O001400136O0012001400024O000B00123O00122O001100043O0026030011006A000100020004263O006A0001001208000100033O0004263O007B000100260300110059000100040004263O0059000100124A001200093O00200A00120012000A00122O001400146O0012001400024O000C00123O00122O001200093O00202O00120012000A00122O001400156O00120014000200062O000D0079000100120004263O0079000100124A001200093O00203B000D00120015001208001100023O0004263O00590001000E3000010011000100010004263O0011000100124A001100163O00201500110011001700122O001200186O00138O0011001300024O000200113O00122O001100093O00202O00110011000B00202O00030011001900122O001100093O00202O00110011000A00122O0013001A6O0011001300024O000400113O00122O001100093O00202O00110011000A00122O0013001B6O0011001300024O000500113O00122O000100043O00044O001100010004263O009800010026033O0002000100030004263O000200012O0056000D00103O0012083O00053O0004263O000200012O006C3O00013O00023O00113O00028O00026O00F03F026O000840026O00104003363O004920616D206E6F74206368656174696E672C206D792067616D696E672063686169722069732E207C204F787967656E204F6E20546F7003223O004F787967656E204F6E2054686520546F702E207C204F787967656E204F6E20546F7003043O0077616974029A5O99B93F03043O006D61746803063O0072616E646F6D026O001440027O004003153O00F09F92802E207C204F787967656E204F6E20546F70031A3O00472O6F642047616D652E207C204F787967656E204F6E20546F7003233O004F787967656E2054686520233120426573742E207C204F787967656E204F6E20546F70034O0003133O00617761207C204F787967656E204F6E20546F7000553O0012083O00014O0056000100033O0026033O004D000100020004263O004D00012O0056000300033O00260300010016000100030004263O00160001001208000400013O0026030004000C000100020004263O000C0001001208000100043O0004263O0016000100260300040008000100010004263O0008000100260300020011000100030004263O00110001001208000300053O00260300020014000100040004263O00140001001208000300063O001208000400023O0004263O0008000100260300010022000100010004263O0022000100124A000400073O00123E000500086O00040002000100122O000400093O00202O00040004000A00122O000500013O00122O0006000B6O0004000600024O000200043O00122O000100023O002603000100330001000C0004263O00330001001208000400013O00260300040029000100020004263O00290001001208000100033O0004263O0033000100260300040025000100010004263O002500010026740002002E000100010004263O002E00010012080003000D3O002603000200310001000C0004263O003100010012080003000E3O001208000400023O0004263O002500010026030001003C000100040004263O003C0001002603000200380001000B0004263O003800010012080003000F4O004500046O009D000500034O00200004000200010004265O000100260300010005000100020004263O00050001001208000400013O00260300040043000100020004263O004300010012080001000C3O0004263O000500010026030004003F000100010004263O003F0001001208000300103O00260300020049000100010004263O00490001001208000300113O001208000400023O0004263O003F00010004263O000500010004265O00010026033O0002000100010004263O00020001001208000100014O0056000200023O0012083O00023O0004263O000200010004265O00012O006C3O00017O00063O00028O00026O00F03F027O00402O033O00412O6C030A3O004669726553657276657203063O00756E7061636B011A3O001208000100014O0056000200033O00260300010007000100010004263O00070001001208000200014O0056000300033O001208000100023O00260300010002000100020004263O0002000100260300020009000100010004263O000900012O004800043O000200107B000400023O00302O0004000300044O000300046O00045O00202O00040004000500122O000600066O000700036O000600076O00043O000100044O001900010004263O000900010004263O001900010004263O000200012O006C3O00017O00", GetFEnv(), ...);
