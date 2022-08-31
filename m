From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 8/9] tee: optee: Drop ffa_ops in optee_ffa structure
Date: Wed, 31 Aug 2022 12:26:52 +0100
Message-ID: <20220831112652.brjnuygzkvcteadx@bogus>
In-Reply-To: <
 <CAFA6WYPXsLt692eW3_tqy+=aLz7W-Ymh-RqZuqATeHpzGp8Tkw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3602373086156428108=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3602373086156428108==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Aug 31, 2022 at 04:28:01PM +0530, Sumit Garg wrote:
> On Tue, 30 Aug 2022 at 15:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Since the ffa_device itself carries ffa_dev_ops now, there is no need
> > to keep a copy in optee_ffa structure.
> >
> > Drop ffa_ops in the optee_ffa structure as it is not needed anymore.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/tee/optee/ffa_abi.c       | 9 ++++-----
> >  drivers/tee/optee/optee_private.h | 1 -
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> 
> Is this patch doing anything different from patch #2? If not then I
> think both should be squashed.
>

Indeed, I thought about squashing them and forgot before getting there.
Does the review tag still apply for 2/9 after I squash this into it.

Thanks for the review.

-- 
Regards,
Sudeep

--===============3602373086156428108==--

