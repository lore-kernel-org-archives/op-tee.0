From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: Do not publish partially initialized shm objects
Date: Thu, 16 Dec 2021 13:42:21 +0100
Message-ID: 
 <CAHUa44E-6BKUh3HZ8RXTmFonxk2JtJvzLtTLs_gvOqMM4ySztA@mail.gmail.com>
In-Reply-To: <b25b56f8-fb76-86a3-daf3-5f623a76ae4a@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5809667944731262340=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5809667944731262340==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Dec 16, 2021 at 10:51 AM Lars Persson <larper@axis.com> wrote:
>
>
>
> On 2021-12-10 11:50, Sumit Garg wrote:
> > On Fri, 10 Dec 2021 at 15:54, Lars Persson <larper@axis.com> wrote:
> >>
> >>
> >>
> >> On 2021-12-09 13:00, Sumit Garg wrote:
> >> > On Tue, 7 Dec 2021 at 15:28, Lars Persson <larper@axis.com> wrote:
> >> >>
> >> >> Adding a partially initialized struct tee_shm to teedev->idr makes
> >> >> that object reachable from userspace through TEE_IOC_OPEN_SESSION and
> >> >> TEE_IOC_INVOKE.
> >> >
> >> > Can you elaborate here how this partially initialized shared memory is
> >> > reachable from user-space? AFAICT, TEE_IOC_OPEN_SESSION and
> >> > TEE_IOC_INVOKE relies on shm->id to access underlying shared memory
> >> > (via tee_shm_get_from_id()) and that is only known to user-space after
> >> > TEE_IOC_SHM_ALLOC or TEE_IOC_SHM_REGISTER return successfully.
> >> >
> >>
> >> Hi
> >>
> >> The IDR does not hand out high-entropy identifiers that userspace is
> >> unable to guess. We can very easily provoke NULL pointer dereferences
> >> in the kernel when running syzkaller on the TEE device because
> >> shm->dmabuf has not yet been assigned.
> >>
> >> It is also a general best practice that an object shall only be
> >> available through an API once it is fully initialized. Else undefined
> >> behavior will come back and bite us.
> >>
> >
> > Okay, I see the fuzzing scenario where a kernel crash can be caused.
> > So I take this fix as user-space shouldn't be able to crash the
> > kernel.
> >
> > Please do add all these details to the commit description along with
> > the possible kernel crash trace.
> >
>
>
> After applying "[PATCH] tee: handle lookup of shm with reference count
> 0" my patch is no longer relevant. I will check again if there is any
> race condition left after the dmabuf was removed and submit a new
> version if needed.
>
>

Isn't it still relevant in tee_shm_register()?

Thanks,
Jens

--===============5809667944731262340==--

