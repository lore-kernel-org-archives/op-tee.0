From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Date: Mon, 03 Oct 2022 08:02:19 -0700
Message-ID: <Yzr5e9tagtsDq4WY@iweiny-mobl>
In-Reply-To: <20221003071718.GA1986@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9075756795907555045=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9075756795907555045==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Oct 03, 2022 at 09:17:18AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 02, 2022 at 01:46:41AM +0100, Al Viro wrote:
> > IDGI.  The only thing in kiov[...] you are every reading is
> > ->iov_base.  And you fetch it once, right after the assignment.
> 
> ... and that's exactly what I pointed out on the last version of the
> patch ...

Apologies I guess I missed it.
Ira


--===============9075756795907555045==--

