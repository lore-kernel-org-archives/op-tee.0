From: Christoph Hellwig <hch@lst.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Fri, 16 Dec 2022 07:06:27 +0000
Message-ID: <20221216070621.GA24832@lst.de>
In-Reply-To: <Y5u+oOLkJs6jehik@iweiny-desk3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3186045511178923311=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3186045511178923311==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Dec 15, 2022 at 04:41:04PM -0800, Ira Weiny wrote:
> Overall I feel like submitting this series again with Christoph and Al's
> comments addressed is the best way forward to get rid of kmap_to_page().  I
> would really like to get moving on that to avoid any further issues with the
> kmap conversions.

Yes.  While the flag is really odd, killing kmap_to_page should be the
priority.


--===============3186045511178923311==--

