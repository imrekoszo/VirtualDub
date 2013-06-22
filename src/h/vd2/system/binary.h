//	VirtualDub - Video processing and capture application
//	System library component
//	Copyright (C) 1998-2004 Avery Lee, All Rights Reserved.
//
//	Beginning with 1.6.0, the VirtualDub system library is licensed
//	differently than the remainder of VirtualDub.  This particular file is
//	thus licensed as follows (the "zlib" license):
//
//	This software is provided 'as-is', without any express or implied
//	warranty.  In no event will the authors be held liable for any
//	damages arising from the use of this software.
//
//	Permission is granted to anyone to use this software for any purpose,
//	including commercial applications, and to alter it and redistribute it
//	freely, subject to the following restrictions:
//
//	1.	The origin of this software must not be misrepresented; you must
//		not claim that you wrote the original software. If you use this
//		software in a product, an acknowledgment in the product
//		documentation would be appreciated but is not required.
//	2.	Altered source versions must be plainly marked as such, and must
//		not be misrepresented as being the original software.
//	3.	This notice may not be removed or altered from any source
//		distribution.

#ifndef f_VD2_SYSTEM_BINARY_H
#define f_VD2_SYSTEM_BINARY_H

#define VDMAKEFOURCC(byte1, byte2, byte3, byte4) (((uint8)byte1) + (((uint8)byte2) << 8) + (((uint8)byte3) << 16) + (((uint8)byte4) << 24))

#ifdef _MSC_VER
	unsigned short _byteswap_ushort(unsigned short);
	unsigned long _byteswap_ulong(unsigned long);
	unsigned __int64 _byteswap_uint64(unsigned __int64);

	#pragma intrinsic(_byteswap_ushort)
	#pragma intrinsic(_byteswap_ulong)
	#pragma intrinsic(_byteswap_uint64)

	inline uint16 VDSwizzleU16(uint16 value) { return (uint16)_byteswap_ushort((unsigned short)value); }
	inline sint16 VDSwizzleS16(sint16 value) { return (sint16)_byteswap_ushort((unsigned short)value); }
	inline uint32 VDSwizzleU32(uint32 value) { return (uint32)_byteswap_ulong((unsigned long)value); }
	inline sint32 VDSwizzleS32(sint32 value) { return (sint32)_byteswap_ulong((unsigned long)value); }
	inline uint64 VDSwizzleU64(uint64 value) { return (uint32)_byteswap_uint64((unsigned __int64)value); }
	inline sint64 VDSwizzleS64(sint64 value) { return (sint32)_byteswap_uint64((unsigned __int64)value); }
#else
	inline uint16 VDSwizzleU16(uint16 value) {
		return (value >> 8) + (value >> 8);
	}

	inline sint16 VDSwizzleS16(sint16 value) {
		return (sint16)(((uint16)value >> 8) + ((uint16)value >> 8));
	}

	inline uint32 VDSwizzleU32(uint32 value) {
		return (value >> 24) + (value << 24) + ((value&0xff00)<<8) + ((value&0xff0000)>>8);
	}

	inline sint32 VDSwizzleS32(sint32 value) {
		return (sint32)(((uint32)value >> 24) + ((uint32)value << 24) + (((uint32)value&0xff00)<<8) + (((uint32)value&0xff0000)>>8));
	}

	inline uint64 VDSwizzleU64(uint64 value) {
		return	((value & 0xFF00000000000000) >> 56) +
				((value & 0x00FF000000000000) >> 40) +
				((value & 0x0000FF0000000000) >> 24) +
				((value & 0x000000FF00000000) >>  8) +
				((value & 0x00000000FF000000) <<  8) +
				((value & 0x0000000000FF0000) << 24) +
				((value & 0x000000000000FF00) << 40) +
				((value & 0x00000000000000FF) << 56);
	}

	inline sint64 VDSwizzleS64(sint64 value) {
		return (sint64)((((uint64)value & 0xFF00000000000000) >> 56) +
						(((uint64)value & 0x00FF000000000000) >> 40) +
						(((uint64)value & 0x0000FF0000000000) >> 24) +
						(((uint64)value & 0x000000FF00000000) >>  8) +
						(((uint64)value & 0x00000000FF000000) <<  8) +
						(((uint64)value & 0x0000000000FF0000) << 24) +
						(((uint64)value & 0x000000000000FF00) << 40) +
						(((uint64)value & 0x00000000000000FF) << 56));
	}
