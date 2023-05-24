From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared memory
Date: Tue, 23 May 2023 23:46:27 -0700
Message-ID: <ZG2yw0xZ6XGGp9E5@infradead.org>
In-Reply-To: <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5955116677447528222=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5955116677447528222==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, May 23, 2023 at 11:13:47AM +0200, Arnaud Pouliquen wrote:
> This patch revert commit c83900393aa1 ("tee: Remove vmalloc page support")

As per the discussion back then: don't just blindly do the same dumb
thing again and fix the interfae to actually pass in a page array,
or iov_iter or an actually useful container that fits.


--===============5955116677447528222==--

