From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
Date: Wed, 14 Apr 2021 18:46:46 +0200
Message-ID: 
 <CAHUa44EtLazK8YezYCV7_oGxfarsXv5CfSivqiBecb7=LrYYqQ@mail.gmail.com>
In-Reply-To: <1318f015-40cb-2bdd-17fb-2a3843ed45bc@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8369741944042896723=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8369741944042896723==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiro,

On Mon, Apr 12, 2021 at 12:20 PM Rijo Thomas <Rijo-john.Thomas@amd.com> wro=
te:
>
>
>
> On 12/04/21 1:06 pm, Jens Wiklander wrote:
> > On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> =
wrote:
> >>
> >> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
> >>
> >> If it is a single instance TA, the TA should not get unloaded from AMD
> >> Secure Processor, while it is still in use in another TEE context.
> >>
> >> Therefore reference count TA and unload it when the count becomes zero.
> >>
> >> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> >> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> >> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> >> ---
> >> v2:
> >>  * Unload TA if get_ta_refcount() fails
> >>
> >>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
> >>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
> >>  drivers/tee/amdtee/core.c           | 15 +++--
> >>  3 files changed, 106 insertions(+), 16 deletions(-)
> >
> > Looks good to me. Please address Dan's comment.
> >
>
> Hi Jens,
>
> I have replied to Dan's comment.
>
> If you are okay with the current patch, request you to pull this.

By addressing the comment I meant fixing it not just replying that
you're going to ignore it. :-)
I can't see any reason why the preferred style shouldn't be used.

Cheers,
Jens

--===============8369741944042896723==--