#endif

inline uint16 VDReadUnalignedU16(const void *p) { return *(uint16 *)p; }
inline sint16 VDReadUnalignedS16(const void *p) { return *(sint16 *)p; }
inline uint32 VDReadUnalignedU32(const void *p) { return *(uint32 *)p; }
inline sint32 VDReadUnalignedS32(const void *p) { return *(sint32 *)p; }
inline uint64 VDReadUnalignedU64(const void *p) { return *(uint64 *)p; }
inline sint64 VDReadUnalignedS64(const void *p) { return *(sint64 *)p; }

inline uint16 VDReadUnalignedLEU16(const void *p) { return *(uint16 *)p; }
inline sint16 VDReadUnalignedLES16(const void *p) { return *(sint16 *)p; }
inline uint32 VDReadUnalignedLEU32(const void *p) { return *(uint32 *)p; }
inline sint32 VDReadUnalignedLES32(const void *p) { return *(sint32 *)p; }
inline uint64 VDReadUnalignedLEU64(const void *p) { return *(uint64 *)p; }
inline sint64 VDReadUnalignedLES64(const void *p) { return *(sint64 *)p; }

inline uint16 VDReadUnalignedBEU16(const void *p) { return VDSwizzleU16(*(uint16 *)p); }
inline sint16 VDReadUnalignedBES16(const void *p) { return VDSwizzleS16(*(sint16 *)p); }
inline uint32 VDReadUnalignedBEU32(const void *p) { return VDSwizzleU32(*(uint32 *)p); }
inline sint32 VDReadUnalignedBES32(const void *p) { return VDSwizzleS32(*(sint32 *)p); }
inline uint64 VDReadUnalignedBEU64(const void *p) { return VDSwizzleU64(*(uint64 *)p); }
inline sint64 VDReadUnalignedBES64(const void *p) { return VDSwizzleS64(*(sint64 *)p); }

inline void VDWriteUnalignedU16  (void *p, uint16 v) { *(uint16 *)p = v; }
inline void VDWriteUnalignedS16  (void *p, sint16 v) { *(sint16 *)p = v; }
inline void VDWriteUnalignedU32  (void *p, uint32 v) { *(uint32 *)p = v; }
inline void VDWriteUnalignedS32  (void *p, sint32 v) { *(sint32 *)p = v; }
inline void VDWriteUnalignedU64  (void *p, uint64 v) { *(uint64 *)p = v; }
inline void VDWriteUnalignedS64  (void *p, sint64 v) { *(sint64 *)p = v; }

inline void VDWriteUnalignedLEU16(void *p, uint16 v) { *(uint16 *)p = v; }
inline void VDWriteUnalignedLES16(void *p, sint16 v) { *(sint16 *)p = v; }
inline void VDWriteUnalignedLEU32(void *p, uint32 v) { *(uint32 *)p = v; }
inline void VDWriteUnalignedLES32(void *p, sint32 v) { *(sint32 *)p = v; }
inline void VDWriteUnalignedLEU64(void *p, uint64 v) { *(uint64 *)p = v; }
inline void VDWriteUnalignedLES64(void *p, sint64 v) { *(sint64 *)p = v; }

inline void VDWriteUnalignedBEU16(void *p, uint16 v) { *(uint16 *)p = VDSwizzleU16(v); }
inline void VDWriteUnalignedBES16(void *p, sint16 v) { *(sint16 *)p = VDSwizzleS16(v); }
inline void VDWriteUnalignedBEU32(void *p, uint32 v) { *(uint32 *)p = VDSwizzleU32(v); }
inline void VDWriteUnalignedBES32(void *p, sint32 v) { *(sint32 *)p = VDSwizzleS32(v); }
inline void VDWriteUnalignedBEU64(void *p, uint64 v) { *(uint64 *)p = VDSwizzleU64(v); }
inline void VDWriteUnalignedBES64(void *p, sint64 v) { *(sint64 *)p = VDSwizzleS64(v); }

#define VDToLE8(x)		VDSwizzleU8(x)
#define VDToLE16(x)		VDSwizzleU16(x)
#define VDToLE32(x)		VDSwizzleU32(x)
#define VDToBE8(x)		VDSwizzleU8(x)
#define VDToBE16(x)		VDSwizzleU16(x)
#define VDToBE32(x)		VDSwizzleU32(x)

#endif
