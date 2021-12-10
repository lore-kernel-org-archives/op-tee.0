From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: Do not publish partially initialized shm objects
Date: Fri, 10 Dec 2021 16:20:56 +0530
Message-ID: 
 <CAFA6WYOo13FQtLs1DthrapScVtMfH5anB-P8DhMTXe8bQFO1Jw@mail.gmail.com>
In-Reply-To: <8d2bf450-4500-9b00-be51-d82a46035ecc@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4215863635508054680=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4215863635508054680==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 10 Dec 2021 at 15:54, Lars Persson <larper@axis.com> wrote:
>
>
>
> On 2021-12-09 13:00, Sumit Garg wrote:
> > On Tue, 7 Dec 2021 at 15:28, Lars Persson <larper@axis.com> wrote:
> >>
> >> Adding a partially initialized struct tee_shm to teedev->idr makes
> >> that object reachable from userspace through TEE_IOC_OPEN_SESSION and
> >> TEE_IOC_INVOKE.
> >
> > Can you elaborate here how this partially initialized shared memory is
> > reachable from user-space? AFAICT, TEE_IOC_OPEN_SESSION and
> > TEE_IOC_INVOKE relies on shm->id to access underlying shared memory
> > (via tee_shm_get_from_id()) and that is only known to user-space after
> > TEE_IOC_SHM_ALLOC or TEE_IOC_SHM_REGISTER return successfully.
> >
>
> Hi
>
> The IDR does not hand out high-entropy identifiers that userspace is
> unable to guess. We can very easily provoke NULL pointer dereferences
> in the kernel when running syzkaller on the TEE device because
> shm->dmabuf has not yet been assigned.
>
> It is also a general best practice that an object shall only be
> available through an API once it is fully initialized. Else undefined
> behavior will come back and bite us.
>

Okay, I see the fuzzing scenario where a kernel crash can be caused.
So I take this fix as user-space shouldn't be able to crash the
kernel.

Please do add all these details to the commit description along with
the possible kernel crash trace.

-Sumit

> BR,
>   Lars

--===============4215863635508054680==--

