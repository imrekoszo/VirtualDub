//	VirtualDub - Video processing and capture application
//	Graphics support library
//	Copyright (C) 1998-2005 Avery Lee
//
//	This program is free software; you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation; either version 2 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program; if not, write to the Free Software
//	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

#ifndef f_VD2_KASUMI_REGION_H
#define f_VD2_KASUMI_REGION_H

struct VDPixmap;

#include <vd2/system/vectors.h>
#include <vector>

class VDPixmapRegion {
public:
	std::vector<uint32> mSpans;
	vdrect32	mBounds;
};

class VDPixmapPathRasterizer {
public:
	VDPixmapPathRasterizer();
	~VDPixmapPathRasterizer();

	void Bezier(const vdvector2i pts[4]);
	void Line(const vdvector2i& pt1, const vdvector2i& pt2);
	void FastLine(int x0, int y0, int x1, int y1);

	void ScanConvert(VDPixmapRegion& region);

protected:
	void ClearEdgeList();
	void ClearScanBuffer();
	void ReallocateScanBuffer(int ymin, int ymax);

	struct Edge {
		Edge *next;
		int posandflag;
	};

	enum { kEdgeBlockMax = 1024 };

	struct EdgeBlock {
		EdgeBlock *next;
		Edge edges[1024];

		EdgeBlock(EdgeBlock *p) : next(p) {}
	};

	struct Scan {
		Edge *chain;
		uint32 count;
	};

	EdgeBlock *mpEdgeBlocks;
	int mEdgeBlockIdx;
	Scan *mpScanBuffer;
	Scan *mpScanBufferBiased;
	int mScanYMin;
	int mScanYMax;
};

bool VDPixmapFillRegion(const VDPixmap& dst, const VDPixmapRegion& region, int x, int y, uint32 color);

#endif
