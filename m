From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 07/12] optee: use driver internal tee_contex for some rpc
Date: Thu, 27 Jan 2022 13:39:10 +0100
Message-ID: 
 <CAHUa44HdOjJCt_1yGKaWXW6rUqo0ZGHBk7Tutwk69iv-7TR+mg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOLRqU4m5RJGJac9AtcpD7pt9Owd7D+XN8GjWRMAPBNuw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2838720232046948455=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2838720232046948455==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 27, 2022 at 7:32 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> +Lars
>
> Hi Jens,
>
> On Tue, 25 Jan 2022 at 21:59, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Uses the new driver internal tee_context when allocating driver private
> > shared memory. This decouples the shared memory object from its original
> > tee_context. This is needed when the life time of such a memory
> > allocation outlives the client tee_context.
> >
> > Fixes: 217e0250cccb ("tee: use reference counting for tee_context")
> > Cc: stable(a)vger.kernel.org
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 17 +++++++++--------
> >  drivers/tee/optee/smc_abi.c |  7 ++++---
> >  2 files changed, 13 insertions(+), 11 deletions(-)
> >
>
> As this commit fixes multiple issues seen earlier due to pre-allocated
> SHM cache in client's context. I think it makes sense to separate this
> as a standalone fix with few bits from patch #6 to target 5.17
> release. As otherwise it will take a long path via 5.18 and then
> backport to stable trees. In the meantime there can be other side
> effects noticed similar to one from Lars.

The few bits needed from #6 is actually the entire "optee: add driver
private tee_context". I'll combine the two and send them as a separate
patch, that way it's easier to keep track of what's needed for the
stable trees.

Thanks,
Jens

--===============2838720232046948455==--

