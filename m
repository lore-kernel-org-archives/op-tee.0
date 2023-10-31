From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] Documentation: Destage TEE subsystem documentation
Date: Tue, 31 Oct 2023 16:06:13 +0530
Message-ID: 
 <CAFA6WYPC83ZOocdUo0V=RfG5RQZosqK0jHdELPP3M2bFNGYJYQ@mail.gmail.com>
In-Reply-To: <0de17ec7-b692-4d1e-b059-c5f3f619e94a@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2909132676897966614=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2909132676897966614==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Vegard,

Thanks for your feedback.

On Tue, 31 Oct 2023 at 15:46, Vegard Nossum <vegard.nossum@oracle.com> wrot=
e:
>
>
> On 31/10/2023 11:07, Sumit Garg wrote:
> > Add a separate documentation directory for TEE subsystem since it is a
> > standalone subsystem which already offers devices consumed by multiple
> > different subsystem drivers.
> >
> > Split overall TEE subsystem documentation modularly where the first
> > module covers the overview of TEE subsystem itself along with generic
> > features. Then the further modules are dedicated to different TEE
> > implementations like:
> > - OP-TEE
> > - AMD-TEE
> > - and so on for future TEE implementation support.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   Documentation/staging/index.rst  |   1 -
> >   Documentation/staging/tee.rst    | 364 -------------------------------
> >   Documentation/subsystem-apis.rst |   1 +
> >   Documentation/tee/amd-tee.rst    |  90 ++++++++
> >   Documentation/tee/index.rst      |  19 ++
> >   Documentation/tee/op-tee.rst     | 166 ++++++++++++++
> >   Documentation/tee/tee.rst        | 122 +++++++++++
> >   MAINTAINERS                      |   2 +-
> >   8 files changed, 399 insertions(+), 366 deletions(-)
> >   delete mode 100644 Documentation/staging/tee.rst
> >   create mode 100644 Documentation/tee/amd-tee.rst
> >   create mode 100644 Documentation/tee/index.rst
> >   create mode 100644 Documentation/tee/op-tee.rst
> >   create mode 100644 Documentation/tee/tee.rst
>
> A comment from the peanut gallery:
>
> The old tee.rst starts out describing the userspace API (include/uapi/,
> /dev/tee, etc.). Maybe this part should go into
> Documentation/userspace-api/.
>
> The rest of the document describes the internal kernel API (how to write
> a TEE driver). And maybe this part should go into Documentation/driver-api/.
>
> At least I think that kind of split is what the documentation is going
> for in the long term, so if you're moving these files around anyway it
> might make sense to do it right away.
>

It makes perfect sense. I will do that for v2 but let me wait for any
further feedback on v1.

-Sumit

>
> Vegard

--===============2909132676897966614==--

