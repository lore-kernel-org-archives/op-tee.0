From: Christoph Hellwig <hch@lst.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Date: Mon, 03 Oct 2022 09:17:18 +0200
Message-ID: <20221003071718.GA1986@lst.de>
In-Reply-To: <YzjfcW6OGcPP075q@ZenIV>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7910869715625934766=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7910869715625934766==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, Oct 02, 2022 at 01:46:41AM +0100, Al Viro wrote:
> IDGI.  The only thing in kiov[...] you are every reading is
> ->iov_base.  And you fetch it once, right after the assignment.

... and that's exactly what I pointed out on the last version of the
patch ...

--===============7910869715625934766==--

